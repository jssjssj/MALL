<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	loginCustomer.setCustomerPw(request.getParameter("customerPw"));

	CustomerDao customerDao = new CustomerDao();
	
	Customer check = customerDao.login(loginCustomer);	// 로그인 프로세스 이용 -> 입력한 현재PW 일치여부 확인

	int result = 0;
	if(check != null){	// 조회되는 계정 있음 -> 현재PW 일치
		loginCustomer.setCustomerPw(request.getParameter("customerNewPw"));	// 매개변수 로그인 세션 이용해 재세팅
		result = customerDao.updatePw(loginCustomer);
		
		if(result > 0){ // 변경성공 -> 세션 제거 및 재로그인
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/public/loginForm.jsp");
		} else {	// 예외발생
			response.sendRedirect(request.getContextPath()+"/public/loginForm.jsp");
		}
					
		
	} else {	// 현재PW 불일치
		response.sendRedirect(request.getContextPath()+"/customer/updatePwForm.jsp");
	}

%>
