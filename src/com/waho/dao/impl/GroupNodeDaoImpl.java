package com.waho.dao.impl;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.waho.dao.GroupNodeDao;
import com.waho.domain.GroupNode;
import com.waho.domain.Node;
import com.waho.util.C3P0Utils;

public class GroupNodeDaoImpl implements GroupNodeDao{

	@Override
	public List<GroupNode> selectNodeByGroupid(int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from group_node where groupid=? ", new BeanListHandler<>(GroupNode.class), groupid);
	}

	@Override
	public GroupNode selectNodeByMac(String mac) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from group_node where mac=? ", new BeanHandler<>(GroupNode.class), mac);
	}

	@Override
	public int insertNodeToGroupByGroupid(GroupNode groupNode) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("INSERT INTO group_node (`groupid`, `userid`, `mac`, `param1`, `param2`, `param3`, `param4`) VALUES (?,?,?,?,?,?,?)",
				groupNode.getGroupid(),groupNode.getUserid(),groupNode.getMac(),
				groupNode.getParam1(),groupNode.getParam2(),groupNode.getParam3(),
				groupNode.getParam4());	
	
	}

	@Override
	public int deleteGroupNodeByGroupid(int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("delete from group_node where groupid=?", groupid);
	}


	@Override
	public List<GroupNode> selectNodesByUseridAndGroupid(int userid, int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from group_node where groupid=? and userid=?", new BeanListHandler<>(GroupNode.class), groupid, userid);
	}

	@Override
	public int deleteGroupNodeByGroupidAndNodeMac(String mac, int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("delete from group_node where groupid=? and mac=?", groupid,mac);
	}

	@Override
	public GroupNode selectNodeByUseridAndMac(int userid, String mac) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from group_node where mac=? and userid=?", new BeanHandler<>(GroupNode.class), mac, userid);
	}

	
	
	

}
