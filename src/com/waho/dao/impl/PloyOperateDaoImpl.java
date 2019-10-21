package com.waho.dao.impl;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.waho.dao.PloyOperateDao;
import com.waho.domain.Node;
import com.waho.domain.PloyOperate;
import com.waho.util.C3P0Utils;

public class PloyOperateDaoImpl implements PloyOperateDao {

	@Override
	public int insertPloyOperate(PloyOperate operate) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
//	/*	
	 	return qr.update("INSERT INTO `wifi_project`.`ploy_operate` (`ployid`, `ployName`,`startDate`, `endDate`, "
				+ "`hours`, `minutes`, `operateType`, `operateParam`, `state`, `param1`, `param2`) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)",operate.getPloyid(),operate.getPloyName(),operate.getStartDate(),operate.getEndDate(),operate.getHours(),
				operate.getMinutes(),operate.getOperateType(),operate.getOperateParam(),operate.getState(),operate.getParam1(),operate.getParam2());	
//	*/
	
	/*
		return qr.update("INSERT INTO `wifitest`.`ploy_operate` (`ployid`, `ployName`,`startDate`, `endDate`, "
				+ "`hours`, `minutes`, `operateType`, `operateParam`, `state`, `param1`, `param2`) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)",operate.getPloyid(),operate.getPloyName(),operate.getStartDate(),operate.getEndDate(),operate.getHours(),
				operate.getMinutes(),operate.getOperateType(),operate.getOperateParam(),operate.getState(),operate.getParam1(),operate.getParam2());	
	*/
	}

	@Override
	public List<PloyOperate> selectPloyOpertaeByPloyid(int ployid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from ploy_operate where ployid=?",new BeanListHandler<>(PloyOperate.class),ployid);
	}

	@Override
	public int deletePloyOperateByPloyid(int ployid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("delete from ploy_operate where ployid=?",ployid);
	}

	@Override
	public void updateState(PloyOperate poObj) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("UPDATE ploy_operate SET state=? WHERE id=?",poObj.getState(), poObj.getId());
	}

	@Override
	public int deletePloyOperateByid(int operateId) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("delete from ploy_operate where id=?",operateId);
	}

	

}
