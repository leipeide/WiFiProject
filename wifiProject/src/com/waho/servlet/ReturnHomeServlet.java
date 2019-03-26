package com.waho.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.domain.User;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class ReturnHomeServlet
 */
@WebServlet("/returnHomeServlet")
public class ReturnHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReturnHomeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset = UTF-8");
		//1.获取表单数据
		String userid = request.getParameter("userid");
		//2.调用业务逻辑
		if(userid != null) {
			User user = new User();
			UserService us = new UserServiceImpl();
			user = us.getUserMessage(Integer.parseInt(userid));
			//System.out.println("user"+user);
			//获取result，result里包含user，node对象，用于显示主页面信息
			Map<String, Object> result = us.returnHome(user.getUsername(),user.getPassword());
		//3.分发转向
			request.setAttribute("result", result);
			request.getRequestDispatcher("/admin/home.jsp").forward(request, response);	
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
