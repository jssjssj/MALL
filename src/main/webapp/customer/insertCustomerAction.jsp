<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
	// 객체 값 넣기
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String address = request.getParameter("address");
	String customerName = request.getParameter("customerName"); //detail
	String customerPhone = request.getParameter("customerPhone"); //detail
	
	
	// 지정?
	CustomerDao customerDao = new CustomerDao(); 
	CustomerAddrDao customerAddrDao = new CustomerAddrDao();
		
	CustomerAddr customerAddr = new CustomerAddr();
	Customer customer = new Customer();
	
	customerAddr.setAddress(address);
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	
	
	int row1 = customerDao.insertCustomer(customer);
	int row2 = customerAddrDao.insertCustomerAddr(customerAddr);
	
	if(row1 == 1 && row2 == 1) {
		System.out.println("insert 성공");
		response.sendRedirect(request.getContextPath()+"/110011/index.jsp");
	}
	
%>