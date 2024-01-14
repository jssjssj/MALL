<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	Cart cart = new Cart();
	cart.setCustomerNo(loginCustomer.getCustomerNo());
	cart.setGoodsNo(goodsNo);
	cart.setQuantity(quantity);

	CartDao cartDao = new CartDao();
	Cart checkCart = cartDao.selectGoods(cart);
	if(checkCart == null){
		cartDao.insert(cart);
	} else {
		cartDao.plusUpdate(checkCart);
	}
	
	
	response.sendRedirect(request.getContextPath()+"/goods/list.jsp");
%>