package com.waho.dao;

import java.util.List;

import com.waho.domain.GroupNode;
import com.waho.domain.Node;

public interface GroupNodeDao{

	/**
	 * 根据分组id查询分组下的节点，获取到当前分组下的节点集合
	 * @param groupid
	 * @return
	 * @throws Exception
	 */
	public List<GroupNode> selectNodeByGroupid(int groupid) throws Exception;
	/**
	 * 根据节点mac地址查询节点
	 * @param mac
	 */
	public GroupNode selectNodeByMac(String mac) throws Exception;
	/**
	 * 根据分组id向分组内插入节点
	 * @param groupid
	 * @param node
	 * @return 
	 */
	public int insertNodeToGroupByGroupid(GroupNode groupNode) throws Exception;
	/**
	 * 根据分组id删除分组内节点的数据
	 * @param groupid
	 * @return 
	 * @throws Exception
	 */
	public int deleteGroupNodeByGroupid(int groupid)throws Exception;
	/**
	 * 根据用户id和分组id查找该分组内的节点
	 * @param userid
	 * @param groupid
	 * @return
	 * @throws Exception
	 */
	public List<GroupNode> selectNodesByUseridAndGroupid(int userid, int groupid)throws Exception;
	/**
	 * 根据节点的mac地址和分组id将分组的节点从组内移除
	 * @param mac
	 * @param groupid
	 * @return
	 * @throws Exception
	 */
	public int deleteGroupNodeByGroupidAndNodeMac(String mac, int groupid)throws Exception;
	/**
	 * 根据用户id和节点mac地址查找分组内的节点
	 * @param userid
	 * @param mac
	 * @return
	 * @throws Exception
	 */
	public GroupNode selectNodeByUseridAndMac(int userid, String mac)throws Exception;
	
	

}
