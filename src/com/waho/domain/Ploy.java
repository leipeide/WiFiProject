package com.waho.domain;

public class Ploy {
	//注意：目前策略控制只针对led驱动器的策略控制设计的；若其它类型的节点也需要策略控制，数据库需根据需求添加属性
	/**
	 * 策略控制主键id
	 */
	private int id;
	/**
	 * 用户id
	 */
	private int userid;
	/**
	 * 策略名称
	 */
	private String ployName;
	/**
	 * 策略执行状态：1为正在执行；0未执行
	 */
	private int runState;
	/**
	 * 策略绑定的控制组id
	 */
	private int groupid;
	/**
	 * 策略绑定的控制组类型：
	 * 1为绑定镇流器分组；2为绑定led分组；3为绑定wifi无线调光器分组
	 */
	private int groupType;
	/**
	 * param1-3为预留参数
	 */
	private String param1;
	private String param2;
	private String param3;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getPloyName() {
		return ployName;
	}
	public void setPloyName(String ployName) {
		this.ployName = ployName;
	}
	public int getRunState() {
		return runState;
	}
	public void setRunState(int runState) {
		this.runState = runState;
	}
	public int getGroupid() {
		return groupid;
	}
	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}
	public int getGroupType() {
		return groupType;
	}
	public void setGroupType(int grouptType) {
		this.groupType = grouptType;
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
	public String getParam3() {
		return param3;
	}
	public void setParam3(String param3) {
		this.param3 = param3;
	}
	@Override
	public String toString() {
		return "Ploy [id=" + id + ", userid=" + userid + ", ployName=" + ployName + ", runState=" + runState
				+ ", groupid=" + groupid + ", groupType=" + groupType + ", param1=" + param1 + ", param2=" + param2
				+ ", param3=" + param3 + "]";
	}
	
	
}
