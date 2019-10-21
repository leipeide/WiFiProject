package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.dao.GroupDao;
import com.waho.dao.impl.GroupDaoImpl;
import com.waho.domain.Group;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class GroupRenameServlet
 */
@WebServlet("/groupRenameServlet")
public class GroupRenameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupRenameServlet() {
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
		String groupName = request.getParameter("newName");
		//2.处理业务逻辑
		UserService us = new UserServiceImpl();
		GroupDao groupDao = new GroupDaoImpl();
		try {
			//3.查找该用下是否已存在该用户名
			Group group = groupDao.selectGroupByGroupNameAndUserid(groupName,Integer.parseInt(userid));
			if(group == null) {
				int result = us.renameGroupName(Integer.parseInt(userid),Integer.parseInt(groupid),groupName);
				//4.分发转向
				if(result == 1) {
					response.getWriter().write("修改成功！");
				}else {
					response.getWriter().write("修改失败！");
				}
			}else {
				response.getWriter().write("该名称已存在！");
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
