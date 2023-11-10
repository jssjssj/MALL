<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%
    // 사용자로부터 입력받은 데이터 가져오기
    String customerPw = request.getParameter("customerPw");
    String newPw = request.getParameter("newPw");
    String newPwck = request.getParameter("newPwck");
    String customerName = request.getParameter("customerName");
    String address = request.getParameter("address");
    String customerPhone = request.getParameter("customerPhone");

    // 세션에서 고객 ID 가져오기
    String customerId = (String)(session.getAttribute("loginId"));

    // CustomerDao 인스턴스 생성
    CustomerDao customerDao = new CustomerDao();

    // 고객 정보 조회
    Customer customer = customerDao.customerOne(customerId);

    // 만약 현재 비밀번호가 맞다면 업데이트 수행
    if (customer != null && customer.getCustomerPw().equals(customerPw)) {
        CustomerDetail customerDetail = new CustomerDetail();
        customerDetail.setCustomerName(customerName);
        customerDetail.setCustomerPhone(customerPhone);

        CustomerAddr customerAddr = new CustomerAddr();
        customerAddr.setAddress(address);

        // 새로운 비밀번호가 입력되었다면 업데이트
        if (!newPw.isEmpty() && newPw.equals(newPwck)) {
            customer.setCustomerPw(newPw);
        }

        // 업데이트 메소드 호출
        int result = customerDao.updateCustomer(customer, customerDetail, customerAddr);

        if (result == 1) {
            // 업데이트 후 세션 업데이트
            session.setAttribute("loginId", customer.getCustomerId());

            out.println("<script>alert('정보가 성공적으로 업데이트되었습니다.');</script>");
         // 로그 출력 추가
            System.out.println("Session updated successfully: " + customer.getCustomerId());
        } else {
            out.println("<script>alert('업데이트에 실패하였습니다.');</script>");
        }
    } else {
        out.println("<script>alert('현재 비밀번호가 일치하지 않습니다.');</script>");
    }

    // 업데이트 후 메인 페이지로 이동
    response.sendRedirect(request.getContextPath()+"/customer/customerOne.jsp");
%>