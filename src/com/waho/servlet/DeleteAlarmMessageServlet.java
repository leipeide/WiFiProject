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
 * Servlet implementation class DeleteAlarmMessageServlet
 */
@WebServlet("/deleteAlarmMessageServlet")
public class DeleteAlarmMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAlarmMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		//response.setContentType("application/json;charset=utf-8");
		response.setContentType("text/html;charset=utf-8");
		//1.获取表单数据
		String[] alarmIdArr = request.getParameterValues("checkOne");
		//String alarmId = request.getParameter("checkOne");
		String userid = request.getParameter("userid");
		String i18nLanguageStr = request.getParameter("i18nLanguage");
		//String[] alarmIdArr = alarmId.split(",");
		//2.处理业务逻辑
		if(alarmIdArr != null) {
			UserService us = new UserServiceImpl();
			//int result =0;
			int result = us.deleteAlarmMessage(alarmIdArr);
			//3.分发转向
			if(result > 0) {
				if(i18nLanguageStr.equals("zh-CN")) {	
					request.setAttribute("message", "成功删除"+result+" 条记录!");
				}else {
					request.setAttribute("message", "Successfully deleted "+result+" records!");
				}
				request.setAttribute("userid", userid);
				request.setAttribute("i18nLanguage", i18nLanguageStr);
				request.getRequestDispatcher("/admin/alarmMessageForm.jsp").forward(request, response);
			}else {
				if(i18nLanguageStr.equals("zh-CN")) {	
					request.setAttribute("message", "删除失败!");
				}else {
					request.setAttribute("message", "Delete failed!");
				}
				request.setAttribute("userid", userid);
				request.setAttribute("i18nLanguage", i18nLanguageStr);
				request.getRequestDispatcher("/admin/alarmMessageForm.jsp").forward(request, response);
			}
			
		}else {
			request.setAttribute("message", "未选择删除对象!");
			request.setAttribute("userid", userid);
			request.getRequestDispatcher("/admin/alarmMessageForm.jsp").forward(request, response);
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
