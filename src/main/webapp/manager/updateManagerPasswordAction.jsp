<%@ page import="vo.*,dao.*,java.net.*,java.util.*,java.security.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<%
    int managerNo = Integer.parseInt(request.getParameter("managerNo"));
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
	
    ManagerDao managerDao = new ManagerDao();
	int result = managerDao.updateManagerPw(managerNo, currentPassword, newPassword);

%>
