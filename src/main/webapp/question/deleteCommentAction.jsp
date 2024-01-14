<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	
	QuestionDao questionDao = new QuestionDao();
	questionDao.deleteComment(questionNo);
	
	response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp?questionNo="+questionNo);
	

%>