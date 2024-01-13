<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.* , vo.*, java.util.Map " %>
<%
	ManagerDao managerDao = new ManagerDao();
	Manager loginManager = (Manager)session.getAttribute("loginManager");

	QuestionDao questionDao = new QuestionDao();	
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	Map<String, Object> resultMap = questionDao.questionOne(questionNo);
	
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
   <form action="<%=request.getContextPath()%>/questionComment/insertQuestionCommentAction.jsp" id="insertComAct">
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
	<div style="margin-left: 85%">
		<a href="<%= request.getContextPath() %>/question/updateForm.jsp?questionNo=<%= resultMap.get("questionNo") %>" class="btn btn-success">수정</a>
		<a href="<%= request.getContextPath() %>/question/deleteAction.jsp?questionNo=<%= resultMap.get("questionNo") %>" class="btn btn-success">삭제</a>
	</div>
			<br>
	<textarea style="resize: none;" cols="155" rows="10" readonly="readonly"><%= resultMap.get("questionContent") %></textarea>
<%if(loginManager!=null){%>	
	<a href="<%=request.getContextPath()%>/question/deleteQuestionForm.jsp"><button>해당글 삭제</button></a>
	<!-- 나중에 제이쿼리 이용 후 버튼타입은 없앨예정 --><button type="submit" id="insertComBtn">답변 등록</button>
<%}%>
</form>


<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>










