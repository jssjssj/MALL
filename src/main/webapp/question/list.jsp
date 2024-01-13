<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%
	QuestionDao questionDao = new QuestionDao();

	Integer currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	int totalRow = questionDao.countOfQuestion();
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage += 1;
	}
	Map<String, Integer> paramMap = new HashMap<>();
	paramMap.put("beginRow", beginRow);
	paramMap.put("rowPerPage", rowPerPage);
	
	List<Map<String, Object>> questionList = questionDao.questionList(paramMap);
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body style="min-height: 100vh">	

	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	<br>
	
	<div style="text-align: center;">
 	<h2>문의 목록</h2>
		<a class="btn btn-success mt-auto" 
			href="<%=request.getContextPath()%>/question/insertQuestionForm.jsp">
			문의글 쓰기
		</a>
	</div>
	

	
		<table class="table table-hover">
			<thead>
			    <tr>
			        <th>No</th>
			        <th>제목 </th>
			        <th>문의상품 </th>
			        <th>작성일 </th>
			        <th>답변수정일</th>
			    </tr>
			</thead>
		
		    <% for (Map<String, Object> question : questionList) { %>
		    <tbody>
		        <tr>
		            <td><%= question.get("questionNo") %></td>
		            <td><a href="<%= request.getContextPath() %>/question/questionOne.jsp?questionNo=<%= question.get("questionNo") %>"><%= question.get("questionTitle") %></a></td>  
		            <td><%= question.get("goodsTitle") %></td>
		            <td><%= question.get("createdate") %></td> 
		            <td><%= question.get("createdate").equals(question.get("updatedate"))  ? "-" : question.get("updatedate") %></td>               
		        </tr>
		    </tbody>
		    <% } %>
		</table>		
	
		<br>
	

    <br>
<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	

</body>
</html>
