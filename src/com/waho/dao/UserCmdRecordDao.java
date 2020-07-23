package com.waho.dao;

import com.waho.domain.Node;
import com.waho.domain.UserCmdRecord;

public interface UserCmdRecordDao {
	/**
	 * 向数据库内插入用户指令记录
	 * @param userCmdRecord
	 */
	void insertUserCmdRecord(UserCmdRecord userCmdRecord)throws Exception;
	/**
	 * 根据节点地址查询节点发送的最后一条用户指令
	 * @param nodeObj
	 * @return
	 * @throws Exception
	 */
	UserCmdRecord selectNodeLastCmdByMacAndUserid(Node nodeObj)throws Exception;


}
