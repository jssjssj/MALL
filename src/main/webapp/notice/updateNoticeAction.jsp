<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    // 폼으로부터 전달된 파라미터 가져오기
     // noticeNo 파라미터 확인
    int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
    String noticeTitle = request.getParameter("title");
    String noticeContent = request.getParameter("content");
    
    System.out.println(noticeNo);
	System.out.println(noticeTitle);
	System.out.println(noticeContent);
	
    // NoticeDao를 이용하여 공지사항 업데이트
    NoticeDao dao = new NoticeDao();
    Notice notice = dao.getNoticeOne(noticeNo);

    if (notice == null) {
        // 공지사항이 존재하지 않으면 에러 메시지 출력 또는 리다이렉트 등을 수행
        out.println("<script>alert('해당 공지사항이 존재하지 않습니다.');history.back();</script>");
        return;
    }

    // 업데이트할 데이터 설정
    notice.setNoticeTitle(noticeTitle);
    notice.setNoticeContent(noticeContent);

    // 업데이트 수행
    int rowsAffected = dao.updateNotice(notice);

    if (rowsAffected == 1) {
        // 업데이트가 성공했을 경우
        out.println("<script>alert('공지사항이 성공적으로 업데이트되었습니다.');location.href='noticeOne.jsp?noticeNo=" + noticeNo + "';</script>");
    } else {
        // 업데이트가 실패했을 경우
        out.println("<script>alert('공지사항 업데이트에 실패했습니다.');history.back();</script>");
    }
%>
