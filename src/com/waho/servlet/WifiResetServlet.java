package com.waho.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class WifiResetServlet
 */
@WebServlet("/wifiResetServlet")
public class WifiResetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public WifiResetServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		UserService us = new UserServiceImpl();
		//1.获取表单数据
		String useridStr = request.getParameter("userid");
		String ssid = request.getParameter("ssid");
		String password = request.getParameter("password");
		String nodeIdArrStr = request.getParameter("nodeIdArr");
		String[] nodeIdArr =  nodeIdArrStr.split(","); //以","分隔节点id字符串得到多个节点id
		//字符串转集合
		ArrayList<Integer> idList = new ArrayList<Integer>();
		for(int i=0; i < nodeIdArr.length; i++) {
			idList.add(Integer.parseInt(nodeIdArr[i]));
		}
		//2.处理业务逻辑
		if(useridStr != null && "".equals(useridStr) == false) { //参数完整
			int userid = Integer.parseInt(useridStr);
			int result = us.userWriteWifiResetCmd(userid, ssid, password, idList);
			/*
             * 3.分发转向
             * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库;
             * 若修改，需要前后端统一
             */
			if(result > 0) {//操作成功
				response.getWriter().write(JSON.toJSONString(result));
			}else {//操作失败
				response.getWriter().write(JSON.toJSONString("指令发送失败请检查设备是否已离线"));
			}
		}else {//参数不完整
			response.getWriter().write(JSON.toJSONString("指令发送失败"));
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
