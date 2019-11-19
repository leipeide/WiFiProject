package com.waho.dao.impl;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.waho.dao.PloyDao;
import com.waho.domain.Node;
import com.waho.domain.Ploy;
import com.waho.util.C3P0Utils;

public class PloyDaoImpl implements PloyDao {

	@Override
	public List<Ploy> selectPloyByUseridAndGroupType(int userid, int groupType) throws Exception{
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from ploy where userid=? and groupType=?",new BeanListHandler<>(Ploy.class), userid,groupType);
	}

	@Override
	public List<Ploy> selectPloyByUseridAndPloyName(int userid, String ployName) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from ploy where userid=? and ployName=?", new BeanListHandler<>(Ploy.class), userid,ployName);
	}

	@Override
	public int insertPloy(Ploy ploy) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
	///*	
	 	return qr.update(
				"INSERT INTO ploy (`userid`, `ployName`, `runState`, `groupid`, `groupType`, `param1`, `param2`, `param3`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
				ploy.getUserid(),ploy.getPloyName(),ploy.getRunState(),ploy.getGroupid(),ploy.getGroupType(),ploy.getParam1(),ploy.getParam2(),ploy.getParam3()
				);
	//	*/		
		/*
		return qr.update(
				"INSERT INTO `wifitest`.`ploy` (`userid`, `ployName`, `runState`, `groupid`, `groupType`, `param1`, `param2`, `param3`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
				ploy.getUserid(),ploy.getPloyName(),ploy.getRunState(),ploy.getGroupid(),ploy.getGroupType(),ploy.getParam1(),ploy.getParam2(),ploy.getParam3()
				);
		*/
	}

	@Override
	public int updatePloyNameByUseridAndPloyid(int userid, int ployid, String ployName) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE ploy SET ployName=? WHERE userid=? and id=?",ployName,userid,ployid);
	}

	@Override
	public int deletePloyByUseridAndPloyid(int userid, int ployid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("delete from ploy where userid=? and id=?", userid,ployid);
	}

	@Override
	public int updateRunStateByUseridAndId(int userid, int ployid, int runState) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("update ploy SET runState=? where userid=? and id=?", runState,userid,ployid);
	
	}

	@Override
	public List<Ploy> selectPloyByUserid(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from ploy where userid=?",new BeanListHandler<>(Ploy.class), userid);
	}

	@Override
	public Ploy selectPloyByPloyidAndUserids(int ployid, int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from ploy where userid=? and id=?",new BeanHandler<>(Ploy.class), userid,ployid);
	}

	@Override
	public int updateGroupidByPloyid(int ployid, int groupid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("update ploy SET groupid=? where id=?", groupid,ployid);
	}
	
	
	
}
