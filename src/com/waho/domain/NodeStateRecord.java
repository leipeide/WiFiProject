package com.waho.domain;

import java.util.Date;

public class NodeStateRecord {
		/**
		 * 写灯指令（on,off,pwmDim）
		 */
		public static String CMD_WRITE = "cmd_write"; 
		/**
		 * 自动lux调光指令
		 */
		public static String CMD_AUTOLUX = "cmd_autolux"; 
		/**
		 * 调色指令
		 */
		public static String CMD_TONING = "cmd_toning"; 	
		/**
		 * 节点状态记录类型update：节点主动上报的节点状态（登陆指令，心跳包, 读灯指令）
		 */
		public static String RECORD_TYPE_UPDATE = "update";
		/*
		 * 节点状态信息记录id,主键
		 */
		private int id;
		/*
		 * 记录时间 
		 */
		private Date date; 
		/*
		 * 节点状态记录类型：
		 * cmd(用户发送指令导致状态改变)
		 * update(节点主动上报节点状态改变)
		 */
		private String recordType;
		/*
		 * 节点地址
		 */
		private String mac;
		/*
		 * 开关灯状态：false关灯，true开灯
		 */
		private boolean status;
		/*
		 * pwm调光比例
		 */
		private int percentage;
		/*
		 * 调色比例
		 */
		private int toning;
		/*
		 * lux调光参数
		 */
		private int lux;
		/*
		 *用户id 
		 */
		private int userid;
		/*
		 * 预留参数
		 */
		private String param1;
		/*
		 * 预留参数
		 */
		private String param2;
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public Date getDate() {
			return date;
		}
		public void setDate(Date date) {
			this.date = date;
		}
		public String getRecordType() {
			return recordType;
		}
		public void setRecordType(String recordType) {
			this.recordType = recordType;
		}
		public String getMac() {
			return mac;
		}
		public void setMac(String mac) {
			this.mac = mac;
		}
	
		public boolean isStatus() {
			return status;
		}
		public void setStatus(boolean status) {
			this.status = status;
		}
		public int getPercentage() {
			return percentage;
		}
		public void setPercentage(int percentage) {
			this.percentage = percentage;
		}
		public int getToning() {
			return toning;
		}
		public void setToning(int toning) {
			this.toning = toning;
		}
		public int getLux() {
			return lux;
		}
		public void setLux(int lux) {
			this.lux = lux;
		}
		public int getUserid() {
			return userid;
		}
		public void setUserid(int userid) {
			this.userid = userid;
		}
		public String getParam1() {
			return param1;
		}
		public void setParam1(String param1) {
			this.param1 = param1;
		}
		public String getParam2() {
			return param2;
		}
		public void setParam2(String param2) {
			this.param2 = param2;
		}
		@Override
		public String toString() {
			return "NodeStateRecord [id=" + id + ", date=" + date + ", recordType=" + recordType + ", mac=" + mac
					+ ", status=" + status + ", percentage=" + percentage + ", toning=" + toning + ", lux=" + lux
					+ ", userid=" + userid + ", param1=" + param1 + ", param2=" + param2 + "]";
		}
		
}
