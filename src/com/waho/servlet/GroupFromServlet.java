package com.waho.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class GroupFromServlet
 */
@WebServlet("/groupFromServlet")
public class GroupFromServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupFromServlet() {
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
		String userid = request.getParameter("userid");
		//2.处理业务逻辑
		UserService userService = new UserServiceImpl();
		Map<String,Object> GroupMap = userService.getGroupByUserid(Integer.parseInt(userid));
		//3.分发转向
		request.setAttribute("userid", userid);
		request.setAttribute("GroupMap", GroupMap);
		request.getRequestDispatcher("/admin/groupFrom.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
