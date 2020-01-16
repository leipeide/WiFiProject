package com.waho.dao;

import java.util.List;

import com.waho.domain.GroupNode;
import com.waho.domain.Node;

public interface NodeDao {
	/**
	 * 根据用户id查询节点信息
	 * @param userid
	 * @return
	 */
	public List<Node> selectNodesByUserid(int userid) throws Exception;
	/**
	 * 将节点信息存入数据库
	 * @param node
	 * @return
	 */
	public int insert(Node node) throws Exception;
	/**
	 * 根据mac地址查询节点信息
	 * @param mac
	 * @return
	 */
	public Node selectNodeByMac(String mac) throws Exception;
	/**
	 * 根据mac地址，更新节点的类型、功率、在线状态、当前开关状态、当前功率百分比、wifissid、wifipw
	 * @param node
	 * @return
	 * @throws Exception
	 */
	public int updateByMac(Node node) throws Exception;
	/**
	 * 根据mac地址，更新节点的当前功率百分比，当前开关状态
	 * @param node
	 * @return
	 * @throws Exception
	 */
	public int updatePrecentageAndSwitchStateByMac(Node node) throws Exception;
	/**
	 * 根据id查询节点信息
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Node selectNodeById(int id) throws Exception;
	/**
	 * 根据id更新节点在线状态
	 * @param b
	 * @param id
	 * @throws Exception
	 */
	public int updateOnlineById(boolean b, int id) throws Exception;
	/**
	 * 根据id更新节点名称
	 * @param id
	 * @param nodeName
	 * @throws Exception
	 */
	public int updateNodeNameById(int id, String nodeName) throws Exception;
	/**
	 * 根据id更新节点用户id
	 * @param userid
	 * @param idList
	 * @return
	 * @throws Exception
	 */
	public int[] updateUseridByid(int userid, List<Integer> idList) throws Exception;
	/**
	 * 根据userid查询在线的节点
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public List<Node> selectOnlineNodesByUserid(int userid) throws Exception;
	/**
	 * 根据节点mac地址更新调色参数
	 * @param node
	 */
	public int updateColorPrecentageByMac(Node node) throws Exception;
	/**
	 * 根据节点mac地址更新wifi节点的lux亮度
	 * @param node
	 */
	public int updateLuxByMac(Node node) throws Exception;
	/**
	 * 根据节点mac地址更新wifi节点的lux参数和precenteage参数。
	 * @param node
	 */
	public void updateLuxAndPrecentageByMac(Node node)throws Exception;
	/**
	 * 根据节点mac得到节点对象
	 * @param mac
	 * @return
	 */
	public Node selectNodeObjByMac(String mac)throws Exception;
	/**
	 * 根据节点的mac更新节点的分组标志位
	 * @param mac
	 * @param groupState
	 * @throws Exception
	 */
	public void updateGroupStateByMac(String mac, int groupState)throws Exception;
	/**
	 * 根据用户id，节点类型查询未添加到分组的镇流器节点;镇流器节点type范围1-10；
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public List<Node> selectBallastNodeByUseridAndTypeAndGroupState(int userid)throws Exception;
	/**
	 * 根据用户id，节点类型查询未添加到分组的led节点；led节点type范围11-20;
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public List<Node> selectLedNodeByUseridAndTypeAndGroupState(int userid)throws Exception;
	/**
	 * 根据用户id，节点类型查询未添加到分组的wifi节点；wifi节点type范围21-30;
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public List<Node> selectWifiNodeByUseridAndTypeAndGroupState(int userid)throws Exception;
	/**
	 * 根据节点mac和用户id更新节点的分组属性
	 * @param groupNode
	 * @throws Exception
	 */
	public void updateGroupStateByMacAndUserid(GroupNode groupNode)throws Exception;
	/**
	 * 根据节点mac和用户id查找在线节点
	 * @param mac
	 * @param userid
	 * @return
	 */
	public Node selectOnlineNodesByUseridAndMac(String mac, int userid)throws Exception;
	/**
	 * 根据节点mac和用户id查找节点
	 * @param mac
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	public Node selectNodesByUseridAndMac(String mac, int userid)throws Exception;
	/**
	 * 根据用户id和节点类型范围查找用户下的镇流器节点集合；type范围1-10；
	 * @param userid
	 * @param type:1-10
	 * @return
	 * @throws Exception
	 */
	public List<Node> selectBallastNodeByUseridAndType(int userid)throws Exception;
	/**
	 * 根据用户id和节点类型范围查找用户下的led节点集合；type范围11-20；
	 * @param userid
	 * @param type:11-20
	 * @return
	 * @throws Exception
	 */
	public List<Node> selectLedNodeByUseridAndType(int userid)throws Exception;
	/**
	 * 根据用户id和节点类型范围查找用户下的wifi节点集合；type范围21-30；
	 * @param userid
	 * @param type:21-30
	 * @return
	 * @throws Exception
	 */
	public List<Node> selectWifiNodeByUseridAndType(int userid)throws Exception;
	/**
	 * 向用户中添加节点时，修改用户id,恢复节点的分组状态至0，即未分组
	 * @param userid
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int updateUseridAndResetGroupState(int userid, int id)throws Exception;
	/**
	 * 更新节点最新一次操作类型字段
	 * @param operateType
	 * @param nodeid
	 * @throws Exception
	 */
	public void updateLastOperateTypeByNodeid(String operateType, int nodeid)throws Exception;
	
	
}
