<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder.*,vo.*,dao.*" %>
<%request.setCharacterEncoding("UTF-8"); %>
<%
    // noticeNo 파라미터 확인
    String noticeNoParam = request.getParameter("noticeNo");
    if (noticeNoParam == null || noticeNoParam.equals("")) {
        // noticeNo가 없으면 예외 처리 또는 리다이렉트 등을 수행
        response.sendRedirect("noticeList.jsp");
    }

    int noticeNo = Integer.parseInt(noticeNoParam);

    // NoticeDao 한테서 noticeNo에 해당하는 공지사항 가져오기
    NoticeDao dao = new NoticeDao();
    Notice notice = dao.getNoticeOne(noticeNo);
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
<!-- 내용 시작 -->
    <div>
        <h1>공지사항 수정</h1> 
        <form action="updateNoticeAction.jsp" method="post">
            <input type="hidden" name="noticeNo" value="<%= notice.getNoticeNo() %>">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="<%= notice.getNoticeTitle() %>"><br>
            <label for="content">내용:</label>
            <textarea id="content" name="content"><%= notice.getNoticeContent() %></textarea><br>
            <input type="submit" value="수정">
        </form> 
    </div>
    <!-- 내용 끝 -->
            
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>