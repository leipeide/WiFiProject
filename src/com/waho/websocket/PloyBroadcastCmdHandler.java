package com.waho.websocket;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.waho.dao.GroupNodeDao;
import com.waho.dao.NodeDao;
import com.waho.dao.PloyDao;
import com.waho.dao.PloyOperateDao;
import com.waho.dao.UserCmdRecordDao;
import com.waho.dao.impl.GroupNodeDaoImpl;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.dao.impl.PloyDaoImpl;
import com.waho.dao.impl.PloyOperateDaoImpl;
import com.waho.dao.impl.UserCmdRecordDaoImpl;
import com.waho.domain.GroupNode;
import com.waho.domain.Message;
import com.waho.domain.Node;
import com.waho.domain.Ploy;
import com.waho.domain.PloyOperate;
import com.waho.domain.UserCmdRecord;

public class PloyBroadcastCmdHandler {
	private static Logger logger = Logger.getRootLogger();
	/**
	 * 1.处理策略广播；根据指令的时间执行策略控制内的指令：
	 * 		a.镇流器的定时发送开关灯、pwm调光指令；
	 *		b.led驱动器的定时发送开关灯、pwm调光、调色指令
	 *      c.wifi无线调光器的定时发送PWMDim调光、lux自动调光指令
	 * 2.策略操作的类型：开关灯设置为1；调光设置为2；调色设置为3；wifi自动调光设置为4； wifi pwm调光设置为5
	 * 3.关灯：operateParam设置为0; 开灯：为1;调光：为调光值0-100; 调色：为调色值0-100；lux调光：1-600000
	 * 4.为避免在到达指令时间内发送多次指令；先从用户指令集内获取该节点的最后一条用户指令记录，
	 * 判断这条记录与即将要发送的定时指令是否是同一条指令，非同一指令且时间相隔不超过1分钟，则发送定时指令
	 * @param webSocketServlet
	 * author:YanLi
	 */
	public static void SendPloyBroadcastCmd(WebSocketServlet webSocketServletObj) {
		/*
		 * 每一个webSocket对应的是一个节点，所以无法在websocket里对多个节点发送策略广播指令；
		 *只能对这个websocket对应的节点发送策略广播指令
		 */
		int nodeid = webSocketServletObj.getId();//节点id与webSocket ID绑定，故两者相等
		if(nodeid == 0) { //如果没有节点在线；不做任何操作
			
			
		}else { //存在节点在线，则进行策略操作广播判断
			try {
				Node node = new Node();
				NodeDao nodeDao = new NodeDaoImpl();
				PloyDao ployDao = new PloyDaoImpl();
				GroupNodeDao gnDao = new GroupNodeDaoImpl();
				PloyOperateDao ployOperateDao = new PloyOperateDaoImpl();
				UserCmdRecordDao userCmdRecordDao = new UserCmdRecordDaoImpl();
				//1.获取该用户下的所有策略
				node = nodeDao.selectNodeById(nodeid);
				int userid = node.getUserid();
				List<Ploy> ployList = ployDao.selectPloyByUserid(userid);
				//2.执行定时指令
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
									Date todayDate = new Date(); //此刻的时间
									if((todayDate.getTime()-  startDate.getTime()) >= 0 
											&& (endDate.getTime() - todayDate.getTime()) >= 0) { //判断是否在该日期范围内
											//得出执行任务的时间,此处为今天的定时时间
											Calendar calendar = Calendar.getInstance();
											calendar.set(Calendar.HOUR_OF_DAY, poObj.getHours()); // 控制时
											calendar.set(Calendar.MINUTE, poObj.getMinutes());    // 控制分
											calendar.set(Calendar.SECOND, 0);    // 控制秒
											Date calendarTime = calendar.getTime();//获取日历时间
											//到达发送指令的时间
											if((todayDate.getTime() - calendarTime.getTime()) >= 0
												&& (todayDate.getTime() - calendarTime.getTime()) <= 1000*10) {
												
												int operateType = poObj.getOperateType(); //策略操作指令类型
												int operateParam = poObj.getOperateParam(); //策略操作参数
												int cmdRecordType = 0; // 用户指令记录类型初始化，设置为0,不代表任何指令类型
												//查找该节点的最后一条用户指令
												UserCmdRecord nodeLastUserCmd = userCmdRecordDao.selectNodeLastCmdByMacAndUserid(nodeObj);
												//System.out.println("该节点的最后一条用户指令:"+nodeLastUserCmd.getId());
												
												//1.发送定时指令
												if(operateType == 1) { //定时开关指令
													Message cmd = new Message();
													cmd.setMsg("request");
													cmd.setCmd("write");
													cmd.setPrecentage(100); //默认调光参数为100%
													cmd.setSwitchState(operateParam);
													String lastOperateType = "";
													if(operateParam == 1) { //开灯指令
														cmdRecordType = UserCmdRecord.CMD_TIMING_OPEN;//设置用户指令记录类型：定时开灯
														lastOperateType = "open";//记录此次操作类型lastOperateType;
													}else { //关灯指令
														cmdRecordType = UserCmdRecord.CMD_TIMING_CLOSE; //设置用户指令记录类型:定时关灯
														lastOperateType = "close";//记录此次操作类型lastOperateType;
													}
													//一分钟以内该节点同一条指令已发送，则不再发送
													if(nodeLastUserCmd == null 
														|| nodeLastUserCmd.getCmdType() != cmdRecordType	
														|| nodeLastUserCmd.getParamter().equals(Integer.toString(cmd.getPrecentage())) == false
														|| (todayDate.getTime() - nodeLastUserCmd.getDate().getTime()) > 60*1000){
														//1.1发送指令	
														String cmdStr = JSON.toJSONString(cmd);
														webSocketServletObj.sendMessage(cmdStr);
														logger.info("Service to" + nodeObj.getMac() + "定时指令:" + cmd);
														//1.2更新节点最后一次操作类型
														nodeDao.updateLastOperateTypeByNodeid(lastOperateType,node.getId());
														//1.3记录定时开关指令
														UserCmdRecord userCmdRecord = new UserCmdRecord();
														String cmdRecordParamter = Integer.toString(cmd.getPrecentage()); //设置用户指令参数
														Date date = new Date(); //此刻的时间
														userCmdRecord.setDate(date); 
														userCmdRecord.setMac(nodeObj.getMac());
														userCmdRecord.setCmdType(cmdRecordType);
														userCmdRecord.setParamter(cmdRecordParamter);
														userCmdRecord.setUserid(nodeObj.getUserid());
														userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
													}else { //该指令不发送
														
														//
													}
													
													
												//2.发送定时pwm调光指令	
												}else if(operateType == 2) { //定时调光指令
													Message cmd = new Message();
													cmd.setMsg("request");
													cmd.setCmd("write");
													cmd.setPrecentage(operateParam);
													cmd.setSwitchState(nodeObj.getSwitchState());
													cmdRecordType = UserCmdRecord.CMD_TIMING_PWM;//设置用户指令记录类型:定时PWM调光
													//一分钟以内该节点同一条指令已发送，则不再发送
													if(nodeLastUserCmd == null
														|| nodeLastUserCmd.getCmdType() != cmdRecordType	
														|| nodeLastUserCmd.getParamter().equals(Integer.toString(cmd.getPrecentage())) == false
														|| (todayDate.getTime() - nodeLastUserCmd.getDate().getTime()) > 60*1000){
														//2.1发送指令	
														String cmdStr = JSON.toJSONString(cmd);
														webSocketServletObj.sendMessage(cmdStr);
														logger.info("Service to " + nodeObj.getMac() + "定时指令:" + cmd);
														//2.2记录定时指令
														UserCmdRecord userCmdRecord = new UserCmdRecord();
														String cmdRecordParamter = Integer.toString(cmd.getPrecentage()); //设置用户指令参数
														Date date = new Date(); //此刻的时间
														userCmdRecord.setDate(date); 
														userCmdRecord.setMac(nodeObj.getMac());
														userCmdRecord.setCmdType(cmdRecordType);
														userCmdRecord.setParamter(cmdRecordParamter);
														userCmdRecord.setUserid(nodeObj.getUserid());
														userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
													}else { //该指令不发送
														
														//
														
													}
													
											    //3.发送定时调色指令	
												}else if(operateType == 3){ //定时调色指令
													Message cmd = new Message();
													cmd.setMsg("request");
													cmd.setCmd("toning");
													cmd.setColorPrecentage(operateParam);
													cmdRecordType = UserCmdRecord.CMD_TIMING_TONING; //设置用户指令记录类型:定时调色
													//一分钟以内该节点同一条指令已发送，则不再发送
													if(nodeLastUserCmd == null 
														|| nodeLastUserCmd.getCmdType() != cmdRecordType	
														|| nodeLastUserCmd.getParamter().equals(Integer.toString(cmd.getColorPrecentage())) == false
														|| (todayDate.getTime() - nodeLastUserCmd.getDate().getTime()) > 60*1000){
														//3.1发送指令	
														String cmdStr = JSON.toJSONString(cmd);
														webSocketServletObj.sendMessage(cmdStr);
														logger.info("Service to " + nodeObj.getMac() + "定时指令:" + cmd);
														//3.2记录定时指令
														UserCmdRecord userCmdRecord = new UserCmdRecord();
														String cmdRecordParamter = Integer.toString(cmd.getColorPrecentage()); //设置用户指令参数
														Date date = new Date(); //此刻的时间
														userCmdRecord.setDate(date); 
														userCmdRecord.setMac(nodeObj.getMac());
														userCmdRecord.setCmdType(cmdRecordType);
														userCmdRecord.setParamter(cmdRecordParamter);
														userCmdRecord.setUserid(nodeObj.getUserid());
														userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 	
													}else { //该指令不发送
														
														//
													}
													
											   
												//4.发送定时无线调光器lux自动调光	
												}else if(operateType == 4) { //定时无线调光器lux自动调光
													Message cmd = new Message();
													cmd.setMsg("request");
													cmd.setCmd("autoluxdim"); 
													cmd.setLux(operateParam);
													cmdRecordType = UserCmdRecord.CMD_TIMING_AUTOLUX; //设置用户指令记录类型:wifi定时lux调光指令
													//一分钟以内该节点同一条指令已发送，则不再发送
													if(nodeLastUserCmd == null 
														|| nodeLastUserCmd.getCmdType() != cmdRecordType	
														|| nodeLastUserCmd.getParamter().equals(Integer.toString(cmd.getLux())) == false
														|| (todayDate.getTime() - nodeLastUserCmd.getDate().getTime()) > 60*1000){
														//4.1发送指令	
														String cmdStr = JSON.toJSONString(cmd);
														webSocketServletObj.sendMessage(cmdStr);
														logger.info("Service to " + nodeObj.getMac() + "定时指令:" + cmd);
														//4.2记录定时指令
														UserCmdRecord userCmdRecord = new UserCmdRecord();
														String cmdRecordParamter = Integer.toString(cmd.getLux()); //设置用户指令参数
														Date date = new Date(); //此刻的时间
														userCmdRecord.setDate(date); 
														userCmdRecord.setMac(nodeObj.getMac());
														userCmdRecord.setCmdType(cmdRecordType);
														userCmdRecord.setParamter(cmdRecordParamter);
														userCmdRecord.setUserid(nodeObj.getUserid());
														userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
														
													}else { //该指令不发送
														
														//
													}
												
													
											    //5.发送定时无线调光器pwm调光
												}else if(operateType == 5) { //定时无线调光器pwm调光
													Message cmd = new Message();
													cmd.setMsg("request");
													cmd.setCmd("pwmdim"); 
													cmd.setPrecentage(operateParam);
													cmdRecordType = UserCmdRecord.CMD_TIMING_PWM; //设置用户指令记录类型:wifi定时pwm调光指令
													if(nodeLastUserCmd == null 
														|| nodeLastUserCmd.getCmdType() != cmdRecordType	
														|| nodeLastUserCmd.getParamter().equals(Integer.toString(cmd.getPrecentage())) == false
												  	    || (todayDate.getTime() - nodeLastUserCmd.getDate().getTime()) > 60*1000){	
														//5.1发送指令	
														String cmdStr = JSON.toJSONString(cmd);
														webSocketServletObj.sendMessage(cmdStr);
														logger.info("Service to " + nodeObj.getMac() + "定时指令:" + cmd);
														//5.2记录定时指令
														UserCmdRecord userCmdRecord = new UserCmdRecord();
														String cmdRecordParamter = Integer.toString(cmd.getPrecentage()); //设置用户指令参数
														Date date = new Date(); //此刻的时间
														userCmdRecord.setDate(date); 
														userCmdRecord.setMac(nodeObj.getMac());
														userCmdRecord.setCmdType(cmdRecordType);
														userCmdRecord.setParamter(cmdRecordParamter);
														userCmdRecord.setUserid(nodeObj.getUserid());
														userCmdRecordDao.insertUserCmdRecord(userCmdRecord); 
															
													}else { //该指令不发送
															
															//
													 }
													
													
												}else {
													
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
	
	



