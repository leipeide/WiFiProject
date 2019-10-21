package com.waho.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.domain.Node;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class AddLedToLedGroupFromServlet
 */
@WebServlet("/addLedToLedGroupFromServlet")
public class AddLedToLedGroupFromServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddLedToLedGroupFromServlet() {
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
		String groupid = request.getParameter("groupid");
		String userid = request.getParameter("userid");
 		//2.处理业务逻辑
		if(groupid != null && "".equals(groupid) == false && userid != null && "".equals(userid) == false) {
			UserService us = new UserServiceImpl();
			List<Node> leds = us.getLedNodes(Integer.parseInt(userid));
			//3.分发转向
			if (leds.size() != 0) {
				request.setAttribute("leds", leds);
			}
			request.setAttribute("groupid", groupid);
			request.getRequestDispatcher("/admin/addLedToLedGroupFrom.jsp").forward(request, response);
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
