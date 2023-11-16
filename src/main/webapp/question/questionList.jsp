<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vo.Question" %>
<%@ page import="dao.QuestionDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>

<%
    // 문의사항 목록 조회
    QuestionDao questionDao = new QuestionDao();
	String customerId = (String)(session.getAttribute("loginId"));
    List<Question> qul = new ArrayList<>();
    qul = questionDao.selectQuestion();
	String q = request.getParameter("q"); // 문의글 등록 후 등록완료+답변대기 안내멘트
	if(customerId==null){
		response.sendRedirect(request.getContextPath()+"/customer/customerLoginForm.jsp");
	}
%>
<!DOCTYPE html>
<html>
<style>
table, td, th {
  border : 1px solid black;
  border-collapse : collapse;
}
table {
  width : 1000px;
  height : 50px;
}
th, td {
  text-align: center;
}
</style>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body style="min-height: 100vh">	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
  <h2 class="container">Question 목록</h2>
<%if(q != null){%><div><%=q%></div><%}%>	<!-- 문의글 등록 후 등록완료+답변대기 안내멘트 -->

<form method="get" action="<%=request.getContextPath()%>/question/insertQuestionForm.jsp">
	<div class="container">	
		<table border="1">
		    <tr>
		        <th>내용/답변보기</th>
		        <th>문의상품 </th>
		        <th>제목 </th>
		        <th>작성일 </th>
		        <th>답변일 </th>
		        <th>답변수정일</th>
		    </tr>
		</table>
		<table border="1">
		    <% for (Question qu : qul) { %>
		        <tr>
		            <td><a href="<%=request.getContextPath()%>/question/questionOne.jsp">내용/답변보기</a></td>
		            <td><%=qu.getGoods().getGoodsTitle()%></td>
		            <td><%= (qu.getQuestionTitle() != null)  	    ? qu.getQuestionTitle() 	:	  ""%></td>
		            <td><%= (qu.getCreatedate() != null)      		? qu.getCreatedate()  	  : 	 "" %></td>  
		            <td><%= (qu.getQuestionComment().getCreatedate() == null)? "한글깨짐?" : qu.getQuestionComment().getCreatedate()%></td> 
		            <td><%= (qu.getQuestionComment().getUpdatedate() ==null) ? "여긴보이나" :qu.getQuestionComment().getUpdatedate()%></td>               
		        </tr>
		    <% } %>
		</table>		
	</div>
		<br><div class="container"><button type="submit">문의글 쓰기</button></div>
</form>
    
<!-- footer 시작 -->
<!-- footer 끝 -->	
</body>
<jsp:include page="/inc/footer.jsp"></jsp:include>
</html>
