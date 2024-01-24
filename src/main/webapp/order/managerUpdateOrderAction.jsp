<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Orders paramOrders = new Orders();
	paramOrders.setOrdersNo(Integer.parseInt(request.getParameter("ordersNo")));
	
	String ordersState = request.getParameter("ordersState");
	if(ordersState.equals("주문완료")){
		paramOrders.setOrdersState("배송출발");
	} else if(ordersState.equals("배송출발")){
		paramOrders.setOrdersState("배송완료");
	}
	System.out.println(paramOrders.getOrdersNo());
	OrdersDao ordersDao = new OrdersDao();
	int result = ordersDao.update(paramOrders);
	response.sendRedirect(request.getContextPath()+ "/order/managerOrderView.jsp");
	
%>
