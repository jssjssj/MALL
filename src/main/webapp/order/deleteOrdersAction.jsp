<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.* , dao.*" %>
<%@ page import="java.util.*" %>
<%
	String customerId = (String)(session.getAttribute("loginId"));

		Orders orders = new Orders();
		List<Orders> ordersList = new ArrayList<>();
		
		OrdersDao ordersDao = new OrdersDao();
		
		ordersList = ordersDao.select(customerId);
		int ordersNo = Integer.parseInt(request.getParameter("ordersNo")); 숫자형식 오류
		int row = ordersDao.delete(ordersNo); 
		if(row >0 ){
		System.out.println(ordersNo);
		System.out.println("주문취소 완료");
		response.sendRedirect(request.getContextPath()+"/order/orderView.jsp");
		} else {
			System.out.println("삭제실패");
			response.sendRedirect(request.getContextPath()+"/order/orderView.jsp");
		}
%>

