package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.waho.domain.User;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;
import com.waho.util.MD5Utils;

/**
 * Servlet implementation class RepasswordServlet
 */
@WebServlet("/repasswordServlet")
public class RepasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RepasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
	
		//1.获取表单数据，对秘密进行加密
		String useridStr = request.getParameter("userid");
		String prePassword =MD5Utils.MD5Encode(request.getParameter("prePassword"),"utf-8");
		String newPassword =MD5Utils.MD5Encode(request.getParameter("newPassword"),"utf-8");
		String rePassword =MD5Utils.MD5Encode(request.getParameter("rePassword"),"utf-8");
	
		//获取user
		UserService us = new UserServiceImpl();
		if(useridStr != null) {
			int userid = Integer.parseInt(useridStr);
			User user = new User();
		    user = us.getUserMessage(userid);
		    //判断密码是否正确
	         /**
			 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库；
			 * 若修改，需要前后端统一
			 */
			 
			 if(!prePassword.equals(user.getPassword())) { //原密码输入错误
				 response.getWriter().write("原密码错误请重新输入");
			 }else {
				 if(us.updateUserPassword(userid,newPassword)) {
					 response.getWriter().write("密码修改成功");
				 }else {
					 response.getWriter().write("密码修改失败");
				 }
			 }
		}else {
			 response.getWriter().write("提交失败");
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
