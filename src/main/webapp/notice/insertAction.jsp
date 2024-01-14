<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Notice notice = new Notice();
	notice.setManagerNo(Integer.parseInt(request.getParameter("managerNo")));
	notice.setNoticeTitle(request.getParameter("noticeTitle"));
	notice.setNoticeContent(request.getParameter("noticeContent"));
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.insert(notice);
	
	response.sendRedirect(request.getContextPath()+"/notice/list.jsp");

%>
