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
	CustomerDetailDao customerDetailDao = new CustomerDetailDao();
		
	
	Customer customer = new Customer();
	CustomerAddr customerAddr = new CustomerAddr();
	CustomerDetail customerDetail = new CustomerDetail();
	
	
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	customerAddr.setAddress(address);
	customerDetail.setCustomerName(customerName);
	customerDetail.setCustomerPhone(customerPhone);

	
	int row1 = customerDao.insertCustomer(customer);
	int row2 = customerAddrDao.insertCustomerAddr(customerAddr);
	int row3 = customerDetailDao.insertCustomerDetail(customerDetail);
	
	if(row1 == 1 && row2 == 1 && row3 == 1) {
		System.out.println("insert 성공");
		response.sendRedirect(request.getContextPath()+"/110011/index.jsp");
	}
	
%>