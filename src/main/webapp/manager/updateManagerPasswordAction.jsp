<%@ page import="java.io.Console"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>

<%
int managerNo = Integer.parseInt(request.getParameter("managerNo"));
String currentPassword = request.getParameter("currentPassword");
String newPassword = request.getParameter("newPassword");

ManagerDao managerDao = new ManagerDao();
boolean passwordUpdated = false;

try {
    passwordUpdated = managerDao.updateManagerPassword(managerNo, currentPassword, newPassword);
} catch (Exception e) {
    e.printStackTrace();
    // 예외 처리
}

if (passwordUpdated) {
    out.println("비밀번호 업데이트 성공");
} else {
    out.println("비밀번호 업데이트 실패");
}
%>
