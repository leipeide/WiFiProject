package com.waho.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.waho.domain.NodeTreeModel;
import com.waho.domain.TreeChildModel;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;


/**
 * Servlet implementation class ResetNodeApModelServlet
 */
@WebServlet("/resetNodeApModelServlet")
public class ResetNodeApModelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResetNodeApModelServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
	
		//1.获取表单数据T
		 String nodeIdStr = request.getParameter("nodeid"); 
		 int length =  nodeIdStr.length();
		 String str = nodeIdStr.substring(1, length-1); //从数组的字符串格式中取出数字；[2,1,3],去除[]
		 String[] nodeIdArr = str.split(",");
		//2.处理业务逻辑
		if(nodeIdArr.length > 0) {
			UserService us = new UserServiceImpl();
			Boolean result = us.resetNodeApModel(nodeIdArr);
			//3.分发转向
			if(result) {
				response.getWriter().write(JSON.toJSONString("指令发送成功!"));
			}else {
				response.getWriter().write(JSON.toJSONString("指令发送失败!"));
			}
		}else {
			response.getWriter().write(JSON.toJSONString("未选择对象!"));
		}
		
	}

	private Object eval(String string) {
		// TODO Auto-generated method stub
		return null;
	}

}
