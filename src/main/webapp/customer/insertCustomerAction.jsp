<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
   // 객체 값 넣기
   String customerId = request.getParameter("customerId");
   String customerPw = request.getParameter("customerPw");
   String address = request.getParameter("address");
   String customerName = request.getParameter("customerName");
   String customerPhone = request.getParameter("customerPhone");
   
   
   // 객체 생성
   Customer customer = new Customer();
   CustomerAddr customerAddr = new CustomerAddr();
   CustomerDetail customerDetail = new CustomerDetail();
   
   
   CustomerDao customerDao = new CustomerDao();
   
   // 값 설정
   customer.setCustomerId(customerId);
   customer.setCustomerPw(customerPw);
   customerAddr.setAddress(address);
   customerDetail.setCustomerName(customerName);
   customerDetail.setCustomerPhone(customerPhone);
   
   int row1 = customerDao.insertCustomer(customer, customerAddr, customerDetail);
   
   if(row1 == 1) {
      System.out.println("insert ID , PW 성공");
      response.sendRedirect(request.getContextPath() + "/customer/insertCustomerAddrAction.jsp");
   }
%>