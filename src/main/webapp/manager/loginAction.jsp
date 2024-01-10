<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%
	Manager paramManager = new Manager();
	paramManager.setManagerId(request.getParameter("managerId"));
	paramManager.setManagerPw(request.getParameter("managerPw"));
	
	ManagerDao managerDao = new ManagerDao();
	Manager loginManager = managerDao.login(paramManager);
	
	if(loginManager != null){ // 로그인 성공
		session.setAttribute("loginManager", loginManager);
		response.sendRedirect(request.getContextPath()+"/public/home.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/public/loginForm.jsp");
	}

%>

