<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*" %>
   
<%    
// 비가입자 접근 불가기능 / 테스트 중 비활성화
		/*  if(session.getAttribute("loginId") == null) {
		response.sendRedirect("customerLoginForm.jsp");
			} 
		
		String customerId = (String)(session.getAttribute("customerId")); */	
%>
<!DOCTYPE html>
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
</head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->

	
	<form method="post" action="updateCustomerForm.jsp">
		<div class="container">
			<fieldset>
				<legend>내정보</legend>
					<table border="1" width="300" height="200">
						<tr>
							<th>ID</th>
							<td></td>				
						</tr>
						
						<tr>
							<th>이름</th>
							<td></td>	
						</tr>
						
						<tr>
							<th>주소</th>
							<td></td>	
						</tr>
						
						<tr>
							<th>전화번호</th>
							<td></td>	
						</tr>	
						
					</table>
					<button type="submit">정보수정</button>					
			</fieldset>
		</div>
	</form>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>