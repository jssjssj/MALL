<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*"%>
<%
	CartDao cartDao = new CartDao();
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	System.out.println(cartNo + "<-- cartNo");
	cartDao.plusCart(cartNo);
	response.sendRedirect(request.getContextPath()+"/cart/cartList.jsp");
	
%>