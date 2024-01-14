<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Cart cart = new Cart();
	cart.setCartNo(Integer.parseInt(request.getParameter("cartNo")));
	
	CartDao cartDao = new CartDao();
	cartDao.minusUpdate(cart);
	
	response.sendRedirect(request.getContextPath()+"/cart/list.jsp");
%>