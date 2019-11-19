package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class RemoveNodeFromGroupServlet
 */
@WebServlet("/removeNodeFromGroupServlet")
public class RemoveNodeFromGroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveNodeFromGroupServlet() {
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
		String nodeid = request.getParameter("nodeid");
		String userid = request.getParameter("userid");
		String groupid = request.getParameter("groupid");
		//2.业务逻辑处理
		if(nodeid != null && nodeid != "" && userid != null && userid != "" && groupid != null && groupid != "") {
			UserService us = new UserServiceImpl();
			boolean result = us.removeNodeFromGroup(Integer.parseInt(userid),Integer.parseInt(nodeid),Integer.parseInt(groupid));
            /**
             * //3.分发转向
             * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库;
             * 若修改，需要前后端统一
             */
			if(result) {
				response.getWriter().write(JSON.toJSONString("节点已从分组内移除"));
			}else {
				response.getWriter().write("移除失败");
			}
		}else {
			response.getWriter().write("参数不完整");
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
