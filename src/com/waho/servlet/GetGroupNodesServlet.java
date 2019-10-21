package com.waho.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.domain.Node;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class GetBallastGroupNodesServlet
 */
@WebServlet("/getGroupNodesServlet")
public class GetGroupNodesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetGroupNodesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		
		//注意：镇流器、led、wifi都是通过这个servlet获取到分组下的节点数据
		//1.获取表单数据
		String groupidStr = request.getParameter("groupid");  
		//2.业务逻辑处理
		if(groupidStr != null && groupidStr != "") {
			int groupid = Integer.parseInt(groupidStr);
			UserService us = new UserServiceImpl();
			List<Node> list = us.getGroupNode(groupid);
			response.getWriter().write(JSON.toJSONString(list));
		}
		//3.分发转向
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	

}
