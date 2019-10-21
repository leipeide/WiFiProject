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
 * Servlet implementation class BallastBroadcastControlServlet
 */
@WebServlet("/ballastBroadcastControlServlet")
public class BallastBroadcastControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BallastBroadcastControlServlet() {
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
		//功能种类字符串：switch 、 dim;
		String functionStr = request.getParameter("functionStr");
		String paramValue = request.getParameter("paramValue");
		//2.处理业务逻辑
		NodeService nodeService = new NodeServiceImpl();
		Boolean result = nodeService.writeBallastBroadcastCmd(Integer.parseInt(userid),Integer.parseInt(paramValue),functionStr);
		//3.分发转向
		if(result) {
			response.getWriter().write(JSON.toJSONString("指令发送成功!"));
		}else {
			response.getWriter().write(JSON.toJSONString("节点离线或不存在节点!"));
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
