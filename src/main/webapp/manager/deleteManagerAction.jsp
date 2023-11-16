<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.net.URLEncoder.*, java.util.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%-- 매니저 세션 가져오기 --%>
    <% Manager loginManager = (Manager)session.getAttribute("loginManager"); %>
<!DOCTYPE html>
    <%
    String managerId = null;
    if (loginManager != null) {
        managerId = loginManager.getManagerId();
    }

    if (managerId != null && !managerId.isEmpty()) {
        ManagerDao managerDao = new ManagerDao();

        // 회원 삭제
        int row = managerDao.deleteManager(managerId);

        if (row == 1) {
            // 성공적으로 변경되었을 경우

            // response.sendRedirect는 여기서 호출되어야 합니다.
            response.sendRedirect(request.getContextPath() + "/110011/index.jsp");
            session.invalidate(); // 세션 무효화
        } else {
            response.sendRedirect(request.getContextPath() + "/manager/managerLoginForm.jsp");
        }
    } else {
        // managerId가 null이거나 비어있는 경우 처리
        response.sendRedirect(request.getContextPath() + "/manager/managerLoginForm.jsp");
    }
%>