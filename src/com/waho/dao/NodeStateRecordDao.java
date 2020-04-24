package com.waho.dao;

import com.waho.domain.NodeStateRecord;

public interface NodeStateRecordDao {
	/**
	 * 向数据库中插入节点状态记录
	 * @param nsRecode
	 */
	void insertRecord(NodeStateRecord nsRecode)throws Exception;

}
