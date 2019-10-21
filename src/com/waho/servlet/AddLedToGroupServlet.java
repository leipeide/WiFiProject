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
 * Servlet implementation class AddLedToGroupServlet
 */
@WebServlet("/addLedToGroupServlet")
public class AddLedToGroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddLedToGroupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		//1.获取表单上数据
		String groupid = request.getParameter("groupid");
		String [] ledMacArr = request.getParameterValues("checkOne");
		//2.处理业务逻辑
		if(groupid != null && "".equals(groupid) == false) {
			UserService us = new UserServiceImpl();
			int result = us.addNodeToGroup(Integer.parseInt(groupid),ledMacArr);
			//3.分发转向
			if(result > 0) {
				response.getWriter().write("成功添加"+ result + "条节点到分组内！");
			}else {
				response.getWriter().write("添加失败!");
			}
		}else {
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
