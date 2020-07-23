package com.waho.dao;

import com.waho.domain.Node;
import com.waho.domain.NodeStateRecord;

public interface NodeStateRecordDao {
	/**
	 * 向数据库中插入节点状态记录
	 * @param nsRecode
	 */
	void insertRecord(NodeStateRecord nsRecode)throws Exception;
	/**
	 * 查找节点最新的节点状态记录
	 * @param node 
	 * @return
	 */
	NodeStateRecord selectNewNodeStateRecord(Node node)throws Exception;

}
