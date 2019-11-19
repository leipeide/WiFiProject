package com.waho.servlet;

import java.io.IOException;
import java.util.Collection;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.domain.PageBean;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/homeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HomeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		//1. 获取表单数据
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		//用于传递给jsp，在js中根据语言的类型去获取相应的语言库
		String i18nLanguageStr = request.getParameter("i18nLanguage");
	
		//2. 调用业务逻辑
		UserService userService = new UserServiceImpl();
		Map<String, Object> result = userService.login(username, password);
		if (null == result) {
			// 跳转error页面 or 返回错误信息
			response.setHeader("refresh","3;/wifiProject"); //客户端
			//response.setHeader("refresh","3;/wifiProject1"); //本地测试
			response.getWriter().write("User does not exist, Wrong user name or password(用户不存在或信息填写错误!)");
		} else {
			request.setAttribute("result", result);
			request.setAttribute("i18nLanguage", i18nLanguageStr);
			request.getRequestDispatcher("/admin/home.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
