<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*"%>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	Cart cart = new Cart();
	cart.setCustomerNo(loginCustomer.getCustomerNo());
	cart.setGoodsNo(goodsNo);
	cart.setQuantity(quantity);
	
	System.out.println(cart);
	
	CartDao cartDao = new CartDao();
	cartDao.insert(cart);
	
	response.sendRedirect(request.getContextPath()+"goods/list.jsp");
%>