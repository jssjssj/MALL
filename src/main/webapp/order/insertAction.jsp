<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.* "%>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	
	
	Orders orders = new Orders();
	orders.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
	orders.setCustomerNo(loginCustomer.getCustomerNo());
	orders.setCustomerAddrNo(loginCustomer.getCustomerAddrNo());
	orders.setQuantity(Integer.parseInt(request.getParameter("quantity")));
	
	orders.setTotalPrice(Integer.parseInt(request.getParameter("totalPrice")));
	
	
	System.out.println(orders.toString());
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.insert(orders);













%> 