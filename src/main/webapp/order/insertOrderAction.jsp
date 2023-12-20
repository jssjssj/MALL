<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*"%> 
<%
	String customerId = (String)(session.getAttribute("loginId"));
	System.out.print(customerId + "<-- customerId");
	CustomerDao customerDao = new CustomerDao();
	Customer c = customerDao.customerOne(customerId);

	OrdersDao ordersDao = new OrdersDao();	
	Orders paramOrders = new Orders();
	

	
	paramOrders.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
	paramOrders.setCustomerNo(c.getCustomerNo());
	paramOrders.setCustomerAddrNo(c.getCustomerAddr().getCustomerAddrNo());
	paramOrders.setQuantity(Integer.parseInt(request.getParameter("quantity")));
	paramOrders.setTotalPrice(Integer.parseInt(request.getParameter("totalPrice")));
	
	
	
	ordersDao.insertOrder(paramOrders);
	response.sendRedirect(request.getContextPath()+"/order/orderView.jsp");
%>
