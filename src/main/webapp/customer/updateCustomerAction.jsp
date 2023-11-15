<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %> 
<%

//세션에서 고객 ID 가져오기 + 고객정보조회
String customerId = (String)(session.getAttribute("loginId"));

//사용자로부터 입력받은 데이터 가져오기
String customerPw = request.getParameter("customerPw");
String newPw = request.getParameter("newPw");
String newPwck = request.getParameter("newPwck");
String customerName = request.getParameter("customerName");
String address = request.getParameter("address");
String customerPhone = request.getParameter("customerPhone");


CustomerDao customerDao = new CustomerDao();
int row = customerDao.updateCustomer(
		customerId , customerPw , newPw , customerName ,
		address , customerPhone);
       
	if(newPw==newPwck){
        if (row == 1) {
        	String n = URLEncoder.encode("정보 수정완료");    
          	response.sendRedirect(request.getContextPath()+"/customer/updateCustomerForm.jsp?n="+n);
        } else if(row == -1){
        	String n = URLEncoder.encode("현재PW 불일치");        	
        	response.sendRedirect(request.getContextPath()+"/customer/updateCustomerForm.jsp?n="+n);
        } else {
        	String n= URLEncoder.encode("오류:서버 점검중으로 잠시 후 시도해주세요");
        	System.out.println(row);
        	response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp?n="+n);
        }} else {
        	String n = URLEncoder.encode("변경PW와 변경PW확인 불일치");
        	response.sendRedirect(request.getContextPath()+"/customer/updateCustomerForm.jsp?n="+n);
        }
     
%>