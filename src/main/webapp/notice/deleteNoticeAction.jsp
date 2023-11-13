<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>

<%
    // noticeNo 파라미터 확인
    String noticeNoParam = request.getParameter("noticeNo");
	// System.out.print(noticeNoParam);
    if (noticeNoParam == null || noticeNoParam.equals("")) {
        // noticeNo가 없으면 예외 처리 또는 리다이렉트 등을 수행
        response.sendRedirect("noticeList.jsp");
    }
    
    int noticeNo = Integer.parseInt(noticeNoParam);
    System.out.print(noticeNo);
    // NoticeDao 한테서 noticeNo에 해당하는 공지사항 삭제하기
    NoticeDao dao = new NoticeDao();
    int row = dao.deleteNotice(noticeNo);

    if (row == 1) {
        // 삭제가 성공했을 경우
        response.sendRedirect("noticeList.jsp");
    } else {
        // 삭제가 실패했을 경우
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 삭제 실패</title>
</head>
<body>
    <!-- 삭제 실패 페이지 내용 시작 -->
    <div>
        <h1>공지사항 삭제 실패</h1>
        <p>공지사항 삭제 중 오류가 발생했습니다.</p>
        <p><a href="noticeList.jsp">공지사항 목록으로 돌아가기</a></p>
    </div>
    <!-- 삭제 실패 페이지 내용 끝 -->
</body>
</html>
<%
    }
%>