package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class NodeRenameServlet
 */
@WebServlet("/nodeRenameServlet")
public class NodeRenameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NodeRenameServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		UserService us = new UserServiceImpl();
		// 获取表单数据
		String nodeid = request.getParameter("nodeid");
		String nodeName = request.getParameter("nodeName");
		String i18nLanguage = request.getParameter("i18nLanguage");//servlet层利用到语言参数，必须获得
		if (nodeid != null) {// 数据有效
			// 调用业务逻辑
			String tips = us.userRenameNode(nodeid, nodeName, i18nLanguage);
			response.getWriter().write(JSON.toJSONString(tips));
		}else{
			if(i18nLanguage.equals("zh-CN")) {
				response.getWriter().write(JSON.toJSONString("修改失败!"));			
			}else {
				response.getWriter().write(JSON.toJSONString("Modification failed!"));		
			}
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
