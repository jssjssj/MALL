<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*" %>
   
<%    
// 비가입자 접근 불가기능 / 테스트 중 비활성화
		/*  if(session.getAttribute("loginId") == null) {
		response.sendRedirect("customerLoginForm.jsp");
			} 
		
		String customerId = (String)(session.getAttribute("customerId")); */
		
		CustomerDao customerDao = new CustomerDao();
	    String customerId = (String)(session.getAttribute("loginId"));
	    Customer customer = customerDao.customerOne(customerId);
	    CustomerDetail customerDetail = customer.getCustomerDetail();
	    CustomerAddr customerAddr = customer.getCustomerAddr();
		
		
		
%>
<html>
<head>
<style>
	.container{
	display:flex;
	justify-content:center;
	align-items:center;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
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
								<td><input type="text" value="<%=customerDetail.getCustomerName()%>"></td>	
							</tr>
							
							<tr>
								<th>주소</th>
								<td><input type="text" value="<%=customerAddr.getAddress()%>"></td>	
							</tr>
							
							<tr>
								<th>전화번호</th>
								<td><input type="text" value="<%=customerDetail.getCustomerPhone()%>"></td>	
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