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
 * Servlet implementation class GroupSwitchServlet
 */
@WebServlet("/groupSwitchServlet")
public class GroupSwitchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupSwitchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		//1.获取表单数据
		String useridStr = request.getParameter("userid");
		String groupidStr = request.getParameter("groupid");
		String switcher = request.getParameter("switcher");
		//2.业务处理逻辑
		if(useridStr != null && "".equals(useridStr) == false && switcher != null && "".equals(switcher) == false
				&& groupidStr != null && "".equals(groupidStr) == false) {
			
			int userid = Integer.parseInt(useridStr);
			int groupid =  Integer.parseInt(groupidStr);
			int switchState = 0;
			//默认pwm调光参数为100%
			int percentage = 100;
			if(switcher.equals("on")) {
				switchState = 1;
			}
			UserService us = new UserServiceImpl();
			int result = us.groupBroadcastSwitchNode(userid,groupid,switchState,percentage);
			if(result > 0) {
				String res = "指令发送成功!";
				response.getWriter().write(res);
			}else {
				String res = "指令发送失败,请检查设备是否离线或分组内无节点!";
				response.getWriter().write(res);
			}
			//3.分发转向
		}else {
			String res = "提交失败!";
			response.getWriter().write(res);
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
