package com.waho.dao;

import com.waho.domain.User;

public interface UserDao {
	/**
	 * 根据用户名和密码查询用户信息
	 * @param username
	 * @param password
	 * @return
	 */
	public User selectUserByUsernameAndPassword(String username, String password) throws Exception;

	/**
	 * 添加用户
	 * @param user
	 * @return
	 */
	public int insert(User user) throws Exception;

	/**
	 * 根据用户名查询用户
	 * @param username
	 * @return
	 */
	public User selectUserByUsername(String username) throws Exception;

	/**
	 * 根据id查询用户
	 * @param id
	 * @return
	 */
	public User selectUserById(int id) throws Exception;
    /**
     * 更新用户秘密
     * @param user
     * @return
     */
	public int updateUserPasswordByPassword(User user)throws Exception;
	/**
	 * 根据邮箱查找用户
	 * @param email
	 * @return
	 * @throws Exception
	 */
	public User selectByEmail(String email)throws Exception;
	/**
	 * 更新用户获取验证码操作次数和验证码
	 * @param admin
	 * @throws Exception
	 */
	public void updateVerCodeAndOperateNumByPrimaryKey(User admin)throws Exception;
	/**
	 * 设置用户密码
	 * @param id
	 * @param password
	 * @return
	 * @throws Exception
	 */
	public boolean updateUserPasswordById(int id, String password)throws Exception;

	public void clearVercodeAndOpreateNum(String verCode, int operateNum)throws Exception;
}
