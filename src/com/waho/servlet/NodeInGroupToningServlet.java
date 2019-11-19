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
 * Servlet implementation class NodeInGroupToningServlet
 */
@WebServlet("/nodeInGroupToningServlet")
public class NodeInGroupToningServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NodeInGroupToningServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		// 1.获取表单数据
		String nodeidStr = request.getParameter("nodeid");
		String tonPercentageStr = request.getParameter("tonPercentage");
		// 2.处理业务逻辑
		if(null != nodeidStr && "" != nodeidStr && null != tonPercentageStr && "" != tonPercentageStr) {
			int nodeid = Integer.parseInt(nodeidStr);
			int tonPercentage = Integer.parseInt(tonPercentageStr);
			NodeService nodeService = new NodeServiceImpl();
			Boolean result = nodeService.NodeInGroupToningCmd(nodeid,tonPercentage);
			// 3.分发转向
			if(result) {
				response.getWriter().write(JSON.toJSONString("指令发送成功"));
			}else {
				response.getWriter().write(JSON.toJSONString("发送失败请检查设备是否已离线"));
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
