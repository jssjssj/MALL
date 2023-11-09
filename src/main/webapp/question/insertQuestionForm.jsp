<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <!-- Favicon-->
        <link rel="icon" type="/image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="/css/styles.css" rel="stylesheet" />
<title>Insert title here</title> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->
	
	<form method="get" action="insertQuestionAction.jsp">
		<fieldset>
			<h3>Q.A</h3>
				<table border = "1"> <!-- ArrayList 예정 -->
				 <tr>
				 	<th>제목</th><!-- 제목 클릭 시 상세보기 및 답변으로 이동기능 예정 -->
				 	<td>작성자ID</td>
				 </tr>
				 
				 <tr>
				 	<th>제목</th><!-- 제목 클릭 시 상세보기 및 답변으로 이동기능 예정 -->
				 	<td>작성자ID</td>
				 </tr>
				 
				 <tr>
				 	<th>제목</th><!-- 제목 클릭 시 상세보기 및 답변으로 이동기능 예정 -->
				 	<td>작성자ID</td>
				 </tr>
				</table>
		</fieldset>	
	</form>
</body> 
</html>