package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.waho.service.NodeService;
import com.waho.service.impl.NodeServiceImpl;

/**
 * Servlet implementation class SwitchNodeServlet
 */
@WebServlet("/switchNodeServlet")
public class SwitchNodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SwitchNodeServlet() {
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
		String nodeidStr = request.getParameter("nodeid");
		String switchState = request.getParameter("switcher");
		//2.调用业务逻辑
		if (nodeidStr != null) {// 数据有效
			NodeService nodeService = new NodeServiceImpl();
			int nodeid = Integer.parseInt(nodeidStr);
			if (nodeService.switchNodeControl(nodeid, switchState)) {
				//3.分发转向
				Object res = "指令发送成功";
				String dataJson = JSONObject.toJSONString(res);
				response.getWriter().write(dataJson);
			} else {
				Object res = "指令发送失败请检查设备是否已离线";
				String dataJson = JSONObject.toJSONString(res);
				response.getWriter().write(dataJson);
			}
			return;
		}else {
			Object res = "提交失败";
			String dataJson = JSONObject.toJSONString(res);
			response.getWriter().write(dataJson);
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
