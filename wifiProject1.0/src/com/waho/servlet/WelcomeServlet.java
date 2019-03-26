package com.waho.servlet;

import java.io.IOException;
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
 * Servlet implementation class WelcomeServlet
 */
@WebServlet("/welcomeServlet")
public class WelcomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public WelcomeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		// 获取表单数据
		String useridS = request.getParameter("userid");
		String currentPage = request.getParameter("currentPage");
		int userid = Integer.parseInt(useridS);
		int currPage = 1;
		if(currentPage != null ) {
			currPage = Integer.parseInt(currentPage);
		}
		// 调用业务逻辑
		UserService userService = new UserServiceImpl();
		PageBean pb = userService.getNodeByUserId(userid,currPage);
		// 分发转向
		if (null == pb) {
			// 跳转error页面 or 返回错误信息
		} else {
			request.setAttribute("userid", userid);
			request.setAttribute("pb", pb);
			request.getRequestDispatcher("/admin/welcome.jsp").forward(request, response);
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
