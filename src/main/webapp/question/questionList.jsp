<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vo.Question" %>
<%@ page import="dao.QuestionDao" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // 문의사항 목록 조회
    QuestionDao questionDao = new QuestionDao();
    List<Question> questionList = questionDao.selectQuestion();
	String quesMsg1 = request.getParameter("quesMsg1");
	String quesMsg2 = request.getParameter("quesMsg2");

%>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
	
	.container {
            display: flex;
            justify-content: center;
            align-items: center;
        }
	</style>
<meta charset="UTF-8">
<title>QuestionList</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Shop Homepage</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        
    </head>
    <body>
    <!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	<h2 class="container">Question 목록</h2>
	<%
		if(quesMsg1 != null) {
	%>
		<div><%=quesMsg1%></div>
	<%		
		}
	%>
	
	<%
		if(quesMsg2 != null) {
	%>
		<div><%=quesMsg2%></div>
	<%		
		}
	%>
<form method="get" action="<%=request.getContextPath()%>/question/insertQuestionForm.jsp">
	<div class="container">	
		<table border="1">
		    <tr>
		        <th>문의번호 |</th>
		        <th>상품번호 |</th>
		        <th>고객번호 |</th>
		        <th>제목 |</th>
		        <th>작성일</th>
		    </tr>
		
		    <% for (Question question : questionList) { %>
		        <tr>
		            <td><%=question.getQuestionNO() %></td>
		            <td><%=question.getGoodsNo() %></td>
		            <td><%=question.getCustomerNo() %></td>
		            <td><%=question.getQuestionTitle() %></td>
		            <td><%=question.getCreatedate() %></td>                
		        </tr>
		    <% } %>
		</table>		
	</div>
		<br><div class="container"><button type="submit">문의하기</button></div>
</form>
    
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>
