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
 * Servlet implementation class AddBallestToGroupServlet
 */
@WebServlet("/addBallestToGroupServlet")
public class AddBallestToGroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddBallestToGroupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json,charset=utf-8");
		//response.setContentType("text/html;charset=utf-8");
		//1.获取表单数据
		String groupid = request.getParameter("groupid");
		String ballestMacArrStr = request.getParameter("checkboxValue");
		String[] ballestMacArr = ballestMacArrStr.split(",");
		//2.业务处理逻辑
		if(null != groupid && "" != groupid) {
			UserService us = new UserServiceImpl();
			int result = us.addNodeToGroup(Integer.parseInt(groupid),ballestMacArr);
			/**
		     * 3.分发转向
			 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库；
			 * 若修改，需要前后端统一
			 */
			if(result > 0) {
				 response.getWriter().write(JSON.toJSONString(result));
			}else {
				response.getWriter().write(JSON.toJSONString("添加失败"));
			}
		}else {
			response.getWriter().write(JSON.toJSONString("提交失败"));
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
