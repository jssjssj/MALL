<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.* , vo.*, java.util.Map " %>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");

	Question question = new Question();
	question.setGoodsNo(Integer.parseInt(request.getParameter("goodsNo")));
	question.setQuestionTitle(request.getParameter("questionTitle"));
	question.setQuestionContent(request.getParameter("questionContent"));
	question.setCustomerNo(loginCustomer.getCustomerNo());
	
	QuestionDao questionDao = new QuestionDao();
	int result = questionDao.insert(question);
	System.out.println(result);
	response.sendRedirect(request.getContextPath()+"/question/list.jsp");
%>