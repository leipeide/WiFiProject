package com.waho.domain;

public class Group {
	/**
	 * 组id，主键
	 */
	private int groupid;
	/**
	 * 控制组名称
	 */
	private String groupName;
	/**
	 * 用户id
	 */
	private int userid;
	/**
	 * 广播控制开关灯标志位
	 */
	private int switchStatus;
	/**
	 * 分组类型：1为镇流器分组；2为led分组；3为wifi无线调光器分组
	 * 
	 */
	private int type;
	/**
	 * 记录上一次用户操作节点的指令类型;用于前端页面指令按钮的颜色转换，提示用户上一次操作类型是什么
	 * lastOperateType：open;表示最近一次的操作为开灯
	 * lastOperateType：close;表示最近一次的操作为关灯
	 * lastOperateType：dim;表示最近一次的操作为pwm调光
	 * lastOperateType：luxdim;表示最近一次的操作为lux调光
	 * lastOperateType：toning;表示最近一次的操作为调色
	 */
	private String lastOperateType;
	/**
	 * 预留参数2
	 */
	private String param2;
	/**
	 * 分组下的节点数量
	 */
	private int nodeNum;
	
	public String getParam2() {
		return param2;
	}
	public String getLastOperateType() {
		return lastOperateType;
	}
	public void setLastOperateType(String lastOperateType) {
		this.lastOperateType = lastOperateType;
	}
	public void setParam2(String param2) {
		this.param2 = param2;
	}
	
	public int getNodeNum() {
		return nodeNum;
	}
	public void setNodeNum(int nodeNum) {
		this.nodeNum = nodeNum;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getGroupid() {
		return groupid;
	}
	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getSwitchStatus() {
		return switchStatus;
	}
	public void setSwitchStatus(int switchStatus) {
		this.switchStatus = switchStatus;
	}
	@Override
	public String toString() {
		return "Group [groupid=" + groupid + ", groupName=" + groupName + ", userid=" + userid + ", switchStatus="
				+ switchStatus + ", type=" + type + ", lastOperateType=" + lastOperateType + ", param2=" + param2
				+ ", nodeNum=" + nodeNum + "]";
	}


}
