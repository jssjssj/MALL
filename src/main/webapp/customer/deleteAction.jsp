<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	loginCustomer.setCustomerPw(request.getParameter("customerPw"));

	CustomerDao customerDao = new CustomerDao();
	
	Customer check = customerDao.login(loginCustomer);	// 로그인 프로세스 이용 -> 입력한 현재PW 일치여부 확인

	int result = 0;
	if(check != null){	// 조회되는 계정 있음 -> 현재PW 일치
		result = customerDao.delete(loginCustomer);
			if(result==1){	// 탈퇴 완
				response.sendRedirect(request.getContextPath()+"/public/loginForm.jsp");
			}
	} else {	// 현재PW 불일치
		response.sendRedirect(request.getContextPath()+"/customer/deleteForm.jsp");
	}

%>