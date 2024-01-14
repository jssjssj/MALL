<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.* , vo.*, java.util.Map " %>
<%
	
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	ManagerDao managerDao = new ManagerDao();
	Manager loginManager = (Manager)session.getAttribute("loginManager");

	QuestionDao questionDao = new QuestionDao();	
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	Map<String, Object> resultMap = questionDao.questionOne(questionNo);
	
	Map<String, Object> commentMap = questionDao.commentOne(questionNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>   
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>No</th>
			   	<td><%= resultMap.get("questionNo") %></td>
			   	
			   	<th>작성자</th>
			   	<td><%= resultMap.get("customerId") %></td>
			</tr>		   	
			   	
			 <tr>
				<th>제목</th>
			   	<td><%= resultMap.get("questionTitle") %></td>
			   	
			   	<th>문의상품</th>
			   	<td><%= resultMap.get("goodsTitle") %></td>
			</tr>  
			
			<tr>
				<th>작성일</th>
			   	<td><%= resultMap.get("createdate") %></td>
			   	
			   	<th>수정일</th>
			   	<td><%= resultMap.get("createdate").equals(resultMap.get("updatedate")) ? "-" : resultMap.get("updatedate") %></td>
			</tr>		
		</thead>
	</table>
		<% if( (loginCustomer != null && resultMap.get("customerId").equals(loginCustomer.getCustomerId())) || loginManager!=null ) { %>
	<div style="margin-left: 85%">
		<a href="<%= request.getContextPath() %>/question/deleteAction.jsp?questionNo=<%= resultMap.get("questionNo") %>" class="btn btn-success">삭제</a>
	</div>
		<% } %>
			<br>
	<textarea readonly style="outline:none; border: none; resize: none; 
					font-size:50; width: 70%; height: 100em;"><%= resultMap.get("questionContent") %></textarea>
	
	<%if(commentMap != null) {%>
		<table class="table table-bordered">
			<tr>
				<th>No</th>
				<td><%= commentMap.get("questionCommentNo") %></td>
				
				<th>직원명</th>
				<td><%= commentMap.get("managerName") %></td>
			</tr>
			
			<tr>
				<th>작성일</th>
				<td><%= commentMap.get("createdate") %></td>
				
				<th>수정일</th>
				<td><%= commentMap.get("createdate").equals(commentMap.get("updatedate")) ? "-" : commentMap.get("updatedate") %></td>
			</tr>
		</table>
			<a style="margin-left: 83%;" href="<%= request.getContextPath() %>/question/deleteCommentAction.jsp?questionNo=<%=commentMap.get("questionNo") %>" class="btn btn-success">삭제</a><br>
		<textarea readonly style="outline:none; border: none; resize: none; 
					font-size:50; width: 70%; height: 100em;"><%= commentMap.get("comment") %></textarea>
	<% } %>	
<%if(loginManager!=null && commentMap==null){%>	
	<form method="post" action="<%=request.getContextPath()%>/question/insertCommentAction.jsp" style="margin-left: 10%;">
	<input type="hidden" name="questionNo" value="<%= resultMap.get("questionNo") %>" />
	<div>작성직원 : <input readonly value="<%= loginManager.getManagerName()%>"/></div>
				<input type="hidden" name="managerNo" value="<%= loginManager.getManagerNo()%>"/>
	<br>
	<textarea rows="10" cols="100" name="comment" style="resize: none;"></textarea>
	<button type="submit" class="btn btn-success">답변 등록</button>
	</form>
<%}%>



<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>










