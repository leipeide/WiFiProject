package com.waho.dao.impl;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.waho.dao.UserCmdRecordDao;
import com.waho.domain.Group;
import com.waho.domain.Node;
import com.waho.domain.UserCmdRecord;
import com.waho.util.C3P0Utils;

public class UserCmdRecordDaoImpl implements UserCmdRecordDao {

	@Override
	public void insertUserCmdRecord(UserCmdRecord userCmdRecord) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("insert into user_cmd_record(`date`, `mac`, `cmdtype`, `paramter`, `userid`, `param1`, `param2`) values (?, ?, ?, ?, ?, ?, ?)",
				userCmdRecord.getDate(), userCmdRecord.getMac(), userCmdRecord.getCmdType(), 
				userCmdRecord.getParamter(),userCmdRecord.getUserid(), userCmdRecord.getParam1(),userCmdRecord.getParam2());
		
	}

	@Override
	public UserCmdRecord selectNodeLastCmdByMacAndUserid(Node nodeObj) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from user_cmd_record where mac=? order by id DESC limit 1",
				new BeanHandler<>(UserCmdRecord.class), nodeObj.getMac());
		
	}
	
	
}
