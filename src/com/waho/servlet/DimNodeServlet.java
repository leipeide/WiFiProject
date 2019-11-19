package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.service.NodeService;
import com.waho.service.impl.NodeServiceImpl;

/**
 * Servlet implementation class DimNodeServlet
 */
@WebServlet("/dimNodeServlet")
public class DimNodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DimNodeServlet() {
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
		String percentage = request.getParameter("percentage");
		String nodeid = request.getParameter("nodeid");
		
		//2.处理业务逻辑
		if (nodeid != null) {// 数据有效
			// 调用业务逻辑
			NodeService nodeService = new NodeServiceImpl();
			if (nodeService.dimNodeControl(Integer.parseInt(nodeid),Integer.parseInt(percentage))) {
				/* 分发转向,
				 * 注意：该页面英文勿动，
				 *前端根据返回的字符串判断去语言库获取相应的字符串，修改后可能与前端判断的字符串对不上
				*/
				response.getWriter().write(JSON.toJSONString("指令发送成功"));
			} else {
				response.getWriter().write(JSON.toJSONString("指令发送失败请检查设备是否已离线"));
			}
			
		}else{
			response.getWriter().write(JSON.toJSONString("提交失败"));
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
