package com.waho.domain;

import java.util.Date;

public class Alarm {
	/**
	 * 异常报警原因：
	 * 1. 过功率
	 * 2. 连接失败
	 * 3. 高温
	 */
	public static final int ALARM_OVERLOAD = 1; 
	
	public static final int ALARM_DISCONNECT = 2;
	
	public static final int ALARM_HIGH_TEMPERATURE = 3;
	//注意：过功率的限定值；暂时未确定，根据不同类型的节点限定过功率值不一样；根据节点类型来定
	public static final int OVERLOAD_VOLTAGE = 0;
	

	/**
	 * 报警id，primary key
	 */
	private int id;
	
	/**
	 * 报警时间.(报警信息生成的时间)
	 */
	private Date date;
	
	/**
	 * 节点设备的mac地址
	 */
	private String mac;
	
	/**
	 * 报警信息的用户id
	 */
	private int userid;
	
	/**
	 * 报警信息类型：1、过功率报警；2、连接失败报警；3、高温报警
	 */
	private int type;
	
	/**
	 * 过功率时的功率
	 */
	private int power;
	/**
	 * 过温报警时的温度
	 */
	private float temperature;

	public Alarm() {
		super();
	}
	
	public Alarm(Date date, String mac,int type,int userid,int power,float temperature) {
		super();
		this.setDate(date);
		this.setMac(mac);
		this.setType(type);
		this.setUserid(userid);
		this.setPower(power);
		this.setTemperature(temperature);
	}

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

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getPower() {
		return power;
	}

	public void setPower(int power) {
		this.power = power;
	}

	public float getTemperature() {
		return temperature;
	}

	public void setTemperature(float temperature) {
		this.temperature = temperature;
	}

	@Override
	public String toString() {
		return "Alarm [id=" + id + ", date=" + date + ", mac=" + mac + ", userid=" + userid + ", type=" + type
				+ ", power=" + power + ", temperature=" + temperature + "]";
	}
	
	

}
	