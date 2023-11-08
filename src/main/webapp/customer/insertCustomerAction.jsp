<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<% 
	// 객체 값 넣기
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	
	
	// 지정?
	CustomerDao customerDao = new CustomerDao(); 
	Customer customer = new Customer();
	
	
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	

	
	int row1 = customerDao.insertCustomer(customer);
	
	
	if(row1 == 1) {
		System.out.println("insert회원가입 성공");
		response.sendRedirect(request.getContextPath()+"/customer/customerLoginForm.jsp"
		);
	}
	
%>