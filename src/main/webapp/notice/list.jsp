<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	Manager loginManager = (Manager)session.getAttribute("loginManager");
	NoticeDao noticeDao = new NoticeDao();

	Integer currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	int totalRow = noticeDao.countOfNotice();
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage += 1;
	}
	Map<String, Integer> paramMap = new HashMap<>();
	paramMap.put("beginRow", beginRow);
	paramMap.put("rowPerPage", rowPerPage);
	
	List<Map<String, Object>> noticeList = noticeDao.noticeList(paramMap);
%>
<!DOCTYPE html>
<html>

<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    <br>
    <div style="text-align: center;">
 	<h2>공지사항</h2>
 		<% if(loginManager != null) { %>
		<a class="btn btn-success mt-auto" 
			href="<%=request.getContextPath()%>/notice/insertForm.jsp">
			공지작성
		</a>
		<% } %>
	</div>
    
	<table class="table table-hover">
			<thead>
			    <tr>
			        <th>No</th>
			        <th>제목 </th>
			        <th>작성자 </th>
			        <th>작성일 </th>
			        <th>수정일</th>
			    </tr>
			</thead>
		
		    <% for (Map<String, Object> notice : noticeList) { %>
		    <tbody>
		        <tr>
		            <td><%= notice.get("noticeNo") %></td>
		            <td><a href="<%= request.getContextPath() %>/notice/noticeOne.jsp?noticeNo=<%= notice.get("noticeNo") %>"><%= notice.get("noticeTitle") %></a></td>  
		            <td><%= notice.get("managerId") %></td>
		            <td><%= notice.get("createdate") %></td> 
		            <td><%= notice.get("createdate").equals(notice.get("updatedate"))  ? "-" : notice.get("updatedate") %></td>               
		        </tr>
		    </tbody>
		    <% } %>
		</table>	

    <!-- footer 시작 -->
    <jsp:include page="/inc/footer.jsp"></jsp:include>
    <!-- footer 끝 -->
</body>
</html>
