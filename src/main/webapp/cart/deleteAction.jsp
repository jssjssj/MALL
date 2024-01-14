<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	int cartNo = Integer.parseInt(request.getParameter("cartNo"));
	Cart cart = new Cart();
	cart.setCartNo(cartNo);

	CartDao cartDao = new CartDao();
	cartDao.delete(cart);

	response.sendRedirect(request.getContextPath()+"/cart/list.jsp");


%>