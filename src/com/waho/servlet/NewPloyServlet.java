package com.waho.servlet;


import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.domain.Ploy;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class NewPloyServlet
 */
@WebServlet("/newPloyServlet")
public class NewPloyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewPloyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		//1.获取表单数据
		String useridStr = request.getParameter("userid");
		String groupTypeStr = request.getParameter("groupType");
		String groupidStr = request.getParameter("groupid");
		String ployName = request.getParameter("newName");
		//2.处理业务逻辑
		if(null != useridStr && "".equals(useridStr) == false && null != groupTypeStr && "".equals(groupTypeStr) == false) {
			int userid = Integer.parseInt(useridStr);
			int groupType = Integer.parseInt(groupTypeStr);
			int groupid = Integer.parseInt(groupidStr);
			UserService us = new UserServiceImpl();
			//3.判断新建策略名称是否存在
			List<Ploy> ployList = us.getPloyByUseridAndPloyName(userid, ployName);
			if(ployList.size() == 0) {
				//4.该名称不存在，添加该策略
				if(us.addPloyToUserByGroupidAndGroupType(userid,groupType,groupid,ployName)) {
					response.getWriter().write("新建成功!");
				}else {
					response.getWriter().write("新建失败!");
				}
			}else {
				response.getWriter().write("该名称已存在!");
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
