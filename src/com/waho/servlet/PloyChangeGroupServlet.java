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
 * Servlet implementation class PloyChangeGroupServlet
 */
@WebServlet("/ployChangeGroupServlet")
public class PloyChangeGroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PloyChangeGroupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		//1.获取表单数据:策略id,重新绑定的分组id
		String ployIdStr = request.getParameter("ployid");
		String groupIdStr = request.getParameter("oneCheck");
		if(null != ployIdStr && "" != ployIdStr && null != groupIdStr && "" != groupIdStr) {
			int ployid = Integer.parseInt(ployIdStr);
			int groupid = Integer.parseInt(groupIdStr);
			UserService us = new UserServiceImpl();
			Boolean result = us.changePloyGroup(ployid,groupid);
			//3.分发转向
			if(result) {
				String res = "重新绑定分组成功";
				response.getWriter().write(res);	
			}else {
				String res = "重新绑定分组失败";
				response.getWriter().write(res);	
			}
		}else {
			String res = "提交失败";
			response.getWriter().write(res);	
		}
		
	/*	//1.获取表单数据:策略id,重新绑定的分组id
		String ployIdStr = request.getParameter("ployid");
		String groupIdStr = request.getParameter("oneCheck");
		String i18nLanguageStr = request.getParameter("i18nLanguage");
		
		//2.处理业务逻辑
		if(null != ployIdStr && "" != ployIdStr && null != groupIdStr && "" != groupIdStr) {
			int ployid = Integer.parseInt(ployIdStr);
			int groupid = Integer.parseInt(groupIdStr);
			UserService us = new UserServiceImpl();
			Boolean result = us.changePloyGroup(ployid,groupid);
			//3.分发转向
			if(result) {
				if(i18nLanguageStr.equals("zh-CN")) {
					String res = "重新绑定分组成功！";
					response.getWriter().write(res);	
				}else {
					String res = "Rebind group succeeded!";
					response.getWriter().write(res);
				}
			}else {
				if(i18nLanguageStr.equals("zh-CN")) {
					String res = "重新绑定分组失败！";
					response.getWriter().write(res);	
				}else {
					String res = "Rebind group failed!";
					response.getWriter().write(res);
				}
			}
		}else {
			if(i18nLanguageStr.equals("zh-CN")) {
				String res = "重新绑定分组失败！";
				response.getWriter().write(res);	
			}else {
				String res = "Rebind group failed!";
				response.getWriter().write(res);
			}
		}
		*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
