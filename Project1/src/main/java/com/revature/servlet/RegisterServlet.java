package com.revature.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.revature.dao.ERSDaoImpl;
import com.revature.pojo.Employee;
import com.revature.servlet.SessionServlet.Info;
import com.revature.util.MailUtil;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ERSDaoImpl dao = new ERSDaoImpl();

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.getRequestDispatcher("register.html").forward(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		SessionServlet.clearMessagesAndErrors();
		
		String user = req.getParameter("username");
		String pass1 = req.getParameter("password1");
		String pass2 = req.getParameter("password2");
		String first = req.getParameter("first");
		String last = req.getParameter("last");
		String title = req.getParameter("title");
		boolean isManager = false;
		if(req.getParameterValues("manager") != null)
			isManager = true;
		
		// search user records for username
		if(dao.getEmployeeByEmail(user) != null) {
			SessionServlet.errors.add(new Info("Email already exists in the database", true));
		}
		if(!Employee.validatePassword(pass1)) {
			SessionServlet.errors.add(new Info("Password does not meet security criteria", true));
		}
		if(!pass1.equals(pass2)) {
			SessionServlet.errors.add(new Info("Passwords do not match", true));
		}
		if(dao.getEmployeeByEmail(user) == null && Employee.validatePassword(pass1)
				&& pass1.equals(pass2) && !first.equals("") && !last.equals("")) {
			Random r = new Random();
			int ID = r.nextInt(90000000) + 10000000;
			while(dao.getEmployeeByID(ID) != null)
				ID = r.nextInt(90000000) + 10000000;
			Employee empl = new Employee(ID, user, pass1, first,
					last, null, title, 0, isManager, new ArrayList<Employee>());
			dao.createEmployee(empl);
			SessionServlet.messages.add(new Info("Successfully created a new account!", true));
			MailUtil.send("p1reimbursements@gmail.com", "Passw0rd---", user, "Welcome to the ERS",
					"Hello " + first + ",\n\nWelcome to the ERS!\n\nYour new EMPL ID is: " + ID +
					"\n\nAnother email will be sent to this address when your manager adds " +
					"your provided EMPL ID to the roster. Please feel free to submit any reimbursement " +
					"requests until that point.\n\nBest,\n\nERS Team");
			res.sendRedirect("login");
		}
		else {
			res.sendRedirect("register");
		}
	}
}
