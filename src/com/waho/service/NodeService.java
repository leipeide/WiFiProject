package com.waho.service;

import java.util.List;

import com.waho.domain.GroupNode;
import com.waho.domain.Node;

public interface NodeService {
	/**
	 * 根据节点id，将节点的在线状态更新为离线
	 * @param id
	 */
	void setNodeOfflineById(int id);
	/**
	 * 根据节点mac广播调灯光颜色
	 * @param parseInt
	 * @param nodeMacArr
	 * @return
	 */
	int ColorControlBroadcast(int tonPercentage, String[] nodeId);
	/**
	 * 单灯控制：根据节点id开灯、关灯
	 * @param nodeid
	 * @param switchState
	 * @return
	 */
	boolean switchNodeControl(int nodeid, String switchState);
	/**
	 * 根据节点id单灯调光
	 * @param parseInt
	 * @return
	 */
	boolean dimNodeControl(int nodeid,int percentage);
	/**
	 * 根据节点id对wifi进行调光
	 * @param nodeid
	 * @param dimParam
	 * @param cmd 
	 * @return
	 */
	boolean wifiNodeLuxDimByNodeid(int nodeid, int dimParam, String cmd);
	/**
	 * 通过groupNode集合得到分组下的所有节点的信息集合List<node>;此方法是通用的，作为通用方法
	 * @param gnList
	 * @return
	 */
	List<Node> currencyGetNodeListInGroup(List<GroupNode> gnList);
	/**
	 *led驱动器节点发送广播指令
	 * @param userid
	 * @param paramValue;功能参数值
	 * @param functionStr：switch、dim、toning；选择的功能字符串
	 * @return
	 */
	Boolean writeLedBroadcastCmd(int userid, int paramValue, String functionStr);
	/**
	 *镇流器节点发送广播指令
	 *@param userid
	 * @param paramValue;功能参数值
	 * @param functionStr：switch、dim；选择的功能字符串
	 * @return
	 */
	Boolean writeBallastBroadcastCmd(int userid, int paramValue, String functionStr);
	/**
	*wifi无线调光器节点发送广播指令
	 *@param userid
	 * @param dimParam;调光参数
	 * @param cmd：autoluxdim、pwmdim；调光功能类型字符串，
	 * @return
	 */
	Boolean writeWifiBroadcastCmd(int userid, int dimParam, String Cmd);
	/**
	 * 分组内的节点单灯开关
	 * @param nodeid
	 * @param switchState
	 * @return
	 */
	Boolean nodeInGroupWriteCmd(int nodeid, int switchState);
	/**
	 * 分组内节点pwm调光控制
	 * @param nodeid
	 * @param percentage
	 * @return
	 */
	Boolean nodeInGroupPwmDimCmd(int nodeid, int percentage);
	/**
	 * 分组内节点调色控制
	 * @param nodeid
	 * @param tonPercentage
	 * @return
	 */
	Boolean NodeInGroupToningCmd(int nodeid, int tonPercentage);
	/**
	 * 分组内节点lux调光控制
	 * @param nodeid
	 * @param dimParam
	 * @param cmd(pwmdim\autoluxdim)
	 * @return
	 */
	boolean nodeInGrouopLuxDimCmd(int nodeid, int dimParam, String Cmd);
}
