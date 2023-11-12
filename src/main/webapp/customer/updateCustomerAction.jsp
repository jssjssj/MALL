<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %> 
<%
    // 사용자로부터 입력받은 데이터 가져오기
    String customerPw = request.getParameter("customerPw"); // 평문으로 전송
    String newPw = request.getParameter("newPw");
    String newPwck = request.getParameter("newPwck");
    String customerName = request.getParameter("customerName");
    String address = request.getParameter("address");
    String customerPhone = request.getParameter("customerPhone");

    // 세션에서 고객 ID 가져오기 + 고객정보조회
    String customerId = (String)(session.getAttribute("loginId"));
    CustomerDao customerDao = new CustomerDao();
    Customer customer = customerDao.customerOne(customerId);
    
    
    //  현재 비밀번호가 맞다면 업데이트 수행
  
        customer.setCustomerPw(newPw);

        CustomerDetail customerDetail = new CustomerDetail();
        customerDetail.setCustomerName(customerName);
        customerDetail.setCustomerPhone(customerPhone);

        CustomerAddr customerAddr = new CustomerAddr();
        customerAddr.setAddress(address);

        // 업데이트 메소드 호출
        int result = customerDao.updateCustomer(customer, customerDetail, customerAddr);


        if (result == 1) {
          	String updateMsg1=URLEncoder.encode("정보수정완료!");
          	response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp?updateMsg1="+updateMsg1);
        } else {
        	String updateMsg2=URLEncoder.encode("오류:서버 점검중으로 잠시 후 시도해주세요");
        	System.out.println(result);
        	response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp?updateMsg2="+updateMsg2);
        }
     
%>