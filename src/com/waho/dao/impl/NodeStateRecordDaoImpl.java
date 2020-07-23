package com.waho.dao.impl;

import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.waho.dao.NodeStateRecordDao;
import com.waho.domain.Node;
import com.waho.domain.NodeStateRecord;
import com.waho.util.C3P0Utils;

public class NodeStateRecordDaoImpl implements NodeStateRecordDao {

	@Override
	public void insertRecord(NodeStateRecord nsRecode) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("INSERT INTO node_status_record (`date`, `recordtype`, `mac`, `status`, "
				+ "`percentage`, `toning`, `lux`, `userid`, `param1`, `param2`) VALUES (?,?,?,?,?,?,?,?,?,?)",
				nsRecode.getDate(), nsRecode.getRecordType(), nsRecode.getMac(), nsRecode.isStatus(),
				nsRecode.getPercentage(), nsRecode.getToning(), nsRecode.getLux(), nsRecode.getUserid(),
				nsRecode.getParam1(), nsRecode.getParam2());	
		
	}

	@Override
	public NodeStateRecord selectNewNodeStateRecord(Node node) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.query("select *from node_status_record where mac = ? order by id DESC limit 1",
				new BeanHandler<NodeStateRecord>(NodeStateRecord.class), node.getMac());
	}

	
}
