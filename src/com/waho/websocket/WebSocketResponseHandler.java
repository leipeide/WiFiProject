package com.waho.websocket;

import java.util.Date;

import javax.websocket.Session;

import com.alibaba.fastjson.JSON;
import com.waho.dao.NodeDao;
import com.waho.dao.NodeStateRecordDao;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.dao.impl.NodeStateRecordDaoImpl;
import com.waho.domain.Message;
import com.waho.domain.Node;
import com.waho.domain.NodeStateRecord;

import jdk.nashorn.internal.runtime.regexp.joni.constants.NodeStatus;

public class WebSocketResponseHandler {
	/**
	 * 处理response指令
	 * @param message
	 * @param session
	 */
	public static void responseHandle(String responseStr, Session session) {
		Message msg = JSON.parseObject(responseStr, Message.class);
		if (msg.getMsg().equals("response")) {
			writeHandle(session, msg);
			readHandle(session, msg);
			toningHandle(session,msg);
			wifidimHandle(session,msg);
		}
	}

	/**
	 * 无线调光器写调光指令回复（pwm调光，lux自动调光）
	 * @param session
	 * @param msg
	 */
	private static void wifidimHandle(Session session, Message msg) {
		NodeDao nodeDao = new NodeDaoImpl();
		NodeStateRecord nsRecord = new NodeStateRecord();
		NodeStateRecordDao nsrDao = new NodeStateRecordDaoImpl();
		
		if ((msg.getCmd().equals("pwmdim")) || (msg.getCmd().equals("autoluxdim"))
				&& msg.getErr() == 0) {
			try {
				//1.更新节点状态
				Node node = new Node();
				node.setMac(msg.getMac());
				node.setLux(msg.getLux());;
				node.setPrecentage(msg.getPrecentage());
				nodeDao.updateLuxAndPrecentageByMac(node);
				
				//2.记录用户wifi调光指令导致的节点发生状态变化记录
				Node nodeObj = nodeDao.selectNodeByMac(node.getMac());
				Date date = new Date();
				nsRecord.setDate(date);
				nsRecord.setUserid(nodeObj.getUserid());
				nsRecord.setMac(nodeObj.getMac());
				nsRecord.setLux(nodeObj.getLux());
				nsRecord.setPercentage(nodeObj.getPrecentage());
				nsRecord.setToning(nodeObj.getColorPrecentage());
				if((msg.getCmd().equals("pwmdim")) ) {
					nsRecord.setRecordType(NodeStateRecord.CMD_WRITE);
				}else{
					nsRecord.setRecordType(NodeStateRecord.CMD_AUTOLUX);
				}
				if(nodeObj.getSwitchState() == 1) { //开灯状态
					nsRecord.setStatus(true);
				}else { //关灯状态
					nsRecord.setStatus(false);
				}
				nsrDao.insertRecord(nsRecord);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	
	/**
	 * led调色指令回复
	 * @param session
	 * @param msg
	 */
	private static void toningHandle(Session session, Message msg) {
		NodeDao nodeDao = new NodeDaoImpl();
		NodeStateRecord nsRecord = new NodeStateRecord();
		NodeStateRecordDao nsrDao = new NodeStateRecordDaoImpl();
		try {
			if(msg.getCmd().equals("toning") && msg.getErr() == 0) {
				if (msg.getMac() != null) {
					//1.更新节点状态
					Node node = new Node();
					node.setMac(msg.getMac());
					node.setColorPrecentage(msg.getColorPrecentage());
					nodeDao.updateColorPrecentageByMac(node);
					//2.记录用户调色指令导致的节点发生状态变化记录
					Node nodeObj = nodeDao.selectNodeByMac(node.getMac());
					Date date = new Date();
					nsRecord.setDate(date);
					nsRecord.setUserid(nodeObj.getUserid());
					nsRecord.setMac(nodeObj.getMac());
					nsRecord.setLux(nodeObj.getLux());
					nsRecord.setPercentage(nodeObj.getPrecentage());
					nsRecord.setRecordType(NodeStateRecord.CMD_TONING);
					nsRecord.setToning(nodeObj.getColorPrecentage());
					if(nodeObj.getSwitchState() == 1) { //开灯状态
						nsRecord.setStatus(true);
					}else { //关灯状态
						nsRecord.setStatus(false);
					}
					nsrDao.insertRecord(nsRecord);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block			
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 读节点指令回复
	 * @param session
	 * @param msg
	 */
	private static void readHandle(Session session, Message msg) {
		NodeDao nodeDao = new NodeDaoImpl();
		NodeStateRecord nsRecord = new NodeStateRecord();
		NodeStateRecordDao nsrDao = new NodeStateRecordDaoImpl();
		try {
			if (msg.getCmd().equals("read") && msg.getErr() == 0) {
				if (msg.getMac() != null) {
					//1.更新节点状态
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
					nodeDao.updateByMac(node);
					//2.记录读指令导致的节点发生状态变化记录
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
						nsRecord.setStatus(true);
					}else { //关灯状态
						nsRecord.setStatus(false);
					}
					nsrDao.insertRecord(nsRecord);
					
		  	  	}
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 写节点状态指令回复（开灯、关灯、pwm调光）
	 * @param session
	 * @param msg
	 */
	private static void writeHandle(Session session, Message msg) {
		NodeDao nodeDao = new NodeDaoImpl();
		NodeStateRecord nsRecord = new NodeStateRecord();
		NodeStateRecordDao nsrDao = new NodeStateRecordDaoImpl();
		try {
			if (msg.getCmd().equals("write") && msg.getErr() == 0) {
				//1.更新节点状态
				Node node = new Node();
				node.setMac(msg.getMac());
				node.setPrecentage(msg.getPrecentage());
				node.setSwitchState(msg.getSwitchState());
				nodeDao.updatePrecentageAndSwitchStateByMac(node);
				//2.记录用户写节点指令导致的节点发生状态变化记录
				Node nodeObj = nodeDao.selectNodeByMac(node.getMac());
				Date date = new Date();
				nsRecord.setDate(date);
				nsRecord.setUserid(nodeObj.getUserid());
				nsRecord.setMac(nodeObj.getMac());
				nsRecord.setLux(nodeObj.getLux());
				nsRecord.setPercentage(nodeObj.getPrecentage());
				nsRecord.setRecordType(NodeStateRecord.CMD_WRITE);
				nsRecord.setToning(nodeObj.getColorPrecentage());
				if(nodeObj.getSwitchState() == 1) { //开灯状态
					nsRecord.setStatus(true);
				}else { //关灯状态
					nsRecord.setStatus(false);
				}
				nsrDao.insertRecord(nsRecord);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


}
