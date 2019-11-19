package com.waho.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.domain.Group;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class PloyChangeGroupFormServlet
 */
@WebServlet("/ployChangeGroupFormServlet")
public class PloyChangeGroupFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PloyChangeGroupFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		//1.获取表单数据：策略id,分组id
		String groupTypeStr = request.getParameter("groupType");
		String groupIdStr = request.getParameter("groupid");
		String ployid = request.getParameter("ployid");
		String userIdStr = request.getParameter("userid");
		String i18nLanguageStr = request.getParameter("i18nLanguage");
		//2.初始化group集合
		List<Group> groupList = new ArrayList<>();
		//3.处理业务逻辑
		if(groupTypeStr != null && "" != groupTypeStr && null != groupIdStr &&
				"" != groupIdStr && null != userIdStr && "" != userIdStr) {
			//字符串类型转为整数类型
			int groupType = Integer.parseInt(groupTypeStr);
			int groupid = Integer.parseInt(groupIdStr);
			int userid = Integer.parseInt(userIdStr);
			//获取除了该策略已绑定的其他分组集合
			UserService us = new UserServiceImpl();  
			groupList = us.getGroupByUseridForPloyChangeGroup(groupid, userid,groupType);
		}
		//4.分发转向
		request.setAttribute("groupList", groupList);
		request.setAttribute("groupListSize", groupList.size()); //分组的集合大小
		request.setAttribute("ployid", ployid);
		request.setAttribute("i18nLanguage", i18nLanguageStr);
		request.getRequestDispatcher("/admin/ployChangeGroupForm.jsp").forward(request, response);
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
