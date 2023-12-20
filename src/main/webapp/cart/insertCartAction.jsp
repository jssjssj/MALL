<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<% 
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String customerId = (String)(session.getAttribute("loginId"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	/*Cart cart = new Cart(); */
	CartDao cartDao = new CartDao();
	
	int cartNo = cartDao.selectCart(goodsNo);
	int row = 0;
	if(cartNo==0){
		cartDao.insertCart(customerId , goodsNo , quantity);
	} else {
		cartDao.plusCart(cartNo);
	}

	System.out.println(cartNo+"<-- cartNo");
		response.sendRedirect(request.getContextPath()+"/goods/goodsList.jsp");
	
%>
