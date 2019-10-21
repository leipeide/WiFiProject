package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class AddWifToGroupServlet
 */
@WebServlet("/addWifToGroupServlet")
public class AddWifToGroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddWifToGroupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		//1.获取表单数据
		String groupid = request.getParameter("groupid");
		String[] ballestMacArr = request.getParameterValues("checkOne");
		//2.业务处理逻辑
		if(null != groupid && "" != groupid) {
			UserService us = new UserServiceImpl();
			int result = us.addNodeToGroup(Integer.parseInt(groupid),ballestMacArr);
			response.getWriter().write("成功添加" + result + "条节点到分组内！" );
			
		}else {
			//3.分发转向
			response.getWriter().write("添加失败!");
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
