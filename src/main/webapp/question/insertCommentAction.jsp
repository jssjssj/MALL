<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	String comment = request.getParameter("comment");
	
	QuestionComment questionComment = new QuestionComment();
	questionComment.setQuestionNo(questionNo);	
	questionComment.setManagerNo(managerNo);
	questionComment.setComment(comment);
	
	QuestionDao questionDao = new QuestionDao();
	questionDao.insertCommet(questionComment);
	
	response.sendRedirect(request.getContextPath()+"/question/questionOne.jsp?questionNo="+questionNo);
	

%>