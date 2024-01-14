<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	QuestionDao questionDao = new QuestionDao();
	// 해당 글에 등록된 comment 먼저 삭제 후 question 삭제
	questionDao.deleteComment(questionNo);
	questionDao.delete(questionNo);
	
	response.sendRedirect(request.getContextPath() + "/question/list.jsp");


%>