<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %> 
<%
    // 사용자로부터 입력받은 데이터 가져오기
    String customerPw = request.getParameter("customerPw"); 
	String newPw = request.getParameter("newPw");
    String newPwck = request.getParameter("newPwck");
    String customerName = request.getParameter("customerName");
    String address = request.getParameter("address");
    String customerPhone = request.getParameter("customerPhone");

    // 세션에서 고객 ID 가져오기 + 고객정보조회
    String customerId = (String)(session.getAttribute("loginId"));
    CustomerDao customerDao = new CustomerDao();
    
    Customer customerOne = customerDao.customerOne(customerId);
    Customer customer = new Customer();
  

        // 업데이트 메소드 호출
        int result = customerDao.updateCustomer(customer, customer.getCustomerDetail(), customer.getCustomerAddr());

	if(newPw==newPwck){
        if (result == 1) {
        	System.out.println("<script>정보가 수정되었습니다!</script>");
          	response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp");
        } else if(result == -1){
        	System.out.println("<script>현재 비밀번호가 일치하지 않습니다!</script>");
        	response.sendRedirect(request.getContextPath()+"/customer/updateCustomerForm.jsp");
        } else {
        	String updateMsg2=URLEncoder.encode("오류:서버 점검중으로 잠시 후 시도해주세요");
        	System.out.println(result);
        	response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp?updateMsg2="+updateMsg2);
        }} else {
        	String updateMsg2=URLEncoder.encode("오류:서버 점검중으로 잠시 후 시도해주세요");
        	System.out.println(result);
        	response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp?updateMsg2="+updateMsg2);
        }
     
%>