package com.waho.dao;

import java.util.List;

import com.waho.domain.PloyOperate;

public interface PloyOperateDao {
	/**
	 * 插入策略操作
	 * @param operate
	 * @return
	 */
	int insertPloyOperate(PloyOperate operate)throws Exception;
	/**
	 * 根据ployid查找策略操作
	 * @param ployid
	 * @return
	 * @throws Exception
	 */
	List<PloyOperate> selectPloyOpertaeByPloyid(int ployid)throws Exception;
	/**
	 * 根据ployid删除策略操作
	 * @param ployid
	 * @return
	 * @throws Exception
	 */
	int deletePloyOperateByPloyid(int ployid)throws Exception;
	/**
	 * 更新策略操作是否执行的状态标志位
	 * @param poObj
	 * @throws Exception
	 */
	void updateState(PloyOperate poObj)throws Exception;
	/**
	 * 根据策略定时操作主键id删除定时操作
	 * @param operateId
	 * @throws Exception
	 */
	int deletePloyOperateByid(int operateId)throws Exception;
	/**
	 * 清除所有策略操作的标志位，置为0
	 * @param state
	 * @throws Exception
	 */
	void clearPloyOperateState(int state)throws Exception;

}
