<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	Manager loginManager = (Manager)session.getAttribute("loginManager");
	NoticeDao noticeDao = new NoticeDao();
	Map<String, Object> resultMap = noticeDao.noticeOne(noticeNo);
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	
	<form action="<%= request.getContextPath() %>/notice/updateAction.jsp" method="post">
		<table class="table">		
			<tr>
				<th>작성자(자동변경)</th>
				<td>
					<input type="hidden" name="managerNo" value="<%=loginManager.getManagerNo()%>"/>
					<%= resultMap.get("managerId")%> -> <%=loginManager.getManagerId()%>
				</td>
			</tr>
			
			<tr>
				<th>제목</th>
				<td>
					<input type="hidden" name="noticeNo" value="<%= resultMap.get("noticeNo")%>"/>
					<input name="noticeTitle" value="<%= resultMap.get("noticeTitle")%>"/>
				</td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="100" style="resize: none;" name="noticeContent"><%= resultMap.get("noticeContent")%></textarea></td>
			</tr>
		</table>
			<button type="submit" class="btn btn-success">완료</button>
	</form>

<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>