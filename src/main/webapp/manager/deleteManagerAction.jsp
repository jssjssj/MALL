<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.net.URLEncoder.*, java.util.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- 매니저 세션 가져오기 --%>
    <% Manager loginManager = (Manager)session.getAttribute("loginManager"); %>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
    <jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    	
    <%
    String managerId = null;
    if (loginManager != null) {
        managerId = loginManager.getManagerId();
    }

    if (managerId != null && !managerId.isEmpty()) {
        ManagerDao managerDao = new ManagerDao();

        // 회원 삭제
        int row = managerDao.deleteManager(managerId);

        if (row > 0) {
            // 성공적으로 삭제되었을 경우
            session.invalidate(); // 세션 무효화

            // response.sendRedirect는 여기서 호출되어야 합니다.
            response.sendRedirect(request.getContextPath() + "/110011/index.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/manager/managerLoginForm.jsp");
        }
    } else {
        // managerId가 null이거나 비어있는 경우 처리
        response.sendRedirect(request.getContextPath() + "/manager/managerLoginForm.jsp");
    }
%>

    <!-- footer 시작 -->
    <jsp:include page="/inc/footer.jsp"></jsp:include>
    <!-- footer 끝 -->
</body>
</html>
