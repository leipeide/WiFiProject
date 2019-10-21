package com.waho.websocket;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.waho.dao.GroupNodeDao;
import com.waho.dao.NodeDao;
import com.waho.dao.PloyDao;
import com.waho.dao.PloyOperateDao;
import com.waho.dao.impl.GroupNodeDaoImpl;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.dao.impl.PloyDaoImpl;
import com.waho.dao.impl.PloyOperateDaoImpl;
import com.waho.domain.GroupNode;
import com.waho.domain.Message;
import com.waho.domain.Node;
import com.waho.domain.Ploy;
import com.waho.domain.PloyOperate;

public class PloyBroadcastCmdHandler {
	private static Logger logger = Logger.getRootLogger();
	/**
	 * 处理策略广播；根据指令的时间执行策略控制内的指令：目前只针对类型2（led驱动器）的功能定时发送开关灯、调光、调色指令
	 * @param webSocketServlet
	 * author:YanLi
	 */
	public static void SendPloyBroadcastCmd(WebSocketServlet webSocketServletObj) {
		
		/*每一个webSocket对应的是一个节点，所以无法在websocket里对多个节点发送策略广播指令；
		*只能对这个websocket对应的节点发送策略广播指令
		*/
		int nodeid = webSocketServletObj.getId();//节点id与webSocket ID绑定，故两者相等
		if(nodeid == 0) { //如果没有节点在线；不做任何操作
			
		}else { //存在节点在线，则进行策略操作广播判断
			
			try {
				Node node = new Node();
				//Ploy ploy = new Ploy();
				NodeDao nodeDao = new NodeDaoImpl();
				PloyDao ployDao = new PloyDaoImpl();
				GroupNodeDao gnDao = new GroupNodeDaoImpl();
				PloyOperateDao ployOperateDao = new PloyOperateDaoImpl();
				
				Date todayDate = new Date(); //今天的日期
				Calendar calendar1 = Calendar.getInstance();//设置每天清除策略操作标志位的时间2:00:00；
				calendar1.set(Calendar.HOUR_OF_DAY,2); // 控制时
				calendar1.set(Calendar.MINUTE,0);    // 控制分
				calendar1.set(Calendar.SECOND,0);    // 控制秒
				
				//1.获取该用户下的所有策略
				node = nodeDao.selectNodeById(nodeid);
				int userid = node.getUserid();
				List<Ploy> ployList = ployDao.selectPloyByUserid(userid);
				
				//2.清除策略操作标志位
				Date Calendar1time = calendar1.getTime();//获取日历时间；清除标志位的时间00:00:00
				if((todayDate.getTime() -  Calendar1time.getTime()) >= 0 && (todayDate.getTime() -  Calendar1time.getTime() <= 1000*60)) {
					logger.info("到达清除标志位的时间：");
					for(Ploy ployObj : ployList) {
						List<PloyOperate> ployOperateList = ployOperateDao.selectPloyOpertaeByPloyid(ployObj.getId());
						for(PloyOperate operate : ployOperateList) {
							operate.setState(0);
							ployOperateDao.updateState(operate);//清除标志位
						}
					}
				}
				
				//3.执行定时指令
				for(Ploy ployObj : ployList) {
					if(ployObj.getRunState() == 1) { //策略处于执行状态
						int groupid = ployObj.getGroupid();
						List<PloyOperate> ployOperateList = ployOperateDao.selectPloyOpertaeByPloyid(ployObj.getId());
						//获取与策略绑定的分组
						List<GroupNode> groupNodeList = gnDao.selectNodesByUseridAndGroupid(userid, groupid);
						for(GroupNode groupNodeObj : groupNodeList) {//得到分组内的节点并与当前websocket匹配
							//Node nodeObj = nodeDao.selectOnlineNodesByUseridAndMac(groupNodeObj.getMac(), userid);
							//查找在线节点总是得到null对象，故测试时修改为通过userid和mac查找节点
							Node nodeObj = nodeDao.selectNodesByUseridAndMac(groupNodeObj.getMac(), userid);
							if(nodeObj.getId() == nodeid) { //策略内节点与当前websocket匹配，执行策略操作处理
								for(PloyOperate poObj : ployOperateList){
									//得到策略操作的起始日期
									Date startDate = poObj.getStartDate();
									Date endDate = poObj.getEndDate();
									if(poObj.getState() == 0) { //今天该条操作未执行
										if((todayDate.getTime()-  startDate.getTime()) >= 0 && (endDate.getTime() - todayDate.getTime()) >= 0) { //判断是否在该日期范围内
											//得出执行任务的时间,此处为今天的定时时间
											Calendar calendar = Calendar.getInstance();
											calendar.set(Calendar.HOUR_OF_DAY, poObj.getHours()); // 控制时
											calendar.set(Calendar.MINUTE, poObj.getMinutes());    // 控制分
											calendar.set(Calendar.SECOND, 0);    // 控制秒
											Date calendarTime = calendar.getTime();//获取日历时间
											if((todayDate.getTime() - calendarTime.getTime()) >= 0 && (todayDate.getTime() - calendarTime.getTime()) <= 1000*60) {
												//到达发送指令的时间
												int operateType = poObj.getOperateType(); //策略操作的类型：开关灯设置为1；调光设置为2；调色设置为3
												//关灯：operateParam设置为0; 开灯：为1;调光：为调光值0-100; 调色：为调色值0-100.
												int operateParam = poObj.getOperateParam(); 
												if(operateType == 1) { //开关灯
													Message cmd = new Message();
													cmd.setMsg("request");
													cmd.setCmd("write");
													cmd.setPrecentage(100); //默认调光参数为100%
													cmd.setSwitchState(operateParam);
													String cmdStr = JSON.toJSONString(cmd);
													webSocketServletObj.sendMessage(cmdStr);
													poObj.setState(1);//策略操作标志位设置为1，已执行过
													ployOperateDao.updateState(poObj);
													logger.info("Service to" + nodeObj.getMac() + "定时指令:" + cmd);
													if(operateParam == 1) {
														//4.记录此次操作类型lastOperateType;
														String lastOperateType = "open";
														nodeDao.updateLastOperateTypeByNodeid(lastOperateType,node.getId());
													}else {
														//4.记录此次操作类型lastOperateType;
														String lastOperateType = "close";
														nodeDao.updateLastOperateTypeByNodeid(lastOperateType,node.getId());
													}
													
													
												}else if(operateType == 2) { // 调光
													Message cmd = new Message();
													cmd.setMsg("request");
													cmd.setCmd("write");
													cmd.setPrecentage(operateParam);
													cmd.setSwitchState(nodeObj.getSwitchState());
													String cmdStr = JSON.toJSONString(cmd);
													webSocketServletObj.sendMessage(cmdStr);
													poObj.setState(1);//策略操作标志位设置为1，已执行过
													ployOperateDao.updateState(poObj);
													logger.info("Service to" + nodeObj.getMac() + "定时指令:" + cmd);
													//4.记录此次操作类型lastOperateType;
													String lastOperateType = "dim";
													nodeDao.updateLastOperateTypeByNodeid(lastOperateType,node.getId());
												}else { //调色
													Message cmd = new Message();
													cmd.setMsg("request");
													cmd.setCmd("toning");
													cmd.setColorPrecentage(operateParam);
													String cmdStr = JSON.toJSONString(cmd);
													webSocketServletObj.sendMessage(cmdStr);
													poObj.setState(1);//策略操作标志位设置为1，已执行过
													ployOperateDao.updateState(poObj);
													logger.info("Service to" + nodeObj.getMac() + "定时指令:" + cmd);
													//4.记录此次操作类型lastOperateType;
													String lastOperateType = "toning";
													nodeDao.updateLastOperateTypeByNodeid(lastOperateType,node.getId());
												}
												
											}
										}
										
										
									}
									
								}
								
							}
						}
					}
				}
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
		}
	}
	
	}
	
	



