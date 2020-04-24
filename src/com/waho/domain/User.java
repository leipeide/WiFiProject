package com.waho.domain;

public class User {
	/**
	 * id 为 primary key
	 */
	private int id;
	/**
	 * 用户名
	 */
	private String username;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 手机
	 */
	private String phone;
	/**
	 * 验证码，用于客户找回密码，6位数的随机数
	 */
	private String verCode;
	/**
	 * 操作次数，用户当天操作邮箱找回获取验证码的次数
	 */
	private int operateNum;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getVerCode() {
		return verCode;
	}
	public void setVerCode(String verCode) {
		this.verCode = verCode;
	}
	public int getOperateNum() {
		return operateNum;
	}
	public void setOperateNum(int operateNum) {
		this.operateNum = operateNum;
	}
	
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email + ", phone="
				+ phone + ", verCode=" + verCode + ", operateNum=" + operateNum + "]";
	}
	
	
}
