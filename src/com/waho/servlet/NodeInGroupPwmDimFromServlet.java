package com.waho.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class NodeInGroupPwmDimFromServlet
 */
@WebServlet("/nodeInGroupPwmDimFromServlet")
public class NodeInGroupPwmDimFromServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NodeInGroupPwmDimFromServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		// 1.获取表单数据
		String nodeid = request.getParameter("nodeid");
		String i18nLanguageStr = request.getParameter("i18nLanguage");
		//System.out.println("i18nLanguageSt:"+i18nLanguageStr);
		// 2.分发转向
		request.setAttribute("nodeid", nodeid);
		request.setAttribute("i18nLanguage", i18nLanguageStr);
		request.getRequestDispatcher("/admin/NodeInGroupDimForm.jsp").forward(request, response);
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
