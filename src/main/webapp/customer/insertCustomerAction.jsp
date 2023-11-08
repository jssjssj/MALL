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
	String address = request.getParameter("address");
	
	// 지정?
	CustomerDao customerDao = new CustomerDao(); 
	Customer customer = new Customer();
	CustomerAddrDao customerAddrDao = new CustomerAddrDao();
	CustomerAddr customerAddr = new CustomerAddr();
	
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	customerAddr.setAddress(address);

	
	int row1 = customerDao.insertCustomer(customer);
	int row2 = customerAddrDao.insertCustomerAddr(customerAddr);
	
	if(row1 == 1 && row2 == 1) {
		System.out.println("insert회원가입 성공" + address);
		response.sendRedirect(request.getContextPath()+"/customer/customerLoginForm.jsp"
		);
	}
	
%>