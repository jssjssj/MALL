<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	if(session.getAttribute("loginCustomer")!=null){
		response.sendRedirect(request.getContextPath() + "/public/home.jsp") ;
		return;
	}

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
		<form action="<%= request.getContextPath() %>/customer/updatePwAction.jsp" method="post">
			<table class="table table-sm">
				<tr>
					<th>아이디</th>
					<td><%= loginCustomer.getCustomerId() %></td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="customerPw"/></td>
				</tr>
				
				<tr>
					<th>새 비밀번호</th>
					<td><input type="password" name="customerNewPw"/></td>
				</tr>
				
				<tr>
					<th>새 비밀번호 확인</th>
					<td><input type="password" /></td>
				</tr>
			</table>
				<div style="margin-left: 40%;"><button class="btn btn-success" type="submit">완료</button></div>
		</form>
		
		
<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html>