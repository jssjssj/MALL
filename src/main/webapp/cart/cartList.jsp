<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%
	if(session.getAttribute("loginId")==null){
		String msg3 = URLEncoder.encode("로그인 후 사용이 가능합니다!");
		response.sendRedirect(request.getContextPath()+"/customer/customerLoginForm.jsp?msg3="+msg3);
	}
 %>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<h2>장바구니</h2>
	<table border = "1">
		<tr>
			<th></th>
		</tr>
	</table>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html>