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
 * Servlet implementation class GroupDimServlet
 */
@WebServlet("/groupDimServlet")
public class GroupDimServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupDimServlet() {
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
		String dimValueStr = request.getParameter("percentage");
		String useridStr = request.getParameter("userid");
		String groupidStr = request.getParameter("groupid");
		//2.处理业务逻辑
		if (useridStr != null && "".equals(useridStr) == false && dimValueStr != null 
				&& "".equals(dimValueStr) == false && groupidStr != null && "".equals(groupidStr) == false ) {
			
			UserService us = new UserServiceImpl();
			int userid = Integer.parseInt(useridStr);
			int groupid = Integer.parseInt(groupidStr);
			int dimValue = Integer.parseInt(dimValueStr);
			int result = us.groupBroadcastDimByPwm(userid,groupid,dimValue);
			if(result > 0) {
				response.getWriter().write("成功发送了" + result + "条指令!");
			}else {
				response.getWriter().write("指令发送失败，请检查设备是否离线或分组内无节点！");
			}
		}else {
			response.getWriter().write("提交失败!");
		}
		//3.分发转向
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
