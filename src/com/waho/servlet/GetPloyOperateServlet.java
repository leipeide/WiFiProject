package com.waho.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.domain.PloyOperate;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class GetPloyOperateServlet
 */
@WebServlet("/getPloyOperateServlet")
public class GetPloyOperateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPloyOperateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=utf-8");
		
		//1.获取表单数据
		String ployid = request.getParameter("ployid");
		//System.out.println("进入获取单个策略；ployid:"+ployid);
		//2.处理业务逻辑
		if(ployid != null && ployid != "") {
			UserService us = new UserServiceImpl();
			List<PloyOperate> operateList = us.getPloyOperate(Integer.parseInt(ployid));
			//3.分发转向
			response.getWriter().write(JSON.toJSONString(operateList));
			//System.out.println("operateList:"+JSON.toJSONString(operateList));
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
