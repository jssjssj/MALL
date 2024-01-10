<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%

 	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");

	CustomerDao customerDao = new CustomerDao();
	Map<String,Object> resultMap = customerDao.customerOne(loginCustomer);
 	
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
	<!-- customer가 null이 아닌 경우에만 속성에 접근 -->
	<table class="table table-border">
		<tr>
			<th>아이디</th>
			<td><%= resultMap.get("customerId") %></td>
		</tr>
		
		<tr>
			<th>이름</th>
			<td><%= resultMap.get("customerName") %></td>
		</tr>
		
		<tr>
			<th>전화번호</th>
			<td><%= resultMap.get("customerPhone") %></td>
		</tr>
		
		<tr>
			<th>주소</th>
			<td><%= resultMap.get("address") %></td>
		</tr>
		
		<tr>
			<th>가입일</th>
			<td><%= resultMap.get("createdate") %></td>
		</tr>
	
	</table> 
	<div style="margin-left: 70%;">
		<a class="btn btn-success" href="<%= request.getContextPath() %>/customer/deleteForm.jsp">계정탈퇴</a>
		<a class="btn btn-success" href="<%= request.getContextPath() %>/customer/updateForm.jsp">정보수정</a>
		<a class="btn btn-success" href="<%= request.getContextPath() %>/customer/updatePwForm.jsp">PW 변경</a>
	</div>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>
















