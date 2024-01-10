<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.*"%>
<% 
	Customer paramCustomer = new Customer();
	paramCustomer.setCustomerId(request.getParameter("customerId"));
	
	CustomerDao customerDao = new CustomerDao();
	Customer check = customerDao.checkId(paramCustomer);	// 아이디 중복확인

	if(check == null) { // 중복값 없을 시에만 진행		
	
	Map<String, Object> paramMap = new HashMap<>();
	paramMap.put("customerId", request.getParameter("customerId"));
	paramMap.put("customerPw", request.getParameter("customerPw"));
	paramMap.put("customerName", request.getParameter("customerName"));
	paramMap.put("customerPhone", request.getParameter("customerPhone"));
	paramMap.put("address", request.getParameter("address"));	
	
		int result = customerDao.insert(paramMap);

		if(result != 1){ // 가입실패
			response.sendRedirect(request.getContextPath()+"/customer/insertForm.jsp");
		} else {
			response.sendRedirect(request.getContextPath()+"/public/loginForm.jsp");
		}
		
		
		
		
	} else {	// 중복 시 
		response.sendRedirect(request.getContextPath()+"/customer/insertForm.jsp");	
	}
	
%>
