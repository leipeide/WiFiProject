package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.service.NodeService;
import com.waho.service.UserService;
import com.waho.service.impl.NodeServiceImpl;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class ColorControlServlet
 */
@WebServlet("/colorControlServlet")
public class ColorControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ColorControlServlet() {
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
		String tonPercentage = request.getParameter("tonPercentage");
		String nodeIdArr = request.getParameter("nodesId");
		String[] nodeId = nodeIdArr.split(",");
		//2.处理业务逻辑
		NodeService nodeService = new NodeServiceImpl();
		int result = nodeService.ColorControlBroadcast(Integer.parseInt(tonPercentage),nodeId);
		//3.分发转向
		if(result > 0) {
			response.getWriter().write("成功发送了" + result + "条调色指令!");
		} else {
			response.getWriter().write("指令发送失败！");
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
