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
 * Servlet implementation class GroupToningServlet
 */
@WebServlet("/groupToningServlet")
public class GroupToningServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupToningServlet() {
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
		String groupidStr = request.getParameter("groupid");
		String tonPercentageStr = request.getParameter("tonPercentage");
		
		//2.业务逻辑处理
		if(useridStr != null &&  "".equals(useridStr) == false 
				&& null != groupidStr && "".equals(groupidStr) == false
				&& null != tonPercentageStr && "".equals(tonPercentageStr) == false) {
			
			int userid = Integer.parseInt(useridStr);
			int groupid = Integer.parseInt(groupidStr);
			int tonPercentage = Integer.parseInt(tonPercentageStr);
			UserService us = new UserServiceImpl();
			int result = us.writeGroupBroadcastToningCmd(userid,groupid,tonPercentage);
			//3.分发转向
			if(result > 0) {
				response.getWriter().write("成功发送了" + result + "条调色指令!");
			} else {
				response.getWriter().write("指令发送失败，请检查设备是否离线或分组内无节点！");
			}
			return;
		}
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
