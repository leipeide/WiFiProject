package com.waho.servlet;

import java.io.IOException;
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
 * Servlet implementation class NewPloyFromServlet
 */
@WebServlet("/newPloyFromServlet")
public class NewPloyFromServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewPloyFromServlet() {
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
		String userid = request.getParameter("userid");
		String groupType = request.getParameter("groupType");
		String i18nLanguageStr = request.getParameter("i18nLanguage");
		//2. 处理业务逻辑
		if(null != userid && "".equals(userid) == false && null != groupType && "".equals(groupType) == false) {
			UserService us = new UserServiceImpl();
			List<Group> groups = us.getGroupByUseridAndGroupType(Integer.parseInt(userid),Integer.parseInt(groupType));
			request.setAttribute("groups", groups);
		}
		//3.分发转向
		request.setAttribute("userid", userid);
		request.setAttribute("groupType", groupType);
		request.setAttribute("i18nLanguage", i18nLanguageStr);
		request.getRequestDispatcher("/admin/newPloy.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	

}
