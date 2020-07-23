package com.waho.websocket;

import java.util.Date;

import com.alibaba.fastjson.JSON;
import com.waho.dao.NodeDao;
import com.waho.dao.NodeStateRecordDao;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.dao.impl.NodeStateRecordDaoImpl;
import com.waho.domain.Message;
import com.waho.domain.Node;
import com.waho.domain.NodeStateRecord;

public class WebSocketRequestHandler {
	//private static Logger logger = Logger.getRootLogger();
	/**
	 * 处理request指令
	 * 
	 * @param requestStr
	 */
	public static void RequestHandle(String requestStr, WebSocketServlet servlet) {
		Message msg = JSON.parseObject(requestStr, Message.class);   //字符串转对象requestStr转为msg对象
		if (msg.getMsg().equals("request")) {
			loginHandle(msg, servlet);
			heartbeatHandle(msg, servlet);
		}
	}
	
	/**
	 * 处理心跳包请求
	 * 
	 * @param msg
	 * @param servlet
	 */
	private static void heartbeatHandle(Message msg, WebSocketServlet servlet) {
		NodeStateRecord nsRecord = new NodeStateRecord();
		NodeStateRecordDao nsrDao = new NodeStateRecordDaoImpl();
		if (msg.getCmd().equals("heartbeat")) {
			if (msg.getMac() != null) {
				try {
					//2.对心跳包进行回复
					Message rep = new Message();
					rep.setMsg("response");
					rep.setCmd("heartbeat");
					rep.setMac(msg.getMac());
					rep.setErr(0);
					String repStr = JSON.toJSONString(rep);
					// 将servlet的timeCount清零
					servlet.setTimeCount(0);
					servlet.sendMessage(repStr);
					
					/**利用心跳包实时判断节点的状态，并实时记录节点的变化。
					 *该方法调用太频繁，已弃用；
					 *现采用服务器拦截器每小时对所有节点状态进行读取并记录到数据库，进行巡检报警
					 */
							
					/**	//1.读数据库，对节点当前状态与数据库状态进行对比
					 * NodeDao nodeDao = new NodeDaoImpl();
					//获取节点此时在数据库内信息
					Node selectResult = nodeDao.selectNodeById(servlet.getId());
					//心跳包上传的节点对象
					Node node = new Node();
					node.setMac(msg.getMac());
					node.setType(msg.getType());
					node.setOnline(true);
					node.setPower(msg.getPower());
					node.setSsid(msg.getSsid());
					node.setPw(msg.getPw());
					node.setPrecentage(msg.getPrecentage());
					node.setSwitchState(msg.getSwitchState());
					node.setColorPrecentage(msg.getColorPrecentage());
					node.setLux(msg.getLux());
					*/
					// 注意：温湿度暂时无，暂留
					//node.setTemperature(msg.getTemperature());
					//node.setHumidity(msg.getHumidity());
					/**
					 * 若心跳包上传的状态与数据库存储不同，
					 * 进行更新节点属性，且添加节点状态记录到数据库
					 * 注意：若节点后续添加了其他的属性，则此处需要添加新的判断条件
					 */
				/**	if (selectResult.getType() == node.getType()
							&& selectResult.getPower() == node.getPower()
							&& selectResult.getSsid().equals(node.getSsid()) 
							&& selectResult.getPw().equals(node.getPw())
							&& selectResult.getPrecentage() == node.getPrecentage()
							&& selectResult.getSwitchState() == node.getSwitchState()
							&& selectResult.getColorPrecentage() == node.getColorPrecentage()
							&& selectResult.getLux() == node.getLux()) {
						
						// 若心跳包上传的状态与数据库存储相同，不做处理
						
						} else {
							// 若心跳包上传的状态与数据库存储不同，进行更新
							nodeDao.updateByMac(node);
							// 节点状态发生变化，插入节点状态记录
							Node nodeObj = nodeDao.selectNodeByMac(node.getMac());
							Date date = new Date();
							nsRecord.setDate(date);
							nsRecord.setUserid(nodeObj .getUserid());
							nsRecord.setMac(nodeObj .getMac());
							nsRecord.setLux(nodeObj .getLux());
							nsRecord.setPercentage(nodeObj .getPrecentage());
							nsRecord.setRecordType(NodeStateRecord.RECORD_TYPE_UPDATE);
							nsRecord.setToning(nodeObj.getColorPrecentage());
							if(node.getSwitchState() == 1) { //开灯状态
								nsRecord.setStatus(true);
							}else { //关灯状态
								nsRecord.setStatus(false);
							}
							nsrDao.insertRecord(nsRecord);
							
						}
						*/
						
						
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
			 }
		
		}
	}

	/**
	 * 处理登录请求
	 * 
	 * @param msg
	 */
	private static void loginHandle(Message msg, WebSocketServlet servlet) {
		NodeDao nodeDao = new NodeDaoImpl();
		NodeStateRecord nsRecord = new NodeStateRecord();
		NodeStateRecordDao nsrDao = new NodeStateRecordDaoImpl();
		
		if (msg.getCmd().equals("login")) {
			if (msg.getMac() != null) {
				try {
					//1.记录节点属性信息
					Node node = new Node();
					node.setMac(msg.getMac());
					node.setUserid(1000);
					node.setType(msg.getType());
					node.setNodeName(msg.getMac());
					node.setOnline(true);
					node.setPower(msg.getPower());
					node.setSsid(msg.getSsid());
					node.setPw(msg.getPw());
					node.setPrecentage(msg.getPrecentage());
					node.setSwitchState(msg.getSwitchState());
					node.setColorPrecentage(msg.getColorPrecentage());
					node.setLux(msg.getLux());
					// 注意：温湿度暂时无，暂留
					//node.setHumidity(msg.getHumidity());
					//node.setTemperature(msg.getTemperature());
					Node selectResult = nodeDao.selectNodeByMac(node.getMac());
					if (selectResult == null) { //初次登陆
						node.setGroupState(0);//设置节点的分组状态
						nodeDao.insert(node); //插入新节点
					} else { //非初次登陆
						nodeDao.updateByMac(node);
					}
					
					//2.记录用户wifi调光指令导致的节点发生状态变化记录
					Node nodeObj = nodeDao.selectNodeByMac(node.getMac());
					Date date = new Date();
					nsRecord.setDate(date);
					nsRecord.setUserid(nodeObj.getUserid());
					nsRecord.setMac(nodeObj.getMac());
					nsRecord.setLux(nodeObj.getLux());
					nsRecord.setPercentage(nodeObj.getPrecentage());
					nsRecord.setRecordType(NodeStateRecord.RECORD_TYPE_UPDATE);
					nsRecord.setToning(nodeObj.getColorPrecentage());
					if(nodeObj.getSwitchState() == 1) { //开灯状态
						nsRecord.setStatus(false);
					}else { //关灯状态
						nsRecord.setStatus(true);
					}
					nsrDao.insertRecord(nsRecord);
					
					//3.判断是否有另外一个id相同的session，若有，将其关闭
					selectResult = nodeDao.selectNodeByMac(node.getMac());
					servlet.setId(selectResult.getId());
					for (WebSocketServlet temp : WebSocketServlet.webSocketSet) {
						if (temp.getId() == servlet.getId() && temp.equals(servlet) == false) {
							temp.setId(0);
							temp.getSession().close();
							break;
						}
					}
						
					//4.服务器回复节点登录指令	
					Message rep = new Message();
					rep.setMsg("response");
					rep.setCmd("login");
					rep.setMac(node.getMac());
					rep.setErr(0);
					String repStr = JSON.toJSONString(rep);						
					servlet.setTimeCount(0);
					servlet.sendMessage(repStr);
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}


}
