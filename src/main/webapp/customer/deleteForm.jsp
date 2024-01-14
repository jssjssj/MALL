<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
 	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    	<form action="<%= request.getContextPath() %>/customer/deleteAction.jsp" method="post">
		    <table>
		    	<tr>
		    		<th>아이디</th>
		    		<td><%= loginCustomer.getCustomerId() %></td>
		    	</tr>
		    	
		    	<tr>
		    		<th>비밀번호</th>
		    		<td><input type="password" name="customerPw" /></td>
		    	</tr>
		    	
		    	<tr>
		    		<th>비밀번호 확인</th>
		    		<td><input type="password" /></td>
		    	</tr>
		    </table>
		    	<button type="submit" class="btn btn-success">탈퇴</button>
		</form>
</body>
</html>