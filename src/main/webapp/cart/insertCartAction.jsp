<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<% 
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String customerId = (String)(session.getAttribute("loginId"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	/*Cart cart = new Cart(); */
	CartDao cartDao = new CartDao();
	
	int row = cartDao.insertCart(customerId , goodsNo , quantity);
	if(row>0){
		System.out.println("insertCart 성공");
		response.sendRedirect(request.getContextPath()+"/goods/goodsList.jsp");
	}
%>
