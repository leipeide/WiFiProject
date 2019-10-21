package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.waho.service.NodeService;
import com.waho.service.UserService;
import com.waho.service.impl.NodeServiceImpl;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class WifiBroadcastControlServlet
 */
@WebServlet("/wifiBroadcastControlServlet")
public class WifiBroadcastControlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WifiBroadcastControlServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		//1.获取表单上数据
		String useridStr = request.getParameter("userid");
		String luxParamStr = request.getParameter("luxParam");
		String switchState = request.getParameter("switchState");
		//2.处理业务逻辑
		if(null != useridStr && "".equals(useridStr) == false && 
				null != luxParamStr && "".equals(luxParamStr) == false) {
			
			int userid = Integer.parseInt(useridStr);
			int luxParam = Integer.parseInt(luxParamStr);
			String Cmd = "";
			if(switchState != null && switchState.equals("on")) {
				Cmd = "autoluxdim";
			} else {
				Cmd = "luxdim";
			}
			System.out.println("用户id："+userid+"lux调光类型："+Cmd+"广播功能参数："+luxParamStr);
			//2.处理业务逻辑
			NodeService nodeService = new NodeServiceImpl();
			Boolean result = nodeService.writeWifiBroadcastCmd(Integer.parseInt(useridStr),Integer.parseInt(luxParamStr),Cmd);
			//3.分发转向
			if(result) {
				response.getWriter().write("指令发送成功!");
			}else {
				response.getWriter().write("节点离线或不存在节点!");
			}
			return;
		}
		//3.分发转向
		response.getWriter().write("提交失败！");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
