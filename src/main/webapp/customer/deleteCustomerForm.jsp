<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<style>
	.container{
	display:flex;
	justify-content:center;
	align-items:center;
	width:200px;
	height:10px;
	}
	.container2{
	display:flex;
	justify-content:center;
	align-items:center;
	height:100px;
	}
</style>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
<form method="post" action="<%=request.getContextPath()%>/customer/deleteCustomerAction.jsp">
	<div class="container2"> 탈퇴하려면 PW를 입력하세요 </div>	
	<div class="container"> 
		<input type="password" name="customerPw">
		<button type="submit">탈퇴하기</button>
	</div>
		<br>
	
</form>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>