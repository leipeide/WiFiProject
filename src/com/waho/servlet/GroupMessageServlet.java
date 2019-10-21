package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.domain.Group;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class GroupMessageServlet
 */
@WebServlet("/groupMessageServlet")
public class GroupMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		//1.获取表单数据
		String userid = request.getParameter("userid");
		String groupid = request.getParameter("groupid");
		
		//2.处理业务逻辑
		if(null != userid && "".equals(userid) == false && null != groupid && "".equals(groupid) == false) {
			UserService us =  new UserServiceImpl();
			Group group = us.getGroupObjByUseridAndGroupid(Integer.parseInt(userid),Integer.parseInt(groupid));
			
			//3.分发转向
			response.getWriter().write(JSON.toJSONString(group));
			//System.out.println(JSON.toJSONString(group));
			return;
		}
		Group group = new Group();
		response.getWriter().write(JSON.toJSONString(group));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
