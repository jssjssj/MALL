<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.util.*" %>
<%
	Manager loginManager = (Manager) session.getAttribute("loginManager");
	if(loginManager==null) {
		// 애초에 접속 시도도 안되는 경로 -> 버그있을까봐 넣어둠
		response.sendRedirect(request.getContextPath()+"/manager/managerLoginForm.jsp");
	}
%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>

<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>