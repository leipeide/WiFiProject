package com.waho.dao.impl;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.waho.dao.UserDao;
import com.waho.domain.User;
import com.waho.util.C3P0Utils;

public class UserDaoImpl implements UserDao {

	@Override
	public User selectUserByUsernameAndPassword(String username, String password) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		User u = qr.query("select * from user where username=? and password=?", new BeanHandler<User>(User.class),
				username, password);
		return u;
	}

	@Override
	public int insert(User user) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
	 	return qr.update(
				"INSERT INTO user (`username`,`password`,`email`, `phone`, `vercode`, `operatenum`) "
				+ "VALUES (?, ?, ?, ?, ?, ?)",user.getUsername(), user.getPassword(), 
				user.getEmail(),user.getPhone(),user.getVerCode(),user.getOperateNum());
	}

	@Override
	public User selectUserByUsername(String username) throws Exception{
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		User u = qr.query("select * from user where username=?", new BeanHandler<User>(User.class),
				username);
		return u;
	}

	@Override
	public User selectUserById(int id) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		User u = qr.query("select * from user where id=?", new BeanHandler<User>(User.class),
				id);
		return u; 
	}
	@Override
	public int updateUserPasswordByPassword(User user) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		return qr.update("UPDATE user SET password=? WHERE id=?",user.getPassword(),user.getId());
	}

	@Override
	public User selectByEmail(String email) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		User u = qr.query("select * from user where email=?", new BeanHandler<User>(User.class),email);
		return u;
	}

	@Override
	public void updateVerCodeAndOperateNumByPrimaryKey(User admin) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("UPDATE user SET vercode=?,operatenum=? WHERE id=?",admin.getVerCode(),admin.getOperateNum(),admin.getId());
	}

	@Override
	public boolean updateUserPasswordById(int id, String password) throws Exception {
		boolean result = false;
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		int num = qr.update("UPDATE user SET password=? WHERE id=?", password, id);
		if(num == 1) {
		   result = true;
		}
		return result;
	}

	@Override
	public void clearVercodeAndOpreateNum(String verCode, int operateNum) throws Exception {
		QueryRunner qr = new QueryRunner(C3P0Utils.getDataSource());
		qr.update("update user set vercode=?, operatenum=?", verCode, operateNum);
		
	}
	
	
}
