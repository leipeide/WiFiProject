package com.waho.websocket;

import java.io.IOException;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.waho.dao.GroupDao;
import com.waho.dao.GroupNodeDao;
import com.waho.dao.NodeDao;
import com.waho.dao.impl.GroupDaoImpl;
import com.waho.dao.impl.GroupNodeDaoImpl;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.domain.Group;
import com.waho.domain.GroupNode;
import com.waho.domain.Message;
import com.waho.domain.Node;

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
		if (msg.getCmd().equals("heartbeat")) {
			// 读数据库，对节点当前状态进行对比
			if (msg.getMac() != null) {
				NodeDao nodeDao = new NodeDaoImpl();
				int userid;
				try {
					userid = nodeDao.selectNodeById(servlet.getId()).getUserid();
					Node node = new Node();
					node.setMac(msg.getMac());
					//注意：心跳包;原来心跳包的用户id直接设置为1000；后更改为节点所在的用户id
					//node.setUserid(1000);
					node.setUserid(userid);
					node.setType(msg.getType());
					node.setNodeName(node.getMac());
					node.setOnline(true);
					node.setPower(msg.getPower());
					node.setSsid(msg.getSsid());
					node.setPw(msg.getPw());
					node.setPrecentage(msg.getPrecentage());
					node.setSwitchState(msg.getSwitchState());
					// 注意：温湿度暂时无，暂留
					//node.setTemperature(msg.getTemperature());
					//node.setHumidity(msg.getHumidity());
					node.setColorPrecentage(msg.getColorPrecentage());
					node.setLux(msg.getLux());
					// 节点信息对比
					Node selectResult = nodeDao.selectNodeByMac(node.getMac());
					if (!selectResult.equals(node)) {
						// 若心跳包上传的状态与数据库存储不同，进行更新
						nodeDao.updateByMac(node);
					} else {
						// 若心跳包上传的状态与数据库存储相同，不做处理
					}
				
					// 对心跳包进行回复
					Message rep = new Message();
					rep.setMsg("response");
					rep.setCmd("heartbeat");
					rep.setMac(node.getMac());
					rep.setErr(0);
					String repStr = JSON.toJSONString(rep);
					// 将servlet的timeCount清零
					servlet.setTimeCount(0);
					servlet.sendMessage(repStr);
					//logger.info("Service to 客户端："+rep); //记录心跳包回复请求
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
		if (msg.getCmd().equals("login")) {
			if (msg.getMac() != null) {
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
				NodeDao nodeDao = new NodeDaoImpl();
				try {
					Node selectResult = nodeDao.selectNodeByMac(node.getMac());
					if (selectResult == null) {
						node.setGroupState(0);//初次登陆，设置节点的分组状态
						nodeDao.insert(node);
					} else {
						nodeDao.updateByMac(node);
				/*		//记录分组中的在线节点数量
						GroupNodeDao groupNodeDao = new GroupNodeDaoImpl();
						GroupDao groupDao = new GroupDaoImpl();
						GroupNode groupNode = groupNodeDao.selectNodeByMac(node.getMac());
						if(groupNode != null) {
							Group group = groupDao.selectGroupByGroupid(groupNode.getGroupid());
							int onlineNum = group.getOnlineNum() + 1;
							int offlineNum = group.getOfflineNum() - 1;
							groupDao.updateOnlineNumAndOfflineNum(onlineNum,offlineNum,group.getGroupid());
						}
						*/
					}
					selectResult = nodeDao.selectNodeByMac(node.getMac());
					servlet.setId(selectResult.getId());
					for (WebSocketServlet temp : WebSocketServlet.webSocketSet) {
						// 判断是否有另外一个id相同的session，若有，将其关闭
						if (temp.getId() == servlet.getId() && temp.equals(servlet) == false) {
							temp.setId(0);
							temp.getSession().close();
							break;
						}
					}
					
					
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

	// /**
	// * 通过session将字符串发送出去
	// * @param session
	// * @param msg
	// * @throws Exception
	// */
	// private static void sendMessage(Session session, String msg) throws Exception
	// {
	// session.getBasicRemote().sendText(msg);
	// }
}
