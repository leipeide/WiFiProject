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
		 if(!prePassword.equals(user.getPassword())) {
			request.setAttribute("ckpw", "密码错误，请重新输入！");
			request.setAttribute("userid", userid);
			request.getRequestDispatcher("/admin/rePassword.jsp").forward(request, response);
			return;
		}else if(!rePassword.equals(newPassword)) {
			request.setAttribute("cknpw", "两次密码不一致，请重新输入！");
			request.setAttribute("userid", userid);
			request.getRequestDispatcher("/admin/rePassword.jsp").forward(request, response);
			return;
		}else if(us.updateUserPassword(userid,newPassword)) {
			request.setAttribute("retext", "密码修改成功！");
			request.setAttribute("userid", userid);
			request.getRequestDispatcher("/admin/rePassword.jsp").forward(request, response);
		}else {
			request.setAttribute("retext", "密码修改失败！");
			request.setAttribute("userid",userid);
			request.getRequestDispatcher("/admin/rePassword.jsp").forward(request, response);
		}
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
