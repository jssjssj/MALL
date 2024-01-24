<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Orders paramOrders = new Orders();
	paramOrders.setOrdersNo(Integer.parseInt(request.getParameter("ordersNo")));
	
	OrdersDao ordersDao = new OrdersDao();
	ordersDao.delete(paramOrders);
	
	response.sendRedirect(request.getContextPath()+"/order/orderView.jsp");
%>