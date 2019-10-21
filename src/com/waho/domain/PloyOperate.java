package com.waho.domain;

import java.util.Date;

public class PloyOperate {
	/**
	 * 策略操作主键：id
	 */
	private int id;
	/**
	 * 策略操作所在的策略id
	 */
	private int ployid;
	/**
	 * 策略操作所在的策略名称
	 */
	private String ployName;
	
	/**
	 * 策略操作开始的时间：形如2019/6/18-2019/8/23(年与日范围)
	 */
	private Date startDate;
	/**
	 * 策略操作结束的时间：形如2019/6/18-2019/8/23(年与日范围)
	 */
	private Date endDate;
	/**
	 * 策略操作执行的时间：小时
	 */
	private int  hours;
	/**
	 * 策略操作执行的时间：分组
	 */
	private int minutes;
	/**
	 * 策略操作的类型：开关灯设置为1；调光设置为2；调色设置为3
	 */
	private int operateType;
	/**
	 * 策略操作的参数：
	 * 当策略操作的类型为1（开关灯操作）时：
	 * 关灯：operateParam设置为0；
	 * 开灯：operateParam设置为1，
	 * 调光：operateParam设置为调光值0-100；
	 * 调色：operateParam设置为调色值0-100.
	 */
	private int operateParam;
	/**
	 * 策略操作的执行标志位：1已执行该操作，0未执行该操作
	 */
	private int state;
	/**
	 * param1-2为预留参数
	 * 
	 */
	private String param1;
	private String param2;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPloyid() {
		return ployid;
	}
	public void setPloyid(int ployid) {
		this.ployid = ployid;
	}
	public String getPloyName() {
		return ployName;
	}
	public void setPloyName(String ployName) {
		this.ployName = ployName;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getHours() {
		return hours;
	}
	public void setHours(int hours) {
		this.hours = hours;
	}
	public int getMinutes() {
		return minutes;
	}
	public void setMinutes(int minutes) {
		this.minutes = minutes;
	}
	public int getOperateType() {
		return operateType;
	}
	public void setOperateType(int operateType) {
		this.operateType = operateType;
	}
	public int getOperateParam() {
		return operateParam;
	}
	public void setOperateParam(int operateParam) {
		this.operateParam = operateParam;
	}
	public String getParam2() {
		return param2;
	}
	public void setParam2(String param2) {
		this.param2 = param2;
	}
	public String getParam1() {
		return param1;
	}
	public void setParam1(String param1) {
		this.param1 = param1;
	}
	@Override
	public String toString() {
		return "PloyOperate [id=" + id + ", ployid=" + ployid + ", ployName=" + ployName + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", hours=" + hours + ", minutes=" + minutes + ", operateType=" + operateType
				+ ", operateParam=" + operateParam + ", state=" + state + ", param2=" + param2 + ", param1=" + param1
				+ "]";
	}
	
	
}
