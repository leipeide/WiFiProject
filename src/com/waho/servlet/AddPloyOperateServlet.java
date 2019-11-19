package com.waho.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.waho.service.UserService;
import com.waho.service.impl.UserServiceImpl;

/**
 * Servlet implementation class AddPloyOperateServlet
 */
@WebServlet("/addPloyOperateServlet")
public class AddPloyOperateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPloyOperateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//1.获取功能类型字符串；
		String functionStr = request.getParameter("functionStr"); //功能类型字符串;根据他选择功能函数；功能种类字符串类型：switch 、 dim、 toning;
		String functionParamStr = request.getParameter("paramValue"); //switch功能对应boolean类型；dim、 toning对应整数类型
		String useridStr = request.getParameter("userid"); //用户id
		String ployidStr = request.getParameter("ployid"); //策略id
		String hoursStr = request.getParameter("hours");  //策略操作执行的时间：小时
		String minutesStr = request.getParameter("minutes"); //策略操作执行的时间：分钟
		String startDateStr = request.getParameter("startDate"); //策略操作执行的日期范围：开始日期
		String endDateStr = request.getParameter("endDate"); //策略操作执行的日期范围：结束日期
		
		//2.处理业务逻辑
		if(functionStr != "" && functionParamStr != "" && useridStr != "" && ployidStr != "" 
				&& hoursStr != "" && minutesStr != "" && startDateStr != "" && endDateStr != "") {
			
			int userid = Integer.parseInt(useridStr);
			int ployid = Integer.parseInt(ployidStr);
			int hours = Integer.parseInt(hoursStr);
			int minutes = Integer.parseInt(minutesStr);
			int value = 0; // 调光或调色的0-100
		    //注意：SimpleDateFormat构造函数的样式与需要转换的样式必须相符
		    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
		    
			try {
					Date startDate = simpleDateFormat.parse(startDateStr);
					Date endDate = simpleDateFormat.parse(endDateStr);
				    if(functionParamStr.equals("true")) {
				    	value = 1;
				    }else if(functionParamStr.equals("false")) {
				    	value = 0;
				    }else {
				    	value = Integer.parseInt(functionParamStr);
				    }
					UserService us = new UserServiceImpl();
					
					/**
					 * 3.判断功能类型，执行相应的功能函数
					 * 注意：此处的中文不要轻易的去改，涉及到前端判断字符串去查询相应的语言库，
					 * 若修改，需要前后端统一
					 */
					if(functionStr.equals("switch")) { // 添加开关灯策略操作
						boolean result = us.addPloyOperateOfSwitch(userid,ployid,hours,minutes,startDate,endDate,value);
						if(result) {
							String res = "操作成功";
							response.getWriter().write(res);
						}else {
							String res = "操作失败";
							response.getWriter().write(res);
						}
						
					}else if(functionStr.equals("dim")) { // 添加调光策略操作
						boolean result = us.addPloyOperateOfDim(userid,ployid,hours,minutes,startDate,endDate,value);
						if(result) {
							String res = "操作成功";
							response.getWriter().write(res);
						}else {
							String res = "操作失败";
							response.getWriter().write(res);
						}
						
						
					}else {// 添加调色策略操作
						boolean result = us.addPloyOperateOfToning(userid,ployid,hours,minutes,startDate,endDate,value);
						if(result) {
							String res = "操作成功";
							response.getWriter().write(res);
						}else {
							String res = "操作失败";
							response.getWriter().write(res);
						}
					}
			
			
			
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   
		}else {
			String res = "参数不完整";
			response.getWriter().write(res);
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
