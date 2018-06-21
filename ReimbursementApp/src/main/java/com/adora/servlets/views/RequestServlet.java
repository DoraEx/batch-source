package com.adora.servlets.views;



import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.adora.managers.SessionManager;



public class RequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		// employee requests
		if(SessionManager.isManager(request)) {
			System.out.println(SessionManager.getEmployeeId(request));
			request.getRequestDispatcher("/view/manager/requests.html").forward(request, response);
		} else {
			request.getRequestDispatcher("/view/employee/requests.html").forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
