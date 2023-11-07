<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String address = request.getParameter("address");


	CustomerAddrDao customerAddrDao = new CustomerAddrDao();	
	
	
	CustomerAddr customerAddr = new CustomerAddr();
	
	customerAddr.setAddress(address);

	int row = customerAddrDao.insertCustomerAddr(customerAddr);
	if(row == 1) {
		System.out.println("insert 성공");
		response.sendRedirect(request.getContextPath()+"/customer/insertCustomerDetailAction.jsp");
	}
%>