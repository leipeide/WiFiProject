package com.waho.servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.domain.PageBean;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class WelcomeRefreshServlet
 */
@WebServlet("/welcomeRefreshServlet")
public class WelcomeRefreshServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WelcomeRefreshServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
		// 获取表单数据
		//Date myDate = new Date();
	    //String mytime=myDate.toLocaleString();
		//System.out.println(mytime+":2019");
		
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
		
		//将查询的结果封装成json语句返回到js,进行实时刷新
		response.getWriter().write(JSON.toJSONString(pb));
		//System.out.println("23"+JSON.toJSONString(pb));	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
