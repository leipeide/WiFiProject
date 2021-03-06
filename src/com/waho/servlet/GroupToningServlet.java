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
		response.setContentType("application/json;charset=utf-8");
		//1.获取表单数据
		String useridStr = request.getParameter("userid");
		String groupidStr = request.getParameter("groupid");
		String tonPercentageStr = request.getParameter("tonPercentage");
		System.out.println("paramValue:"+tonPercentageStr);
		
		//2.业务逻辑处理
		if(useridStr != null &&  "".equals(useridStr) == false 
				&& null != groupidStr && "".equals(groupidStr) == false
				&& null != tonPercentageStr && "".equals(tonPercentageStr) == false) {
			
			int userid = Integer.parseInt(useridStr);
			int groupid = Integer.parseInt(groupidStr);
			int tonPercentage = Integer.parseInt(tonPercentageStr);
			UserService us = new UserServiceImpl();
			int result = us.writeGroupBroadcastToningCmd(userid,groupid,tonPercentage);
		    /**
		     * 3.分发转向
			 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库；
			 * 若修改，需要前后端统一
			 */
			if(result > 0) {
				response.getWriter().write(JSON.toJSONString(result));
			} else {
				response.getWriter().write(JSON.toJSONString("指令发送失败请检查设备是否离线或分组内无节点"));
			}
			return;
		}
		response.getWriter().write(JSON.toJSONString("参数不完整"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
