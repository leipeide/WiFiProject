package com.waho.dao.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.waho.dao.AlarmDao;
import com.waho.domain.Alarm;
import com.waho.domain.Node;
import com.waho.util.C3P0Utils;


public class AlarmDaoImpl implements AlarmDao{

	@Override
	public List<Alarm> selectAlarmByUserid(int userid) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from alarm where userid=?",new BeanListHandler<>(Alarm.class),userid);
	}

	@Override
	public int deleteAlarmById(int id) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("delete from alarm where id=?",id);
	}

	@Override
	public int insertUnconnectAlarm(Alarm alarm) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());	
		return qr.update(
				"INSERT INTO alarm (`userid`, `mac`, `type`, `power`, `temperature`, `date`) VALUES (?, ?, ?, ?, ?, ?)",
				alarm.getUserid(), alarm.getMac(), alarm.getType(), alarm.getPower(), alarm.getTemperature(), alarm.getDate());
	}

	@Override 
	public Alarm selectAlarmByUseridAndMacAndType(int userid, String mac, int type) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from alarm where userid=? and mac=? and type=?",new BeanHandler<>(Alarm.class), userid, mac, type);
	}

	@Override
	public void updateAlarmDateById(int id, Date date) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("update alarm set date=? where id=?", date, id);
		
	}

	
	
}
