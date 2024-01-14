<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%

 	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");

	Map<String,Object> paramMap = new HashMap<>();
	paramMap.put("customerName", request.getParameter("customerName"));
	paramMap.put("customerPhone", request.getParameter("customerPhone"));
	paramMap.put("address", request.getParameter("address"));
	paramMap.put("customerNo", loginCustomer.getCustomerNo());
 	
	CustomerDao customerDao = new CustomerDao();
	int result = customerDao.update(paramMap);
	if(result != 1) {	// 예외발생
		response.sendRedirect(request.getContextPath()+"/public/home.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp");		
	}
%>