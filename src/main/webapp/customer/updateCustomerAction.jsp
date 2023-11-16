<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %> 

<%
		// 페이지 오류많아요 죄송합니다 고객님들,,
		
		String customerId = (String)(session.getAttribute("loginId"));
		//사용자로부터 입력받은 데이터 가져오기
		String customerPw = request.getParameter("customerPw");
		
		String newPw = request.getParameter("newPw");
		String ghkrdls = request.getParameter("ghkrdls");
		String customerName = request.getParameter("customerName");
		String address = request.getParameter("address");
		String customerPhone = request.getParameter("customerPhone");
		
		
		CustomerDao customerDao = new CustomerDao();
		int row = customerDao.updateCustomer(
				customerId , customerPw , newPw , customerName ,
				address , customerPhone);
		// 오류 시 디버깅 확인
		System.out.println(row + "<--row");
		System.out.println(newPw + "<--새 비번");
		System.out.println(ghkrdls + "<--확인");
		System.out.println(customerPw + "<--입력한 현재 비번");
		System.out.println(customerId + "<--customerId");

	if(newPw!=ghkrdls){
		row = 33;
	}
       
	if (row == 1) {
        	String n1 = URLEncoder.encode("정보 수정완료"); 
          	response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp.jsp?n1="+n1);
        } else if(row == -100){
        	String n2 = URLEncoder.encode("현재PW 불일치");
        	response.sendRedirect(request.getContextPath()+"/customer/updateCustomerForm.jsp?n2="+n2);
        } else if(row==33) {
        	String n3 = URLEncoder.encode("변경PW와 변경PW확인 불일치");
        	response.sendRedirect(request.getContextPath()+"/customer/updateCustomerForm.jsp");
        } else {
        	String n4= URLEncoder.encode("오류:서버 점검중으로 잠시 후 시도해주세요");
        	response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp");
        }
        
     
%>