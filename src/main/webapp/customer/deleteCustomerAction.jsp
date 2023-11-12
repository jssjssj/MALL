<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CustomerDao" %>
<%@ page import="java.net.URLEncoder"%>


<%
    String customerId = (String) session.getAttribute("loginId");
    CustomerDao customerDao = new CustomerDao();

    // 회원 삭제
    int row = customerDao.deleteCustomer(customerId);
        
        if (row == 1) {
        	String delMsg=URLEncoder.encode("탈퇴가 완료되었습니다!");
        	System.out.println(delMsg);
            // 성공적으로 삭제되었을 경우
            session.invalidate(); // 세션 무효화
            response.sendRedirect(request.getContextPath() + "/110011/index.jsp?delMsg="+delMsg);
        } else {
        	System.out.println("실패,,");
        }
     
    
%>