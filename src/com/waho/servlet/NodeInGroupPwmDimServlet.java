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
 * Servlet implementation class nodeInGroupPwmDimServlet
 */
@WebServlet(name = "NodeInGroupPwmDimServlet", urlPatterns = { "/nodeInGroupPwmDimServlet" })
public class NodeInGroupPwmDimServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NodeInGroupPwmDimServlet() {
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
		if (nodeid != null && "" != nodeid) {// 数据有效
			// 调用业务逻辑
			NodeService nodeService = new NodeServiceImpl();
			if (nodeService.nodeInGroupPwmDimCmd(Integer.parseInt(nodeid),Integer.parseInt(percentage))) {
			   /**
			     * // 分发转向
			     * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库;
			     * 若修改，需要前后端统一
			    */
				response.getWriter().write(JSON.toJSONString("发送成功"));
			} else {
				response.getWriter().write(JSON.toJSONString("发送失败请检查设备是否已离线"));
			}
			//return;
		}else {
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
