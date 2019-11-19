package com.waho.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.domain.Node;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class BroadcastControlFormServlet
 */
@WebServlet("/broadcastControlFormServlet")
public class BroadcastControlFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BroadcastControlFormServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		//1. 获取表单参数
		String userid = request.getParameter("userid");
		String typeParam = request.getParameter("typeParam");
		String i18nLanguageStr = request.getParameter("i18nLanguage");
		
		//2.调用业务逻辑
		if(userid != null && userid != "" && typeParam != null && typeParam != "") {
			
			if(typeParam.equals("ballastBC")) { //由镇流器页面点击的广播控制；跳转到镇流器广播控制页面
				//3.分发转向
				request.setAttribute("userid", userid);
				request.setAttribute("i18nLanguage", i18nLanguageStr);
				request.getRequestDispatcher("/admin/ballastBroadcastControlForm.jsp").forward(request, response);
			
			}else if(typeParam.equals("ledBC")) {//由led驱动器页面点击的广播控制；跳转到led驱动器广播控制页面
				//3.分发转向
				request.setAttribute("userid", userid);
				request.setAttribute("i18nLanguage", i18nLanguageStr);
				request.getRequestDispatcher("/admin/ledBroadcastControlForm.jsp").forward(request, response);
				
			}else if(typeParam.equals("wifiBC")){//由wifi无线调光器页面点击的广播控制；跳转到wifi无线调光器广播控制页面
				//3.分发转向
				request.setAttribute("userid", userid);
				request.setAttribute("i18nLanguage", i18nLanguageStr);
				request.getRequestDispatcher("/admin/wifiBroadcastControlForm.jsp").forward(request, response);
			}
			
			
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
