package com.waho.domain;

public class GroupNode {
	/*
	 * 主键：id
	 */
	private int id;
	/*
	 * 分组id
	 */
	private int groupid;
	/*
	 * 节点mac地址
	 */
	private String mac;
	/*
	 *用户id 
	 */
	private int userid;
	/*
	 * param1-4为预留参数
	 */
	private String param1;
	private String param2;
	private int param3;
	private int param4;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGroupid() {
		return groupid;
	}
	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}
	public String getMac() {
		return mac;
	}
	public void setMac(String mac) {
		this.mac = mac;
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
	public int getParam3() {
		return param3;
	}
	public void setParam3(int param3) {
		this.param3 = param3;
	}
	public int getParam4() {
		return param4;
	}
	public void setParam4(int param4) {
		this.param4 = param4;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return "GroupNode [id=" + id + ", groupid=" + groupid + ", mac=" + mac + ", userid=" + userid + ", param1="
				+ param1 + ", param2=" + param2 + ", param3=" + param3 + ", param4=" + param4 + "]";
	}
	
	
}
