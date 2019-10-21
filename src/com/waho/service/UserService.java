package com.waho.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.waho.domain.Alarm;
import com.waho.domain.Group;
import com.waho.domain.Node;
import com.waho.domain.PageBean;
import com.waho.domain.Ploy;
import com.waho.domain.PloyOperate;
import com.waho.domain.User;

public interface UserService {

	/**
	 * 登录服务，返回用户信息和节点列表 map的数据结构为 { user:user Object nodes:[ node Object ] }
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	Map<String, Object> login(String username, String password);

	/**
	 * 根据节点id的字符串返回节点对象
	 * 
	 * @param nodeid
	 * @return
	 */
	Node getNodeByIdString(String nodeid);

	/**
	 * 根据节点id，对节点的开关状态、功率输出百分比进行控制，返回指令发送成功或失败（不代表执行成功和失败，执行结果需要从数据库查询）
	 * 
	 * @param nodeid
	 * @param switchState
	 * @param percentage
	 */
	Boolean userWriteNodeCmd(String nodeid, String switchState, String percentage);

	/**
	 * 用户注册，注册成功返回true，注册失败返回false
	 * @param username
	 * @param password
	 * @param email
	 * @return
	 */
	Boolean userRegister(String username, String password, String email);

	/**
	 * 节点重命名，成功返回true，失败返回false
	 * @param nodeid 要修改的节点id
	 * @param nodeName 新的节点名称
	 * @return
	 */
	String userRenameNode(String nodeid, String nodeName);

	/**
	 * 根据用户id获取节点信息
	 * @param id
	 * @return
	 */
	List<Node> getNodeListByUserId(int id);

	/**
	 * 根据节点id删除节点的用户id信息
	 * @param idList
	 * @param userid 
	 * @return
	 */
	int removeNodeById(List<Integer> idList, int userid);

	/**
	 * 根据节点id，查找与userid相同的在线节点的webSocket，发送修改wifi名称和密码的指令。返回值为成功发送的指令条数，即成功发送的节点个数。
	 * @param userid
	 * @param ssid
	 * @param password
	 * @param idList 需修改节点的id集合
	 * @return
	 */
	int userWriteWifiResetCmd(int userid, String ssid, String password, ArrayList<Integer> idList);

	/**
	 * 将节点添加到用户名下。
	 * @param nodeMac
	 * @param userid
	 * @return
	 */
	int addNodeToUser(String nodeMac, int userid);
	/**
	 * 根据用户id查询用户信息
	 * @param parseInt
	 * @return
	 */
	User getUserMessage(int userid);
	/**
	 * 修改用户密码
	 * @param userid
	 * @param newPassword
	 * @return
	 */
	boolean updateUserPassword(int userid, String newPassword);
	/**
	 * 从个人页面返回到home主页面
	 * @param username
	 * @param password
	 * @return
	 */
	Map<String, Object> returnHome(String username, String password);
	/**
	 * 获取不同类型的节点集合，数据返回welcome页面
	 * @param userid
	 * @return
	 */
	Map<String, Object> getNodesByTypeAndUserid(int userid);
	/**
	 * 向用户中添加新的镇流器分组
	 * @param groupName
	 * @param userid 
	 * @return
	 */
	boolean addBalletGroupToUser(String groupName, int userid);
	/**
	 * 获取分组集合,返回分组控制jsp
	 * @param userid
	 * @return
	 */
	Map<String, Object> getGroupByUserid(int userid);
	/**
	 * 获取分组集合，用于分组控制页面的分组表格的定时刷新
	 * @param userid
	 * @return
	 */
	Map<String, Object> getGroupToRefersh(int userid);
	/**
	 * 向用户中添加新的led分组
	 * @param groupName
	 * @param userid 
	 * @return
	 */
	boolean addLedGroupToUser(String groupName, int userid);
	/**
	 * 向用户中添加新的wifi无线调光器分组
	 * @param groupName
	 * @param parseInt
	 * @return
	 */
	boolean addWifiGroupToUser(String groupName, int userid);
	/**
	 * 查询镇流器节点
	 * @param userid
	 * @return
	 */
	List<Node> getBallastNodes(int userid);
	/**
	 * 获取led节点
	 * @param parseInt
	 * @return
	 */
	List<Node> getLedNodes(int userid);
	/**
	 * 获取WiFi节点
	 * @param userid
	 * @return
	 */
	List<Node> getWifiNodes(int userid);
	/**
	 * 向分组内添加节点
	 * 注意：添加镇流器、led、wifi到各自的分组内都用的这个函数
	 * @param groupid
	 * @param String[] nodeMac
	 * @return
	 */
	int addNodeToGroup(int groupid, String[] nodeMac);
	/**
	 * 删除分组
	 * @param groupid 
	 * @return
	 */
	boolean deleteGroupByGroupid(int groupid);
	/**
	 * 修改分组名称
	 * @param parseInt
	 * @param parseInt2
	 * @param groupName
	 * @return
	 */
	int renameGroupName(int userid, int groupid, String groupName);
	/**
	 * 分组广播PWM调光
	 * @param userid
	 * @param groupid
	 * @param dimValue
	 * @return
	 */
	int groupBroadcastDimByPwm(int userid, int groupid, int dimValue);
	/**
	 * 分组广播开关灯
	 * @param userid
	 * @param groupid
	 * @param switchState
	 * @param percentage
	 * @return
	 */
	int groupBroadcastSwitchNode(int userid, int groupid, int switchState, int percentage);
	/**
	 * 分组广播调色（led驱动器）
	 * @param userid
	 * @param groupid
	 * @param tonPercentage
	 * @return
	 */
	int writeGroupBroadcastToningCmd(int userid, int groupid, int tonPrecentage);
	/**
	 * 分组广播lux调光（wifi无线调光器）
	 * @param userid
	 * @param groupid
	 * @param luxParam
	 * @param cmd
	 * @return
	 */
	int groupWriteLuxDimCmd(int userid, int groupid, int luxParam,String Cmd);
	/**
	 * 根据用户id查询用户下的所有策略，返回map集合；
	 * map集合中包含：镇流器策略集合、led策略集合、wifi无线调光器策略集合
	 * @param userid
	 * @return
	 */
	Map<String, Object> getAllPloysByUserid(int userid);
	/**
	 * 根据分组类型获得当前用户、当前分组类型所存在的所有分组集合
	 * @param userid
	 * @param groupType
	 * @return
	 */
	List<Group> getGroupByUseridAndGroupType(int userid, int groupType);
	/**
	 * 根据用户id和策略名获取策略
	 * @param userid
	 * @param ployName
	 * @return
	 */
	List<Ploy> getPloyByUseridAndPloyName(int userid, String ployName);
	/**
	 * 根据策略名称、绑定的分组id、绑定分组的类型向用户中添加新的策略
	 * @param userid
	 * @param groupType
	 * @param groupid
	 * @param ployName
	 * @return
	 */
	boolean addPloyToUserByGroupidAndGroupType(int userid, int groupType, int groupid, String ployName);
	/**
	 * 策略重命名
	 * @param userid
	 * @param ployid
	 * @param newName
	 * @return
	 */
	int ployRename(int userid, int ployid, String ployName);
	/**
	 * 根据用户id 和分组id查询分组
	 * @param parseInt
	 * @param parseInt2
	 * @return
	 */
	Group getGroupObjByUseridAndGroupid(int userid, int groupid);
	/**
	 * 删除策略
	 * @param userid
	 * @param ployid
	 * @return
	 */
	int deletePloy(int userid, int ployid);
	/**
	 * 向策略内添加开关灯操作
	 * @param userid
	 * @param ployid
	 * @param hours
	 * @param minutes
	 * @param startDate
	 * @param endDate
	 * @param value
	 * @return
	 */
	boolean addPloyOperateOfSwitch(int userid, int ployid, int hours, int minutes, Date startDate, Date endDate,
			int value);
	/**
	 *  向策略内添加调光操作
	 * @param userid
	 * @param ployid
	 * @param hours
	 * @param minutes
	 * @param startDate
	 * @param endDate
	 * @param value
	 * @return
	 */
	boolean addPloyOperateOfDim(int userid, int ployid, int hours, int minutes, Date startDate, Date endDate,
			int value);
	
