<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>

<%
    // 세션에서 고객 ID 가져오기
    String customerId = (String)(session.getAttribute("customerId"));

    // CustomerDao 인스턴스 생성
    CustomerDao customerDao = new CustomerDao();

    try {
        // 고객 정보 조회
        Customer customer = customerDao.customerOne(customerId);
        
        if(customer==null){
        	customer = new Customer();
        }

        // 사용자로부터 입력받은 데이터 가져오기
        String customerPw = request.getParameter("customerPw");
        String newPw = request.getParameter("newPw");
        String newPwck = request.getParameter("newPwck");
        String customerName = request.getParameter("customerName");
        String address = request.getParameter("address");
        String customerPhone = request.getParameter("customerPhone");

        // 디버깅 출력 추가
        out.println("currentPw: " + customerPw);
        out.println("storedPw: " + customer.getCustomerPw());

        // 현재 비밀번호 확인
        if (customer != null && customer.getCustomerPw().equals(customerPw)) {
            // 새로운 비밀번호가 입력되었을 경우에만 업데이트
            if (!newPw.isEmpty() && newPw.equals(newPwck)) {
                customer.setCustomerPw(newPw);
            }

            // 고객 상세 정보 업데이트
            CustomerDetail customerDetail = customer.getCustomerDetail();
            customerDetail.setCustomerName(customerName);
            customerDetail.setCustomerPhone(customerPhone);

            // 고객 주소 정보 업데이트
            CustomerAddr customerAddr = customer.getCustomerAddr();
            customerAddr.setAddress(address);

            // Customer 객체에 업데이트된 정보 설정
            customer.setCustomerDetail(customerDetail);
            customer.setCustomerAddr(customerAddr);

            // 업데이트 메서드 호출
            int updateResult = customerDao.updateCustomer(customer);

            if (updateResult > 0) {
                // 업데이트 성공 시 처리
                out.println("정보가 성공적으로 업데이트되었습니다.");
            } else {
                // 업데이트 실패 시 처리
                out.println("정보 업데이트에 실패했습니다.");
            }
        } else {
            // 현재 비밀번호가 일치하지 않을 경우 처리
            out.println("현재 비밀번호가 일치하지 않습니다.");
        }
    } catch (Exception e) {
        // 예외 처리
        e.printStackTrace();
        out.println("오류가 발생했습니다. 관리자에게 문의하세요. " + e.getMessage());
    }
%>