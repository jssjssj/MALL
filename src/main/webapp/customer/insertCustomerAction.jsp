<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<% 
    request.setCharacterEncoding("UTF-8");
    // 객체 값 넣기
    String customerId = request.getParameter("customerId");
    String customerPw = request.getParameter("customerPw");
    String address = request.getParameter("address");
    String customerName = request.getParameter("customerName");
    String customerPhone = request.getParameter("customerPhone");

    // 객체 생성
    Customer customer = new Customer();
    CustomerAddr customerAddr = new CustomerAddr();
    CustomerDetail customerDetail = new CustomerDetail();

    CustomerDao customerDao = new CustomerDao();

	 // 값 설정
    customer.setCustomerId(customerId);
    customer.setCustomerPw(customerPw);
    customerDetail.setCustomerName(customerName);
    customerDetail.setCustomerPhone(customerPhone);
    customerAddr.setAddress(address);

    try {
        int result = customerDao.insertCustomer(customer, customerDetail, customerAddr);
        if (result != -1) {
        	String msg4 = URLEncoder.encode("회원가입 성공 , 로그인 후 이용해주세요~");
            System.out.println("insert ID , PW 성공");
            response.sendRedirect(request.getContextPath() + "/110011/index.jsp?msg4="+msg4);
        } else if(result ==-1) {
        	String msg5 = URLEncoder.encode("중복 아이디 입니다.");
            System.out.println("insert ID , PW 실패");
            response.sendRedirect(request.getContextPath() + "/customer/insertCustomerForm.jsp?msg5="+msg5);
            // 실패할 경우에 대한 처리 추가
        }
    } catch (Exception e) {
        e.printStackTrace();
        // 예외가 발생한 경우에 대한 처리 추가
    }
%>