	/**
	 * 向策略内添加调色操作
	 * @param userid
	 * @param ployid
	 * @param hours
	 * @param minutes
	 * @param startDate
	 * @param endDate
	 * @param value
	 * @return
	 */
	boolean addPloyOperateOfToning(int userid, int ployid, int hours, int minutes, Date startDate, Date endDate,
			int value);
	/**
	 * 修改执行策略的状态runState（执行策略，停止执行）
	 * @param userid
	 * @param ployid
	 * @param runState
	 * @return
	 */
	int changePloyRunState(int userid, int ployid, int runState);
	/**
	 * 获取策略下的策略操作集合
	 * @param ployid
	 * @return
	 */
	List<PloyOperate> getPloyOperate(int ployid);
	/**
	 * 删除策略定时操作
	 * @param operateId
	 * @return
	 */
	boolean deletePloyOperate(int operateId);
	/**
	 * 获得到分组下的节点集合
	 * @param groupid
	 * @param groupType
	 * @return
	 */
	List<Node> getGroupNode(int groupid);
	/**
	 * 从分组下移除节点
	 * @param userid
	 * @param nodeid
	 * @param groupid
	 * @return
	 */
	boolean removeNodeFromGroup(int userid, int nodeid,int groupid);
	/**
	 * 单点发送调色指令
	 * @param parseInt
	 * @param parseInt2
	 * @return
	 */
	boolean writeNodeToningCmd(int nodeid, int tonPercentage);
	/**
	 * 获取报警信息的数量
	 * @param userid
	 * @return
	 */
	int getWarnningTips(int userid);
	/**
	 * 获取报警信息
	 * @param parseInt
	 * @return
	 */
	List<Alarm> getAlarmMessage(int userid);
	/**
	 * 删除报警信息
	 * @param alarmIdArr
	 * @return
	 */
	int deleteAlarmMessage(String[] alarmIdArr);
	/**
	 * 
	 * @param 用户id
	 * @return
	 */
	Map<String, Object> getNodeListByUserid(int userid);
	/**
	 * 恢复节点Ap模式
	 * @param nodeIdArr
	 * @return
	 */
	Boolean resetNodeApModel(String[] nodeIdArr);
	/**
	 * 获取策略绑定分组以外的分组集合
	 * @param groupType
	 * @param groupid
	 * @param userid
	 * @return
	 */
	List<Group> getGroupByUseridForPloyChangeGroup(int groupid, int userid,int groupType);
	/**
	 * 策略重新绑定分组
	 * @param ployid
	 * @param groupid
	 * @return
	 */
	Boolean changePloyGroup(int ployid, int groupid);
	


}
