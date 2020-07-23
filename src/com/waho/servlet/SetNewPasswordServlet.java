package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class SetNewPasswordServlet
 */
@WebServlet("/setNewPasswordServlet")
public class SetNewPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetNewPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
response.setContentType("application/json;charset=utf-8");
		
		String newPassword = request.getParameter("newPassword");
		String userid = request.getParameter("id");
		String message = ""; //用于提示信息
		
		if(newPassword != "" && newPassword != null && userid != "" && userid != null) {
			UserService us = new UserServiceImpl();
			boolean result = us.userSetNewPassword(Integer.parseInt(userid), newPassword);
			if(!result) { //结果非真，设置失败
				message = "密码设置失败";
			}
			
		}else {
			message = "未获取到参数，请重新操作";
			
		}
		
		response.getWriter().write(JSONObject.toJSONString(message));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
