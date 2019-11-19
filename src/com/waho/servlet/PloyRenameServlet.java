package com.waho.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.domain.Ploy;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class PloyRenameServlet
 */
@WebServlet("/ployRenameServlet")
public class PloyRenameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PloyRenameServlet() {
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
		String useridStr = request.getParameter("userid");
		String ployidStr = request.getParameter("ployid");
		String newName = request.getParameter("newName");
		//2.业务逻辑处理
		if(null != useridStr && "".equals(useridStr) == false && null != ployidStr && "".equals(ployidStr) == false 
					&& null != newName && "".equals(newName) == false) {
			
			int userid = Integer.parseInt(useridStr);
			int ployid = Integer.parseInt(ployidStr);
			UserService us = new UserServiceImpl();
			//3.查看修改的策略名是否已存在
			List<Ploy> ployList = us.getPloyByUseridAndPloyName(userid,newName);
			if(ployList.size() == 0) {//该名称策略不存在
				int result = us.ployRename(userid,ployid,newName);
				//3.分发转向
				/**
				 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库，若修改，需要前后端统一
				 */
				if(result != 0) {
					response.getWriter().write(JSON.toJSONString("修改成功"));
				}else {
					response.getWriter().write(JSON.toJSONString("修改失败"));
				}
			}else {//该名称存在
				response.getWriter().write(JSON.toJSONString("该名称已存在"));
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
