<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%
    // 세션에서 고객 ID 가져오기
    String customerId = (String)(session.getAttribute("loginId"));
	
	String updateMsg3 = request.getParameter("updateMsg3");


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
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
<form method="post" action="updateCustomerAction.jsp">
    <div class="container">
        <fieldset>
            <legend>정보수정</legend>
           
            
            <%
            	if(updateMsg3!=null) {
           	%>
           		<div><%=updateMsg3%></div>
           	<%
            	}
            
            %>
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