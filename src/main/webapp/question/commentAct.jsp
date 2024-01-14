<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.* , vo.*, java.util.Map " %>
<%
	Manager loginManager = (Manager)session.getAttribute("loginManager");
	QuestionComment questionComment = new QuestionComment();
	questionComment.setManagerNo(loginManager.getManagerNo());

%>