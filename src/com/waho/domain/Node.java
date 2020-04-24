package com.waho.domain;

public class Node {
	/**
	 * 节点数据库id
	 */
	private int id;
	/**
	 * 节点mac地址
	 */
	private String mac;
	/**
	 * 设备类型:1-10范围内为镇流器；11-20范围内为led驱动器；21-30范围内为wifi无线调光器
	 */
	private int type;
	/**
	 * 设备额定满功率
	 */
	private int power;
	/**
	 * 当前功率百分比
	 */
	private int precentage;
	/**
	 * 灯具开关状态
	 */
	private int switchState;
	/**
	 * wifi模块链接的ap网络ssid
	 */
	private String ssid;
	/**
	 * ap网络的密码
	 */
	private String pw;
	/**
	 * 节点名称
	 */
	private String nodeName;
	/**
	 * 节点用户id
	 */
	private int userid;
	/**
	 * 温度
	 * @return
	 */
	private float temperature;
	/**
	 * 湿度
	 * @return
	 */
	private float humidity;
	/**
	 * 在线状态
	 * @return
	 */
	private boolean online;
	/**
	 * 传感器自动调光的流明数lux
	 */
	private int lux;
	/**
	 * 调色的占空比
	 */
	private int colorPrecentage;
	/**
	 * 
	 * 分组标志位，是否加入分组，加入标志位置为1；为添加置为0
	 */
	private int groupState;
	/**
	 * 记录上一次用户操作节点的指令类型;用于前端页面开关按钮的颜色转换，提示用户上一次操作类型是什么
	 * lastOperateType：open;表示最近一次的操作为开灯
	 * lastOperateType：close;表示最近一次的操作为关灯
	 */
	// * lastOperateType：dim;表示最近一次的操作为pwm调光
	//* lastOperateType：luxdim;表示最近一次的操作为lux调光
    //* lastOperateType：toning;表示最近一次的操作为调色
	private String lastOperateType;
	/**
	 * param2-4为预留参数
	 */
	private String param2;
	private int param3;
	private int param4;
	
	
	
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getMac() {
		return mac;
	}


	public void setMac(String mac) {
		this.mac = mac;
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


	public int getPrecentage() {
		return precentage;
	}


	public void setPrecentage(int precentage) {
		this.precentage = precentage;
	}


	public int getSwitchState() {
		return switchState;
	}


	public void setSwitchState(int switchState) {
		this.switchState = switchState;
	}


	public String getSsid() {
		return ssid;
	}


	public void setSsid(String ssid) {
		this.ssid = ssid;
	}


	public String getPw() {
		return pw;
	}


	public void setPw(String pw) {
		this.pw = pw;
	}


	public String getNodeName() {
		return nodeName;
	}


	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}


	public int getUserid() {
		return userid;
	}


	public void setUserid(int userid) {
		this.userid = userid;
	}


	public float getTemperature() {
		return temperature;
	}


	public void setTemperature(float temperature) {
		this.temperature = temperature;
	}


	public float getHumidity() {
		return humidity;
	}


	public void setHumidity(float humidity) {
		this.humidity = humidity;
	}


	public boolean isOnline() {
		return online;
	}


	public void setOnline(boolean online) {
		this.online = online;
	}


	public int getLux() {
		return lux;
	}


	public void setLux(int lux) {
		this.lux = lux;
	}


	public int getColorPrecentage() {
		return colorPrecentage;
	}


	public void setColorPrecentage(int colorPrecentage) {
		this.colorPrecentage = colorPrecentage;
	}


	public int getGroupState() {
		return groupState;
	}


	public void setGroupState(int groupState) {
		this.groupState = groupState;
	}


	public String getLastOperateType() {
		return lastOperateType;
	}


	public void setLastOperateType(String lastOperateType) {
		this.lastOperateType = lastOperateType;
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

	
	
	@Override
	public String toString() {
		return "Node [id=" + id + ", mac=" + mac + ", type=" + type + ", power=" + power + ", precentage=" + precentage
				+ ", switchState=" + switchState + ", ssid=" + ssid + ", pw=" + pw + ", nodeName=" + nodeName
				+ ", userid=" + userid + ", temperature=" + temperature + ", humidity=" + humidity + ", online="
				+ online + ", lux=" + lux + ", colorPrecentage=" + colorPrecentage + ", groupState=" + groupState
				+ ", lastOperateType=" + lastOperateType + ", param2=" + param2 + ", param3=" + param3 + ", param4=" + param4 + "]";
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + colorPrecentage;
		result = prime * result + groupState;
		result = prime * result + Float.floatToIntBits(humidity);
		result = prime * result + id;
		result = prime * result + lux;
		result = prime * result + ((mac == null) ? 0 : mac.hashCode());
		result = prime * result + ((nodeName == null) ? 0 : nodeName.hashCode());
		result = prime * result + (online ? 1231 : 1237);
		result = prime * result + ((lastOperateType == null) ? 0 : lastOperateType.hashCode());
		result = prime * result + ((param2 == null) ? 0 : param2.hashCode());
		result = prime * result + param3;
		result = prime * result + param4;
		result = prime * result + power;
		result = prime * result + precentage;
		result = prime * result + ((pw == null) ? 0 : pw.hashCode());
		result = prime * result + ((ssid == null) ? 0 : ssid.hashCode());
		result = prime * result + switchState;
		result = prime * result + Float.floatToIntBits(temperature);
		result = prime * result + type;
		result = prime * result + userid;
		return result;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Node other = (Node) obj;
		if (colorPrecentage != other.colorPrecentage)
			return false;
	/*	if (groupState != other.groupState)
			return false;
		if (Float.floatToIntBits(humidity) != Float.floatToIntBits(other.humidity))
			return false;
			*/
		if (id != other.id)
			return false;
		if (lux != other.lux)
			return false;
		if (mac == null) {
			if (other.mac != null)
				return false;
		} else if (!mac.equals(other.mac))
			return false;
		if (nodeName == null) {
			if (other.nodeName != null)
				return false;
		} else if (!nodeName.equals(other.nodeName))
			return false;
		if (online != other.online)
			return false;
		if (lastOperateType == null) {
			if (other.lastOperateType != null)
				return false;
		} else if (!lastOperateType.equals(other.lastOperateType))
			return false;
		if (param2 == null) {
			if (other.param2 != null)
				return false;
		} else if (!param2.equals(other.param2))
			return false;
		if (param3 != other.param3)
			return false;
		if (param4 != other.param4)
			return false;
		if (power != other.power)
			return false;
		if (precentage != other.precentage)
			return false;
		if (pw == null) {
			if (other.pw != null)
				return false;
		} else if (!pw.equals(other.pw))
			return false;
		if (ssid == null) {
			if (other.ssid != null)
				return false;
		} else if (!ssid.equals(other.ssid))
			return false;
		if (switchState != other.switchState)
			return false;
		if (Float.floatToIntBits(temperature) != Float.floatToIntBits(other.temperature))
			return false;
		if (type != other.type)
			return false;
		if (userid != other.userid)
			return false;
		return true;
	}

	
	
}
