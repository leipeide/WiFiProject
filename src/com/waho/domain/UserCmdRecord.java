package com.waho.domain;

import java.util.Date;

/**
 * 记录用户的指令
 * @author liyan
 */
public class UserCmdRecord {
	/**
	 * 单节点开灯指令
	 */
	public static int CMD_OPEN = 1; 
	/**
	 * 单节点关灯指令
	 */
	public static int CMD_CLOSE = 2; 
	/**
	 * 单节点pwm调光指令
	 */
	public static int CMD_PWM = 3; 
	/**
	 * 单节点自动lux调光指令
	 */
	public static int CMD_AUTOLUX = 4 ; 
	/**
	 * 单节点调色指令
	 */
	public static int CMD_TONING = 5; 
	/**
	 * 定时开灯指令
	 */
    public static int CMD_TIMING_OPEN = 6; 
    /**
     * 定时关灯指令
     */
	public static int CMD_TIMING_CLOSE = 7; 
    /**
     * 定时pwm调光指令
     */
	public static int CMD_TIMING_PWM = 8; 
	/**
	 * 定时自动lux调光指令
	 */
	public static int CMD_TIMING_AUTOLUX = 9; 
	/**
	 * 定时调色指令
	 */
	public static int CMD_TIMING_TONING = 10; 	
	/**
	 * 读灯状态指令
	 */
	public static int CMD_READ = 11;
	/*
	 * 主键：id
	 */
	private int id;
	/*
	 * 用户发送指令的时间
	 */
	private Date date;
	/*
	 * 节点mac地址
	 */
	private String mac;
	/*
	 * 指令类型（1-12）
	 */
	private int cmdType;
	/*
	 * 指令参数
	 * 开灯：1
	 * 关灯：0
	 * pwm调光：80%，占空比（0-100）
	 * 调色：80%，占空比（0-100）
	 * lux调光：50000（1-600000）
	 */
	private String paramter;
	/*
	 * 用户id
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
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
	}
	public int getCmdType() {
		return cmdType;
	}
	public void setCmdType(int cmdType) {
		this.cmdType = cmdType;
	}
	public String getParamter() {
		return paramter;
	}
	public void setParamter(String paramter) {
		this.paramter = paramter;
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
		return "UserCmdRecord [id=" + id + ", date=" + date + ", mac=" + mac + ", cmdType=" + cmdType + ", paramter="
				+ paramter + ", userid=" + userid + ", param1=" + param1 + ", param2=" + param2 + "]";
	}
	
}
