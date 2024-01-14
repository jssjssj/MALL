<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*,dao.*, java.util.*" %>    
<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	Manager loginManager = (Manager)session.getAttribute("loginManager");
	NoticeDao noticeDao = new NoticeDao();
	Map<String, Object> resultMap = noticeDao.noticeOne(noticeNo);

%>    
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include> 

<!-- 내용 시작 -->
<br><br>
		
		
	<table class="table table-bordered">
		<thead>
			<tr>
				<td>No</td>
			   	<td><%= resultMap.get("noticeNo") %></td>
			   	  
			   	<td>작성자</td>
			   	<td><%= resultMap.get("managerId") %></td>
			</tr>	   	
			   	 
			 <tr>
				<td>제목</td>
			   	<td><%= resultMap.get("noticeTitle") %></td>
			   	  
			  	<td>작성일</td>
			   	<td><%= resultMap.get("createdate").equals(resultMap.get("updatedate")) ? "-" : resultMap.get("updatedate") %></td>
			</tr>
			     
			<tr>				
				<td colspan="4">
					<p>내용 
					<% if(loginManager != null) { %><a style="margin-left: 60%;" href="<%= request.getContextPath() %>/notice/deleteAction.jsp?noticeNo=<%= resultMap.get("noticeNo") %>" class="btn btn-success">
					삭제</a>
					<% } %></p>
					<textarea readonly style="outline:none; border: none; resize: none; 
					font-size:50; width: 70%; height: 100em;"><%= resultMap.get("noticeContent") %></textarea>
				</td>
			</tr> 			
		</thead>
	</table>
	
    <!-- 내용 끝 -->
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>