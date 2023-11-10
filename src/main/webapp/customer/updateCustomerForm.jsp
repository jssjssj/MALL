<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%
    // 세션에서 고객 ID 가져오기
    String customerId = (String)(session.getAttribute("loginId"));

    // CustomerDao 인스턴스 생성
    CustomerDao customerDao = new CustomerDao();

    // 고객 정보 조회
    Customer customer = customerDao.customerOne(customerId);

    // 사용자로부터 입력받은 데이터 가져오기
    String customerPw = request.getParameter("customerPw");
    String newPw = request.getParameter("newPw");
    String newPwck = request.getParameter("newPwck");
    String customerName = request.getParameter("customerName");
    String address = request.getParameter("address");
    String customerPhone = request.getParameter("customerPhone");

   
%>
<html>
<head>
    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<!-- 메뉴 시작 -->
<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->
<form method="post" action="updateCustomerAction.jsp">
    <div class="container">
        <fieldset>
            <legend>정보수정</legend>
            <table border="1" width="300" height="200">
                <tr>
                    <th>ID</th>
                    <td><input type="text" readonly="readonly" value="<%= (customer != null) ? customer.getCustomerId() : "" %>"></td>
                </tr>

                <tr>
                    <th>현재PW</th>
                    <td><input type="password" name="customerPw"></td>
                </tr>

                <tr>
                    <th>변경PW</th>
                    <td><input type="password" name="newPw"></td>
                </tr>

                <tr>
                    <th>변경PW확인</th>
                    <td><input type="password" name="newPwck"></td>
                </tr>

                <tr>
                    <th>이름</th>
                    <td><input type="text" value="<%= (customer != null && customer.getCustomerDetail() != null) ? customer.getCustomerDetail().getCustomerName() : "" %>"></td>
                </tr>

                <tr>
                    <th>주소</th>
                    <td><input type="text" value="<%= (customer != null && customer.getCustomerAddr() != null) ? customer.getCustomerAddr().getAddress() : "" %>"></td>
                </tr>

                <tr>
                    <th>전화번호</th>
                    <td><input type="text" value="<%= (customer != null && customer.getCustomerDetail() != null) ? customer.getCustomerDetail().getCustomerPhone() : "" %>"></td>
                </tr>
            </table>
            <button type="submit">저장하기</button>
        </fieldset>
    </div>
</form>
<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html>