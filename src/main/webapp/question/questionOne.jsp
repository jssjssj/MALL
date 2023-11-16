<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.* , vo.*" %>
<%
	String customerId = (String)(session.getAttribute("loginId"));
	int questionNo = Integer.parseInt(request.getParameter("questionNo"));
	System.out.print(questionNo);
	Question q = new Question();
	QuestionDao questionDao = new QuestionDao();
	q = questionDao.QuestionOne(questionNo);
	Manager loginManager = (Manager) session.getAttribute("loginManager");
%>
<!DOCTYPE html>
<html>
<style>
table, td, th {
  border : 1px solid black;
  border-collapse : collapse;
}

th, td {
  text-align: center;
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
   <form action="<%=request.getContextPath()%>/questionComment/insertQuestionCommentAction.jsp" id="insertComAct">
	<table border="1">
		<tr>
			<td>제목</td>
		   	<td><%=q.getQuestionTitle()%></td>
		</tr>  	
		   	
		   	
		 <tr>
		   	<td>작성자ID</td>
		   	<td><%=q.getCustomer().getCustomerId()%></td>
		 </tr>
		
		<tr>
			<td>답변일</td>
		   	<td><%=q.getQuestionComment().getCreatedate()%></td>
		</tr>
		
		<tr>
		   	<td>수정일</td>
		   	<td><%=q.getQuestionComment().getUpdatedate()%></td>
		</tr>
		
		<tr>
			<td>내용</td>
			<td><%=q.getQuestionContent()%></td>
		</tr>
		
		<tr>
			<td>답변</td>
		   	<td><%=(q.getQuestionComment().getComment()!=null) ? q.getQuestionComment().getComment() : "답변대기중"%></td>
		</tr>
<%if(loginManager!=null){%>
		<tr>
			<td>답변 입력</td>
			<td><input type="text" name="comment" id="comment"></td>
		</tr>

<%}%>
	</table>
<%if(loginManager!=null){%>	
	<a href="<%=request.getContextPath()%>/question/deleteQuestionForm.jsp"><button>해당글 삭제</button></a>
	<!-- 나중에 제이쿼리 이용 후 버튼타입은 없앨예정 --><button type="submit" id="insertComBtn">답변 등록</button>
<%}%>
</form>


<script>
	$('#insertComBtn').click(function(){
		if($('#comment').val().length <15){
			return;
			alert('답변은 15자 이상 입력필요');
		} else{
			$('#insertComAct').submit();
		}
	});
	<!-- footer 시작 -->
	   <div class="footer"><jsp:include page="/inc/footer.jsp"></jsp:include></div>
	<!-- footer 끝 -->
</script>	
</body>
</html>










