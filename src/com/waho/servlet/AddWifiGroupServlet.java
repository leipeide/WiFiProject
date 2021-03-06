package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.dao.GroupDao;
import com.waho.dao.impl.GroupDaoImpl;
import com.waho.domain.Group;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class AddWifiGroupServlet
 */
@WebServlet("/addWifiGroupServlet")
public class AddWifiGroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddWifiGroupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		//1.获取表单数据
		String userid = request.getParameter("userid");
		String groupName = request.getParameter("newName");
		//2.业务逻辑处理
		if(null != userid) {
			UserService userService = new UserServiceImpl();
			GroupDao groupDao = new GroupDaoImpl();
			Group group;
			try {
				group = groupDao.selectGroupByGroupNameAndUserid(groupName,Integer.parseInt(userid));
				if(group == null) {
					if(userService.addWifiGroupToUser(groupName,Integer.parseInt(userid))) {
						response.getWriter().write(JSON.toJSONString("新建分组成功"));
					}else {
						response.getWriter().write(JSON.toJSONString("新建分组失败"));
					}
				}else {
					response.getWriter().write(JSON.toJSONString("该分组已存在"));
				}
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else {
			response.getWriter().write(JSON.toJSONString("新建分组失败"));
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
