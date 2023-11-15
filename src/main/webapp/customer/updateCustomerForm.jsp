<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%
    // 세션에서 고객 ID 가져오기
    String customerId = (String)(session.getAttribute("loginId"));
	
    // CustomerDao 인스턴스 생성
    CustomerDao customerDao = new CustomerDao();
	Customer customer = customerDao.customerOne(customerId);
       
%>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
<form method="post" action="updateCustomerAction.jsp">
    <div class="container">
        <fieldset>
            <legend>정보수정</legend>
      
            <table border="1" width="300" height="200">
                <tr>
                    <th>ID</th>
                    <td><input type="text" readonly="readonly" value="<%=customer.getCustomerId()%>"></td>
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