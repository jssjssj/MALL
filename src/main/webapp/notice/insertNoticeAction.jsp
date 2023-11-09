<%@page import="vo.*"%>
<%@page import="dao.*"%>
<%@page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<% 
	// 객체 값 넣기
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	
	// 지정
	NoticeDao noticeDao = new NoticeDao(); 
	Notice notice = new Notice();
	
	
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	

	
	int row1 = noticeDao.insertNotice(notice);
	
	
	if(row1 == 1) {
		System.out.println("공지사항 등록 완료.");
		response.sendRedirect(request.getContextPath()+"/110011/index.jsp"
		);
	}
	
%>