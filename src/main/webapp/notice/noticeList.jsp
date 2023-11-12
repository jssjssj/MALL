<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, util.*" %>
<%@ page import="java.util.List" %>
<%
	// 샘플 데이터 입력.
	NoticeDao noticeDao = new NoticeDao();
	SampleData sample = new SampleData();
	for(int i = 0; i < 0; i++) {
		Notice notice = sample.getNotice();
		noticeDao.insertNotice(notice);
	}
%>

<%
	/*
	TODO:
		1. 굿즈 리스트를 가져온다.
		2. 페이징을 한다.
	*/
	String p_page = request.getParameter("page");
	if (p_page == null || p_page.equals("")) p_page = "1";
	int _page = Integer.parseInt(p_page);
	int perPage = 8; 
	
	// NoticeDao 한테서 select해온다.
	NoticeDao dao = new NoticeDao(); 
	List<Notice> noticeList = dao.selectNotice(_page, perPage);
	
	// total,perPage,currentPage; 
	List<Page> pages = new Paginator().getPages(dao.getAllNoticeCount(), perPage, _page);
	System.out.println(dao.getAllNoticeCount());
%>

<!DOCTYPE html>
<html>

<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    <!-- 내용 시작 -->
    <div>
        <h1>공지사항 목록</h1>
        <%-- 공지사항 목록을 가져오기 --%>
        <%

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
    
    <!-- 페이지 시작 -->	
			<div class="d-flex justify-content-center">
				<nav aria-label="Page navigation example">
				  <ul class="pagination">
					<%
						for (Page p : pages) {
					%>
				    	<li class="page-item"><a class="page-link" href="?page=<%= p.page%>"><%= p.text %></a></li>
					<% } %> 
				  </ul>
				</nav>
			</div>
			<!-- 페이지 끝 -->	
        </div>

    <!-- footer 시작 -->
    <jsp:include page="/inc/footer.jsp"></jsp:include>
    <!-- footer 끝 -->
</body>
</html>
