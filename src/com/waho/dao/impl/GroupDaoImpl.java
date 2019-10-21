package com.waho.dao.impl;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.waho.dao.GroupDao;
import com.waho.domain.Group;
import com.waho.domain.GroupNode;
import com.waho.domain.Node;
import com.waho.util.C3P0Utils;


public  class GroupDaoImpl implements GroupDao{

	@Override
	public int insertGroup(Group group) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
	///*	
		return qr.update("INSERT INTO `wifi_project`.`group_table` (`groupName`, `userid`, `switchStatus`, `type`, `lastOperateType`, `param2`,`nodeNum`) VALUES (?,?,?,?,?,?,?)",
				group.getGroupName(),group.getUserid(),group.getSwitchStatus(),group.getType(),
				group.getLastOperateType(),group.getParam2(),group.getNodeNum());
	//*/	
		/*
		return qr.update("INSERT INTO `wifitest`.`group_table` (`groupName`, `userid`, `switchStatus`, `type`, `lastOperateType`, `param2`,`nodeNum`) VALUES (?,?,?,?,?,?,?)",
				group.getGroupName(),group.getUserid(),group.getSwitchStatus(),group.getType(),
				group.getLastOperateType(),group.getParam2(),group.getNodeNum());
	*/	
	}

	@Override
	public List<Group> selectGroupByUseridAndType(int userid, int type) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from group_table where userid=? and type=?", new BeanListHandler<>(Group.class),userid,type);
		
	}

	@Override
	public void updateOnlineNum(int onlineNum,int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("UPDATE group_table SET onlineNum=? WHERE groupid=?",onlineNum,groupid);
	}

	@Override
	public Group selectGroupByGroupid(int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select * from group_table where groupid=?", new BeanHandler<>(Group.class), groupid);
	}

	@Override
	public void updateOfflineNum(int offlineNum,int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("UPDATE group_table SET offlineNum=? WHERE groupid=?",offlineNum,groupid);
		
	}

	@Override
	public Group selectGroupByGroupNameAndUserid(String groupName, int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from group_table where groupName=? and userid=?",new BeanHandler<>(Group.class), groupName,userid);
	}

	@Override
	public int deleteGroupByGroupid(int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("delete from group_table where groupid=?", groupid);
	}

	@Override
	public int updateGroupNameByUseridAndGroupid(int userid, int groupid, String groupName) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("update group_table SET groupName=? where groupid=? and userid=?", groupName, groupid, userid);
	}

	@Override
	public int updateGroupswitchStatusByGroupid(int switchState,int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("update group_table SET switchStatus=? where groupid=?", switchState, groupid);
	}

	@Override
	public Group selectGroupByGroupidAndUserid(int userid, int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from group_table where userid=? and groupid=?",new BeanHandler<>(Group.class),userid,groupid);
	}

	@Override
	public int updateOnlineNumAndOfflineNum(int onlineNum, int offlineNum, int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE group_table SET onlineNum=?, offlineNum=? WHERE groupid=?",onlineNum,offlineNum,groupid);
	}

	@Override
	public void updataNodeNumByGroupid(int nodeNum, int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("UPDATE group_table SET nodeNum=? WHERE groupid=?",nodeNum,groupid);
		
	}

	@Override
	public void updateLastOperateTypeByGroupid(String operateType, int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("UPDATE group_table SET lastOperateType=? WHERE groupid=?",operateType,groupid);
		
	}

	
	
	
	

}
