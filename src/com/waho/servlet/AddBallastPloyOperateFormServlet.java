package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddBallastPloyOperateFormServlet
 */
@WebServlet("/addBallastPloyOperateFormServlet")
public class AddBallastPloyOperateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddBallastPloyOperateFormServlet() {
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
		String userid = request.getParameter("userid");
		String ployid = request.getParameter("ployid");
		String i18nLanguageStr = request.getParameter("i18nLanguage");
		//2.分发转向
		request.setAttribute("userid", userid);
		request.setAttribute("ployid", ployid);
		request.setAttribute("i18nLanguage", i18nLanguageStr);
		request.getRequestDispatcher("/admin/addBallastPloyOperate.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
