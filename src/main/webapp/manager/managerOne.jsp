<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.* "%>
<%
	Manager loginManager = (Manager)session.getAttribute("loginManager");	

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
    
<form method="post" action="updateManagerPasswordForm.jsp">
		<div class="container">
			<fieldset>
				<legend class="container">관리자 정보</legend>
					<table class="table">
						<tr>
							<th>직원번호</th>
							<td><%=loginManager.getManagerNo()%></td>				
						</tr> 
						
						<tr>
							<th>아이디</th>
							<td><%=loginManager.getManagerId()%></td>				
						</tr> 
						
						<tr>
							<th>이름</th>
							<td><%=loginManager.getManagerName()%></td>	
						</tr>
						
						<tr>
							<th>입사일(계정 생성일)</th>
							<td><%=loginManager.getCreatedate()%></td>	
						</tr>
						
						<tr>
							<th>재입사일</th>
							<td><%=loginManager.getCreatedate().equals(loginManager.getUpdatedate()) ? "-" : loginManager.getUpdatedate()%></td>	
						</tr>
					</table>
					<button type="submit">비밀번호 변경</button>	
					<button><a href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp">관리자 비활성화</a></button>				
			</fieldset>
		</div>
	</form>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>