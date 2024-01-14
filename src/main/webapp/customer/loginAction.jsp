<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.*"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Customer paramCustomer = new Customer();
	paramCustomer.setCustomerId(request.getParameter("customerId"));
	paramCustomer.setCustomerPw(request.getParameter("customerPw"));

	CustomerDao customerDao = new CustomerDao();
	Customer loginCustomer = customerDao.login(paramCustomer);
	
	if(loginCustomer != null) { // 로그인 성공
		session.setAttribute("loginCustomer", loginCustomer);
		response.sendRedirect(request.getContextPath()+"/public/home.jsp");
	}	else {
		response.sendRedirect(request.getContextPath()+"/public/loginForm.jsp");
	}
%>