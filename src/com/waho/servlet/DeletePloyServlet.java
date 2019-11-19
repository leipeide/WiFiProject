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
 * Servlet implementation class DeletePloyServlet
 */
@WebServlet("/deletePloyServlet")
public class DeletePloyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletePloyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		//1.获取表单数据
		String userid = request.getParameter("userid");
		String ployid = request.getParameter("ployid");
		//2.处理业务逻辑
		if(null != userid && "".equals(userid) == false && null != ployid && "".equals(ployid) ==false) {
			UserService us = new UserServiceImpl();
			int result =  us.deletePloy(Integer.parseInt(userid),Integer.parseInt(ployid));
			/**
			 * 3.分发转向
			 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库，
			 * 若修改，需要前后端统一
			 */
			if(result > 0) {
				String res = "删除成功";
				response.getWriter().write(JSON.toJSONString(res));
			}else {
				String res = "删除失败";
				response.getWriter().write(JSON.toJSONString(res));
			}
			return;
		}
		String res = "删除失败";
		response.getWriter().write(JSON.toJSONString(res));
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
