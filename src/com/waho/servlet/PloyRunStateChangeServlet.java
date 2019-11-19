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
 * Servlet implementation class PloyRunStateChangeServlet
 */
@WebServlet("/ployRunStateChangeServlet")
public class PloyRunStateChangeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PloyRunStateChangeServlet() {
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
		String useridStr = request.getParameter("userid");
		String ployidStr = request.getParameter("ployid");
		String runStateStr = request.getParameter("runState");
		//2.处理业务逻辑
		if(useridStr != "" && ployidStr != "" && runStateStr != "") {
			UserService us = new UserServiceImpl();
			int userid = Integer.parseInt(useridStr);
			int ployid = Integer.parseInt(ployidStr);
			int runState = Integer.parseInt(runStateStr);
			int result = us.changePloyRunState(userid,ployid,runState);
			//3.分发转向
			if(result > 0) {
				if(runState == 1) {
					/**
					 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库，
					 * 若修改，需要前后端统一
					 */
					response.getWriter().write("策略已执行");
				}else if(runState == 0){
					response.getWriter().write("停止执行");
				}
			}else {
				response.getWriter().write("指令发送失败");
			}
		}else {
			response.getWriter().write("参数不完整");
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
