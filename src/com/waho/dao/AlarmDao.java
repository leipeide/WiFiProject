package com.waho.dao;

import java.util.Date;
import java.util.List;

import com.waho.domain.Alarm;



public interface AlarmDao {
	/**
	 * 查询用户下的报警信息
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	List<Alarm> selectAlarmByUserid(int userid)throws Exception;
	/**
	 * 根据报警信息id删除报警信息
	 * @param id 
	 * @return
	 */
	int deleteAlarmById(int id)throws Exception;
	/**
	 * 插入节点无连接报警
	 * @param alarm
	 * @throws Exception
	 */
	int insertUnconnectAlarm(Alarm alarm)throws Exception;
	/**
	 * 根据用户id，节点mac地址，报警类型查找报警信息
	 * @param userid
	 * @param mac
	 * @param type
	 * @return
	 * @throws Exception
	 */
	Alarm selectAlarmByUseridAndMacAndType(int userid, String mac, int type)throws Exception;
	/**
	 * 根据报警id更新节点无连接时的报警时间
	 * @param id
	 * @param date
	 * @throws Exception
	 */
	void updateAlarmDateById(int id, Date date)throws Exception;
	/**
	 * 插入报警记录
	 * @param alarm
	 */
    void insert(Alarm alarm)throws Exception;
    /**
     * 根据节点mac和节点报警类型查找该节点的某一报警类型记录集合
     * @param alarmDisconnect
     * @param mac
     * @return
     */
	List<Alarm> selectAlarmByMacAndAlarmType(int alarmType, String mac)throws Exception;
	/**
	 * 根据报警记录id更新报警记录
	 * @param id
	 * @param alarm
	 */
	void updataAlarmRecordById(int id, Alarm alarm)throws Exception;
	

}
