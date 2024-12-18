package com.aadhar_management_system.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aadhar_management_system.service.UserService;
import com.aadhar_management_system.service.UserServiceImpl;

@WebServlet("/DeleteServletController")
public class DeleteServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user_id = request.getParameter("userId");
	    PrintWriter out = response.getWriter();
		int id = Integer.parseInt(user_id);
		UserService userService = new UserServiceImpl();
		int status= userService.deleteUser(id);
		if(status > 0) {
			out.print("true");
		}
		else {
			out.print("false");
		}
	}
}