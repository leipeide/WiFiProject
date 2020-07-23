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
 * Servlet implementation class LedNodeToningServlet
 */
@WebServlet("/ledNodeToningServlet")
public class LedNodeToningServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LedNodeToningServlet() {
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
		String tonPercentage = request.getParameter("tonPercentage");
		//2.处理业务逻辑
		if(nodeid != null && nodeid != "" && tonPercentage != null && tonPercentage !="" ) {
			UserService us = new UserServiceImpl();
			boolean result = us.writeNodeToningCmd(Integer.parseInt(nodeid),Integer.parseInt(tonPercentage));
			//3.分发转向
			if(result) {
				/**
				 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库，
				 * 若修改，需要前后端统一
				 */
				response.getWriter().write(JSON.toJSONString("指令发送成功"));
				
			}else {
				response.getWriter().write(JSON.toJSONString("节点离线或节点不存在"));
				
			}
		}else {
			response.getWriter().write(JSON.toJSONString("参数不完整"));
			
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
