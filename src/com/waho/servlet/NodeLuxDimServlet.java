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
 * Servlet implementation class NodeLuxDimServlet
 */
@WebServlet("/nodeLuxDimServlet")
public class NodeLuxDimServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NodeLuxDimServlet() {
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
		String lux = request.getParameter("lux");
		String nodeid = request.getParameter("nodeid");
		String switchState = request.getParameter("switchState");
		//2.处理业务逻辑
		String cmd = "";
		if(switchState != null && switchState.equals("true")) {
			cmd = "autoluxdim"; //check选中时为自动调光
		} else {
			cmd = "luxdim";
		}
		if(nodeid != null) {
			NodeService nodeService = new NodeServiceImpl();
			boolean result = nodeService.wifiNodeLuxDimByNodeid(Integer.parseInt(nodeid),Integer.parseInt(lux),cmd);
			if(result) {
				/**
				 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库，若修改，需要前后端统一
				 */
				 response.getWriter().write(JSON.toJSONString("指令发送成功"));
				//response.getWriter().write("指令发送成功");
			}else{
				response.getWriter().write(JSON.toJSONString("节点离线或节点不存在"));
				//response.getWriter().write("节点离线或节点不存在");
			}
		}else {
			response.getWriter().write(JSON.toJSONString("提交失败"));
			//response.getWriter().write("提交失败");
		}
		//3.分发转向
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
