<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
<%
	String manager_no = request.getParameter("manager_no");
	if (manager_no == null || manager_no.equals("")) { %>
	<script>
		window.alert("매니저 번호가 없습니다.");
		location.href = "/";
	</script>	
<%  } else {

	int i_manager_no = Integer.parseInt(manager_no);
	ManagerDao dao = new ManagerDao();
	Manager manager = dao.getManagerOne(i_manager_no);
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    
<form method="post" action="updateManagerPasswordForm.jsp">
		<div class="container">
			<fieldset>
				<legend class="container">관리자 정보</legend>
					<table border="1" width="300" height="200">
						<tr>
							<th>ID</th>
							<td><%=manager.getManagerId()%></td>				
						</tr> 
						
						<tr>
							<th>이름</th>
							<td><%=manager.getManagerName()%></td>	
						</tr>
						
						<tr>
							<th>계정 활성화 유무</th>
							<td><%=manager.getActive()%></td>	
						</tr>
					</table>
					<button type="submit">비밀번호 변경</button>	
					<button><a href="<%=request.getContextPath()%>/manager/deleteManagerForm.jsp">회원탈퇴</a></button>				
			</fieldset>
		</div>
	</form>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>
<% } %>