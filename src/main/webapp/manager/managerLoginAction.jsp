<%@ page import="vo.*, dao.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<%
    String managerId = request.getParameter("managerId");
    String managerPw = request.getParameter("managerPw");

    ManagerDao managerDao = new ManagerDao();
    Manager loginManager = managerDao.getManagerByIdAndPassword(managerId, managerPw);

    if (loginManager != null) {
        // 로그인 성공
        session.setAttribute("loginManager", loginManager);
        response.sendRedirect(request.getContextPath() + "/manager/dashboard.jsp");
    } else {
        // 로그인 실패
        response.sendRedirect(request.getContextPath() + "/manager/loginForm.jsp");
    }
%>
