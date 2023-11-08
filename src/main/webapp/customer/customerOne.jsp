<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*" %>
   
<%    
// 비가입자 접근 불가기능 / 테스트 중 비활성화
		/* if(session.getAttribute("loginId") == null) {
		response.sendRedirect("customerLoginForm.jsp");
			} */
		
		String customerId = (String)(session.getAttribute("customerId"));

		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<fieldset>
		<legend>내정보</legend>
			<table border="1">
				<tr>
					<th>ID</th>
					<td></td>
					
				</tr>
				
				<tr>
					<th></th>
					<td></td>
				</tr>
				
				
			</table>
	</fieldset>
</body>
</html>