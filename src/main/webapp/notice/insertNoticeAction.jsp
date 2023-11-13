<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<%
request.setCharacterEncoding("UTF-8");
// 매니저 세션 확인
Manager loginManager = (Manager)session.getAttribute("loginManager");
if (loginManager == null) {
    // 매니저가 로그인되어 있지 않으면 로그인 페이지로 이동
    response.sendRedirect(request.getContextPath() + "/manager/managerLoginForm.jsp");
} else {
    // 매니저가 로그인되어 있으면 공지사항 등록 처리
    String noticeTitle = request.getParameter("noticeTitle");
    String noticeContent = request.getParameter("noticeContent");
    int managerNo = Integer.parseInt(request.getParameter("managerNo"));
    // 객체 생성
    Notice notice = new Notice();
    NoticeDao noticeDao = new NoticeDao();
    

    // 값 설정
    notice.setNoticeTitle(noticeTitle);
    notice.setManagerNo(managerNo);
    notice.setNoticeContent(noticeContent);
 
    // 공지사항 등록
    int row = noticeDao.insertNotice(notice);

    if (row == 1) {
        System.out.println("공지사항 등록 완료.");
        response.sendRedirect(request.getContextPath() + "/110011/index.jsp");
    } else {
        out.println("공지사항 등록 실패.");
    }
}
%>
