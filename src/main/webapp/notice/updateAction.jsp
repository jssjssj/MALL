<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	System.out.println("잡속");
	Notice paramNotice = new Notice();
	paramNotice.setManagerNo(Integer.parseInt(request.getParameter("managerNo")));
	paramNotice.setNoticeTitle(request.getParameter("noticeTitle"));
	paramNotice.setNoticeContent(request.getParameter("noticeContent"));
	paramNotice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.update(paramNotice);
	
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+paramNotice.getNoticeNo());
%>
