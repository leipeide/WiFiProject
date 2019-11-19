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

/**
 * Servlet implementation class ShowUserMessageServlet
 */
@WebServlet("/showUserMessageServlet")
public class ShowUserMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowUserMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		//1.获取表单数据
		String userid = request.getParameter("userid");
		String i18nLanguageStr = request.getParameter("i18nLanguage");
		//System.out.println("SHOWUserMessage+i18nLanguage:"+i18nLanguageStr);
		//2.调用业务逻辑
		if(userid != null) { 
			//查找用户信息
			User user = new User();
			UserService us = new UserServiceImpl();
			user = us.getUserMessage(Integer.parseInt(userid));
			//3.分发转向	
			request.setAttribute("user", user);
			request.setAttribute("i18nLanguage", i18nLanguageStr);
			request.getRequestDispatcher("/admin/userMessagePage.jsp").forward(request, response);
			
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
