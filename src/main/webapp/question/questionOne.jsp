<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	<table border="1">
		<tr>
			<td>제목</td>
		   	<td>맛있네</td>
		   	<td>작성자ID</td>
		   	<td>나</td>
		</tr>
		
		<tr>
			<td>답변일</td>
		   	<td>2022</td>
		   	<td>수정일</td>
		   	<td>2023</td>
		</tr>
		
		<tr>
			<td>내용
			</td>
			<td>너무맛있어요
			</td>
		</tr>
		
		<tr>
			<td>답변</td>
		   	<td>뭐요</td>
		</tr>
	</table>
</body>
</html>