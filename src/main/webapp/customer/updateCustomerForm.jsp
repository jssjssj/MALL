<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.container{
	display:flex;
	justify-content:center;
	align-items:center;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->
	<form method="post" action="updateCustomerAction.jsp">
		<div class="container">
				<fieldset>
					<legend>정보수정</legend>
						<table border="1" width="300" height="200">
							<tr>
								<th>ID</th>
								<td></td>				
							</tr>
							
							<tr>
								<th>이름</th>
								<td></td>	
							</tr>
							
							<tr>
								<th>주소</th>
								<td></td>	
							</tr>
							
							<tr>
								<th>전화번호</th>
								<td></td>	
							</tr>
								
						</table>
						<button type="submit">저장하기</button>
				</fieldset>
		</div>
	</form>
</body>
</html>