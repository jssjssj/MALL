<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	if(session.getAttribute("loginCustomer")!=null){
		response.sendRedirect(request.getContextPath() + "/public/home.jsp") ;
		return;
	}


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
<form method="post" action="<%= request.getContextPath() %>/customer/updateAction.jsp" method="post">
 	<table class="table table-border">
		<tr>
			<th>아이디</th>
			<td><%= resultMap.get("customerId") %></td>
		</tr>
		
		<tr>
			<th>이름</th>
			<td><input name="customerName" value="<%= resultMap.get("customerName") %>"/></td>
		</tr>
		
		<tr>
			<th>전화번호</th>
			<td><input name="customerPhone" value="<%= resultMap.get("customerPhone") %>"/></td>
		</tr>
		
		<tr>
			<th>주소</th>
			<td><input name="address" value="<%= resultMap.get("address") %>"/></td>
		</tr>		
	
	</table> 
	<div style="margin-left: 80%;">
		<button class="btn btn-success" type="submit">완료</button>
	</div>
</form>
<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->

</body>
</html>