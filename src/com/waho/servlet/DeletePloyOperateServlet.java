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
 * Servlet implementation class DeletePloyOperateServlet
 */
@WebServlet("/deletePloyOperateServlet")
public class DeletePloyOperateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletePloyOperateServlet() {
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
		String operateId = request.getParameter("operateId"); 
		//System.out.println("operateId:"+operateId);
		//2.处理业务逻辑
		if(operateId != null && operateId != ""){
			UserService us = new UserServiceImpl();
			boolean result = us.deletePloyOperate(Integer.parseInt(operateId));
			if(result) {
				response.getWriter().write("删除成功!");
			}else {
				response.getWriter().write("删除失败!");
			}
		    return;
		}
		//3.分发转向
		response.getWriter().write("参数不完整，删除失败!");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
