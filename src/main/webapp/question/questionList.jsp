<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vo.Question" %>
<%@ page import="dao.QuestionDao" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // 문의사항 목록 조회
    QuestionDao questionDao = new QuestionDao();
	
    List<Question> questionList = questionDao.selectQuestion();
	String q = request.getParameter("q");

%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body style="min-height: 100vh">	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
  <h2 class="container">Question 목록</h2>
<%if(q != null){%><div><%=q%></div><%}%>	

<form method="get" action="<%=request.getContextPath()%>/question/insertQuestionForm.jsp">
	<div class="container">	
		<table border="1">
		    <tr>
		        <th>내용/답변보기 |</th>
		        <th> 문의상품 |</th>
		        <th> 제목 |</th>
		        <th> 작성일</th>
		    </tr>
		
		    <% for (Question qu : questionList) { %>
		        <tr>
		            <td><a href="<%=request.getContextPath()%>/question/questionOne.jsp">내용/답변보기</a></td>
		            <td><%=qu.getGoods().getGoodsTitle() %></td>
		            <td><%=qu.getQuestionTitle() %></td>
		            <td><%=qu.getCreatedate() %></td>  
		                         
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
