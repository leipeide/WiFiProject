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
 * Servlet implementation class GroupLuxDimServlet
 */
@WebServlet("/groupLuxDimServlet")
public class GroupLuxDimServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupLuxDimServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		//1.获取表单上数据
		String useridStr = request.getParameter("userid");
		String groupidStr = request.getParameter("groupid");
		String luxParamStr = request.getParameter("luxParam");
		String switchState = request.getParameter("switchState");
		//2.处理业务逻辑
		if(null != useridStr && "".equals(useridStr) == false && null != groupidStr 
				&& "".equals(groupidStr) == false && null != luxParamStr && "".equals(luxParamStr) == false) {
			
			int userid = Integer.parseInt(useridStr);
			int groupid = Integer.parseInt(groupidStr);
			int luxParam = Integer.parseInt(luxParamStr);
			String Cmd = "";
			if(switchState != null && switchState.equals("on")) {
				Cmd = "autoluxdim";
			} else {
				Cmd = "luxdim";
			}
			UserService us = new UserServiceImpl();
			int result = us.groupWriteLuxDimCmd(userid,groupid,luxParam,Cmd);
			//3.分发转向
			if(result > 0) {
				response.getWriter().write("成功发送了" + result + "条调光指令！");
			}else {
				response.getWriter().write("指令发送失败，请检查设备是否离线或分组内无节点！");
			}
			return;
		}
		//3.分发转向
		response.getWriter().write("提交失败！");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
