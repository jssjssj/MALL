<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*,dao.*" %>    
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
	<br>
  		  <div style="margin-left: 5%">   
          <h1>공지사항 상세보기</h1>
    <br>
        <div>
            <h2><%= notice.getNoticeTitle() %></h2>
            <p>작성자: <%= notice.getManager() != null ? notice.getManager().getManagerName() : "Unknown" %></p>
            <p>작성일: <%= notice.getCreatedate() %></p>
            <p>no: <%= notice.getNoticeNo() %></p>
            <p><%= notice.getNoticeContent() %></p>

            <!-- 수정 버튼 -->
            <form action="updateNoticeForm.jsp" method="post">
                <input type="hidden" name="noticeNo" value="<%= notice.getNoticeNo() %>">
                <input type="submit" value="수정">
            </form>

            <!-- 삭제 버튼 -->
            <form action="deleteNoticeAction.jsp" method="post">
                <input type="hidden" name="noticeNo" value="<%= notice.getNoticeNo() %>">
                <input type="submit" value="삭제">
            </form>
        </div>
    </div>
    <!-- 내용 끝 -->
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>