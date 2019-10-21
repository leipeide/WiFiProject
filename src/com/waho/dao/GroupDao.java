package com.waho.dao;

import java.util.List;

import com.waho.domain.Group;
import com.waho.domain.GroupNode;
import com.waho.domain.Node;

public interface GroupDao {
	/**
	 * 
	 * @param group
	 * @return
	 * @throws Exception
	 */
	public int  insertGroup(Group group)throws Exception;
	/**
	 * 根据用户id和分组类型获取分组集合
	 * @param userid
	 * @param type1
	 * @return
	 */
	public List<Group> selectGroupByUseridAndType(int userid, int type)throws Exception;
	/**
	 * 更新分组下的在线节点数量
	 * @param groupid
	 * @param onlineNum
	 */
	public void updateOnlineNum(int onlineNum,int groupid) throws Exception;
	/**
	 * 根据分组id查询分组
	 * @param groupid
	 * @return
	 * @throws Exception
	 */
	public Group selectGroupByGroupid(int groupid) throws Exception;
	/**
	 * 更新分组下的离线节点数量
	 * @param groupid
	 * @param offlineNum
	 * 
	 */
	public void updateOfflineNum(int offlineNum,int groupid) throws Exception;
	/**
	 * 根据用户id和分组名称查询分组
	 * @param groupName
	 * @param parseInt
	 * @return
	 */
	public Group selectGroupByGroupNameAndUserid(String groupName, int parseInt)throws Exception;
	/**
	 * 根据分组id删除分组
	 * @param groupid
	 * @throws Exception
	 */
	public int deleteGroupByGroupid(int groupid)throws Exception;
	/**
	 * 根据用户id、分组id更新分组名称
	 * @param userid
	 * @param groupid
	 * @param groupName
	 * @return
	 * @throws Exception
	 */
	public int updateGroupNameByUseridAndGroupid(int userid, int groupid, String groupName)throws Exception;
	/**
	 * 更新分组开关灯的标志位switchStatus
	 * @param groupid
	 */
	public int updateGroupswitchStatusByGroupid(int switchState,int groupid)throws Exception;
	/**
	 * 根据用户id,分组id查询控制组对象
	 * @param userid
	 * @param groupid
	 * @return
	 * @throws Exception
	 */
	public Group selectGroupByGroupidAndUserid(int userid, int groupid)throws Exception;
	/**
	 * 更新在线、离线节点数量
	 * @param onlineNum
	 * @param offlineNum
	 * @param groupid
	 * @return
	 * @throws Exception
	 */
	public int updateOnlineNumAndOfflineNum(int onlineNum, int offlineNum, int groupid)throws Exception;
	/**
	 * 更新组内节点的数量
	 * @param nodeNum
	 * @param groupid
	 * @throws Exception
	 */
	public void updataNodeNumByGroupid(int nodeNum, int groupid)throws Exception;
	/**
	 * 更新分组内广播控制最新用户操作类型：open,close,toning,dim,luxdim
	 * @param operateType
	 * @param groupid
	 * @throws Exception
	 */
	public void updateLastOperateTypeByGroupid(String operateType, int groupid)throws Exception;
	

}
