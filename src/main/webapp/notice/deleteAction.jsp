<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>

<%
    // noticeNo 파라미터 확인
    int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
    NoticeDao noticeDao = new NoticeDao();
    noticeDao.delete(noticeNo);


    response.sendRedirect(request.getContextPath() + "/notice/list.jsp");
%>
