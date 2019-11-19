package com.waho.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.dao.NodeDao;
import com.waho.dao.impl.NodeDaoImpl;
import com.waho.domain.Node;
import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class RemoveNodeServlet
 */
@WebServlet("/removeNodeServlet")
public class RemoveNodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveNodeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		// 获取表单数据
		String useridStr = request.getParameter("userid");
		String nodeIdArrStr =  request.getParameter("nodeIdArr"); //节点id字符串
		String[] nodeIdArr =  nodeIdArrStr.split(","); //以","分隔节点id字符串得到多个节点id
		//字符串转集合
		ArrayList<Integer> idList = new ArrayList<Integer>();
		for(int i=0; i < nodeIdArr.length; i++) {
			idList.add(Integer.parseInt(nodeIdArr[i]));
		}
		//处理业务逻辑，从用户下移除节点
		if(useridStr != null && "".equals(useridStr) == false) { //参数正常
			UserService us = new UserServiceImpl();
			int userid = Integer.parseInt(useridStr);
			int result = us.removeNodeById(idList, userid);   
            /**
             * 分发转向
             * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库;
             * 若修改，需要前后端统一
             */
			if(result > 0) {
				response.getWriter().write(JSON.toJSONString(result));
			}else {
				response.getWriter().write(JSON.toJSONString("移除失败"));
			}
			
		}else {//参数为空
			response.getWriter().write(JSON.toJSONString("提交失败"));
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
