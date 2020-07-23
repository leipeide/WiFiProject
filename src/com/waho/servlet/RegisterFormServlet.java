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
 * Servlet implementation class RegisterFormServlet
 */
@WebServlet("/registerFormServlet")
public class RegisterFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterFormServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		// 获取表单数据
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String passwordrep = request.getParameter("passwordrep"); //验证密码
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String i18nLanguage = request.getParameter("i18nLanguage");
		// 调用业务逻辑
		if(password.equals(passwordrep)) { //2次密码一致
			UserService userService = new UserServiceImpl();
			Boolean result = userService.userRegister(username, password, email, phone);//执行注册
			// 分发转向
			if (result == true) {
				if(i18nLanguage.equals("zh-CN")) {
					response.setHeader("refresh","3;/wifiProject");//客户端
					//response.setHeader("refresh","3;/wifiProject1");//本地测试
					//response.getWriter().write("注册成功，3秒后跳转到登录页面！");
				}else {
					response.setHeader("refresh","3;/wifiProject");//客户端
					//response.setHeader("refresh","3;/wifiProject1");//本地测试
					response.getWriter().write("Registered successfully, jump to login page in 3 seconds !");
				}
			} else {
				if(i18nLanguage.equals("zh-CN")) {
					request.setAttribute("registFail", "注册失败！");
					request.getRequestDispatcher("/admin/register.jsp").forward(request, response);
				}else {
					request.setAttribute("registFail", "registration failure !");
					request.getRequestDispatcher("/admin/register.jsp").forward(request, response);
				}
			}
			
		}else { //2次密码不一致
			if(i18nLanguage.equals("zh-CN")) {
				request.setAttribute("registFail", "两次密码不一致！");
				request.getRequestDispatcher("/admin/register.jsp").forward(request, response);
			}else {
				request.setAttribute("registFail", "Two passwords are inconsistent !");
				request.getRequestDispatcher("/admin/register.jsp").forward(request, response);
			}
			
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
