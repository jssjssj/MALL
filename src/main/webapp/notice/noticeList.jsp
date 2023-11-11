<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, util.*" %>
<%@ page import="java.util.List" %>
<%
	NoticeDao noticeDao = new NoticeDao();
	SampleData sample = new SampleData();
	for(int i = 0; i < 0; i++) {
		Notice notice = sample.getNotice();
		noticeDao.insertNotice(notice);
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 목록</title>
</head>
<body>
    <!-- 메뉴 시작 -->
    <jsp:include page="/inc/menubar.jsp"></jsp:include>
    <!-- 메뉴 끝 -->
	
    <!-- 내용 시작 -->
    <div>
        <h1>공지사항 목록</h1>
        <%-- 공지사항 목록을 가져오기 --%>
        <%
            
            List<Notice> noticeList = noticeDao.selectNotice();

            if (noticeList.isEmpty()) {
                out.println("<p>등록된 공지사항이 없습니다.</p>");
            } else {
                for (Notice notice : noticeList) {
        %>
                    <div>
                        <h2><%= notice.getNoticeTitle() %></h2>
                        <p><%= notice.getNoticeContent() %></p>
                        <p>작성자: <%= notice.getManager() != null ? notice.getManager().getManagerName() : "Unknown" %></p>
                        <p>작성일: <%= notice.getCreatedate() %></p>
                        <hr>
                    </div> 
        <%
                }
            }
        %>
    </div>
    <!-- 내용 끝 -->

    <!-- footer 시작 -->
    <jsp:include page="/inc/footer.jsp"></jsp:include>
    <!-- footer 끝 -->
</body>
</html>
