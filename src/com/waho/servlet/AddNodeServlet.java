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
 * Servlet implementation class AddNodeServlet
 */
@WebServlet("/addNodeServlet")
public class AddNodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddNodeServlet() {
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
		// 获取表单数据
		String useridStr = request.getParameter("userid");
		String nodeMac = request.getParameter("nodeMac");
		String i18nLanguageStr = request.getParameter("i18nLanguage");

		if (useridStr != null && "".equals(useridStr) == false && nodeMac != null && "".equals(nodeMac) == false) {
			int userid = Integer.parseInt(useridStr);

			// 调用业务逻辑
			int result = us.addNodeToUser(nodeMac, userid);
			if (result > 0) {
				if(i18nLanguageStr.equals("zh-CN")) {
					// 分发转向
					response.getWriter().write(JSON.toJSONString(nodeMac+" 已添加到当前用户！"));
				}else {
					response.getWriter().write(JSON.toJSONString(nodeMac+" successfully added node to current user!"));
				}
				
			} else {
				if(i18nLanguageStr.equals("zh-CN")) {
					// 分发转向
					response.getWriter().write(JSON.toJSONString(nodeMac+" 添加失败！"));
				}else {
					response.getWriter().write(JSON.toJSONString(nodeMac+" add failure!"));
				}
			}
			return;
		}
		
		if(i18nLanguageStr.equals("zh-CN")) {
			// 分发转向
			response.getWriter().write(JSON.toJSONString(nodeMac+" 添加失败！"));
		}else {
			response.getWriter().write(JSON.toJSONString(nodeMac+" add failure!"));
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
