package com.waho.dao;

import java.util.List;

import com.waho.domain.Ploy;

public interface PloyDao {
	/**
	 * 根据用户id和策略控制绑定的分组类型获取策略集合（镇流器策略、led驱动器策略、wifi策略）
	 * @param userid
	 * @param groupType
	 * @return
	 */
	List<Ploy> selectPloyByUseridAndGroupType(int userid, int groupType) throws Exception;
	/**
	 * 
	 * 根据用户id、策略名获取当前用户下的策略
	 * @param userid
	 * @param ployName
	 * @return
	 */
	List<Ploy> selectPloyByUseridAndPloyName(int userid, String ployName)throws Exception;
	/**
	 * 插入新的策略
	 * @param ploy
	 * @return
	 */
	int insertPloy(Ploy ploy)throws Exception;
	/**
	 * 根据用户id、策略id更新策略名称
	 * @param userid
	 * @param ployid
	 * @param ployName
	 * @return
	 */
	int updatePloyNameByUseridAndPloyid(int userid, int ployid, String ployName)throws Exception;
	/**
	 * 根据用户id,策略id删除策略
	 * @param userid
	 * @param ployid
	 * @return
	 * @throws Exception
	 */
	int deletePloyByUseridAndPloyid(int userid, int ployid)throws Exception;
	/**
	 * 根据用户id与策略id更新执行策略的状态位runState
	 * @param userid
	 * @param ployid
	 * @param runState
	 * @return 
	 * @throws Exception
	 */
	int updateRunStateByUseridAndId(int userid, int ployid, int runState)throws Exception;
	/**
	 * 根据用户id获取策略集合
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	List<Ploy> selectPloyByUserid(int userid)throws Exception;
	/**
	 * 根据用户ID和策略id查找策略
	 * @param ployid
	 * @param userid
	 * @return
	 * @throws Exception
	 */
	Ploy selectPloyByPloyidAndUserids(int ployid, int userid)throws Exception;
	/**
	 * 更新策略绑定的分组（id）
	 * @param ployid
	 * @param groupid
	 * @return
	 * @throws Exception
	 */
	int updateGroupidByPloyid(int ployid, int groupid)throws Exception;
	

}
