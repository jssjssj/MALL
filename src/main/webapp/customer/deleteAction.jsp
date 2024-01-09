<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CustomerDao" %>
<%@ page import="java.net.URLEncoder"%>


<%
    String customerId = (String)(session.getAttribute("loginId"));
	String customerPw = request.getParameter("customerPw");
    CustomerDao customerDao = new CustomerDao();
    

    // 회원 삭제
    int row = customerDao.deleteCustomer(customerId , customerPw);
        System.out.print(row);
        if (row > 0) {
        	// 성공적으로 삭제되었을 경우
        	String t =URLEncoder.encode("탈퇴가 완료되었습니다!");
        	session.invalidate(); // 세션 무효화
            response.sendRedirect(request.getContextPath() + "/110011/index.jsp?t="+t);
        } else {
        	String t =URLEncoder.encode("비밀번호 불일치");
        	response.sendRedirect(request.getContextPath() + "/customer/deleteCustomerForm.jsp?t="+t);
        }
     
    
%>