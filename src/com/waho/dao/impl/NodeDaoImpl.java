package com.waho.dao.impl;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.waho.dao.NodeDao;
import com.waho.domain.GroupNode;
import com.waho.domain.Node;
import com.waho.util.C3P0Utils;

public class NodeDaoImpl implements NodeDao {

	@Override
	public List<Node> selectNodesByUserid(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		List<Node> list = qr.query("select * from node where userid=?", new BeanListHandler<>(Node.class), userid);
		return list;
	}
	
	@Override
	public int insert(Node node) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
	///*	
	 	return qr.update(
				"INSERT INTO node (`mac`, `nodeName`, `type`, `power`, `precentage`, `switchState`, `ssid`, `pw`, `userid`, `temperature`, `humidity`, `online`, `lux`, `colorPrecentage`,`groupState`,`lastOperateType`,`param2`,`param3`,`param4`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
				node.getMac(), node.getNodeName(), node.getType(), node.getPower(), node.getPrecentage(),
				node.getSwitchState(), node.getSsid(), node.getPw(), node.getUserid(), node.getTemperature(),
				node.getHumidity(), node.isOnline(),node.getLux(),node.getColorPrecentage(),node.getGroupState(),
				node.getLastOperateType(),node.getParam2(),node.getParam3(),node.getParam4()
				);
		//*/		
		/*
		return qr.update(
				"INSERT INTO `wifitest`.`node` (`mac`, `nodeName`, `type`, `power`, `precentage`, `switchState`, `ssid`, `pw`, `userid`, `temperature`, `humidity`, `online`, `lux`, `colorPrecentage`,`groupState`,`lastOperateType`,`param2`,`param3`,`param4`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
				node.getMac(), node.getNodeName(), node.getType(), node.getPower(), node.getPrecentage(),
				node.getSwitchState(), node.getSsid(), node.getPw(), node.getUserid(), node.getTemperature(),
				node.getHumidity(), node.isOnline(),node.getLux(),node.getColorPrecentage(),node.getGroupState(),
				node.getLastOperateType(),node.getParam2(),node.getParam3(),node.getParam4()
				);
		*/	
	}

	@Override
	public Node selectNodeByMac(String mac) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		Node node = qr.query("select * from node where mac=?", new BeanHandler<>(Node.class), mac);
		return node;
	}

	@Override
	public int updateByMac(Node node) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE node SET type=?, power=?, online=?, precentage=?, switchState=?, ssid=?, pw=?, lux=?, colorPrecentage=? WHERE mac=?",
				node.getType(), node.getPower(), true, node.getPrecentage(), node.getSwitchState(), node.getSsid(),
				node.getPw(), node.getLux(), node.getColorPrecentage(), node.getMac());
	}

	@Override
	public int updatePrecentageAndSwitchStateByMac(Node node) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE node SET precentage=?, switchState=? WHERE mac=?", node.getPrecentage(),
				node.getSwitchState(), node.getMac());
	}

	@Override
	public Node selectNodeById(int id) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		Node node = qr.query("select * from node where id=?", new BeanHandler<>(Node.class), id);
		return node;
	}

	@Override
	public int updateOnlineById(boolean b, int id) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE node SET online=? WHERE id=?", b, id);
	}

	@Override
	public int updateNodeNameById(int id, String nodeName) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE node SET nodeName=? WHERE id=?", nodeName, id);
	}

	@Override
	public int[] updateUseridByid(int userid, List<Integer> idList) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		Object[][] params = new Object[idList.size()][];
		for (int i = 0; i < idList.size(); i++) {
			params[i] = new Object[]{1000,0, idList.get(i)};
		}
		return qr.batch("UPDATE node SET userid=?,groupState=? WHERE id=?", params);
	}

	@Override
	public List<Node> selectOnlineNodesByUserid(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		List<Node> list = qr.query("select * from node where userid=? and online=?", new BeanListHandler<>(Node.class), userid, true);
		return list;
	}

	@Override
	public int updateColorPrecentageByMac(Node node) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE node SET colorPrecentage=? WHERE mac=?",node.getColorPrecentage(),node.getMac());
		
	}
	
	@Override
	public int updateLuxByMac(Node node) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE node SET lux=? WHERE mac=?",node.getLux(),node.getMac());
	}

	@Override
	public void updateLuxAndPrecentageByMac(Node node) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
	    qr.update("UPDATE node SET lux=?,precentage=? WHERE mac=?",node.getLux(),node.getPrecentage(),node.getMac());
//	    qr.update("UPDATE node SET userid=?,groupState=? WHERE id=?",userid, 0, id);
	}

	@Override
	public Node selectNodeObjByMac(String mac) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from node where mac=?",new BeanHandler<>(Node.class), mac);
	}

	@Override
	public void updateGroupStateByMac(String mac, int groupState) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
	    qr.update("UPDATE node SET groupState=? where mac=?",groupState,mac);
		
	}

	@Override
	public List<Node> selectBallastNodeByUseridAndTypeAndGroupState(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from node where userid=?  and groupState=? and type > ? and type < ?", new BeanListHandler<>(Node.class),userid, 0, 0, 11);
	}
	
	@Override
	public List<Node> selectLedNodeByUseridAndTypeAndGroupState(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from node where userid=? and groupState=? and type > ? and type < ?", new BeanListHandler<>(Node.class), userid, 0, 10, 21);
	}
	
	
	@Override
	public List<Node> selectWifiNodeByUseridAndTypeAndGroupState(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from node where userid=? and groupState=? and type > ? and type < ?", new BeanListHandler<>(Node.class), userid, 0, 20, 31);
	}

	@Override
	public void updateGroupStateByMacAndUserid(GroupNode groupNode) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("UPDATE node SET groupState=? WHERE mac=? and userid=?", 0, groupNode.getMac(), groupNode.getUserid());
		
	}

	@Override
	public Node selectOnlineNodesByUseridAndMac(String mac, int userid)throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from node where userid=? and mac=? and online=?", new BeanHandler<>(Node.class),userid, mac, 1);
	}

	@Override
	public Node selectNodesByUseridAndMac(String mac, int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from node where userid=? and mac=?", new BeanHandler<>(Node.class),userid, mac);
	}

	@Override
	public List<Node> selectBallastNodeByUseridAndType(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from node where userid=? AND type>=? AND type<=?", new BeanListHandler<>(Node.class),userid,1,10);
	}

	@Override
	public List<Node> selectLedNodeByUseridAndType(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from node where userid=? AND type>=? AND type<=?", new BeanListHandler<>(Node.class),userid,11,20);
	}

	@Override
	public List<Node> selectWifiNodeByUseridAndType(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from node where userid=? AND type>=? AND type<=?", new BeanListHandler<>(Node.class),userid,21,30);
	}

	@Override
	public int updateUseridAndResetGroupState(int userid, int id) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE node SET userid=?,groupState=? WHERE id=?",userid, 0, id);
	}

	@Override
	public void updateLastOperateTypeByNodeid(String operateType, int nodeid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
	    qr.update("UPDATE node SET lastOperateType=? WHERE id=?",operateType,nodeid);
		
	}

	
	
	
}
