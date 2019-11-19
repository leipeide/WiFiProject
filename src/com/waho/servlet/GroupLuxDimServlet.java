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
 * Servlet implementation class GroupLuxDimServlet
 */
@WebServlet("/groupLuxDimServlet")
public class GroupLuxDimServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupLuxDimServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=utf-8");
		//1.获取表单上数据
		String useridStr = request.getParameter("userid");
		String groupidStr = request.getParameter("groupid");
		String luxParamStr = request.getParameter("luxParam");
		String switchState = request.getParameter("switchState");
		//2.处理业务逻辑
		if(null != useridStr && "".equals(useridStr) == false && null != groupidStr 
				&& "".equals(groupidStr) == false && null != luxParamStr && "".equals(luxParamStr) == false) {
			
			int userid = Integer.parseInt(useridStr);
			int groupid = Integer.parseInt(groupidStr);
			int luxParam = Integer.parseInt(luxParamStr);
			String Cmd = "";
			if(switchState != null && switchState.equals("true")) {
				Cmd = "autoluxdim";
			} else {
				Cmd = "luxdim";
			}
			UserService us = new UserServiceImpl();
			int result = us.groupWriteLuxDimCmd(userid,groupid,luxParam,Cmd);
		    /**
		     * 3.分发转向
			 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库，
			 * 若修改，需要前后端统一
			 */
			if(result > 0) {
				//返回成功发送指令的数量
				response.getWriter().write(JSON.toJSONString(result));
			}else {
				response.getWriter().write(JSON.toJSONString("设备离线或分组内无节点"));
			}
			return;
		}
		//3.分发转向
		response.getWriter().write(JSON.toJSONString("提交失败"));
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
