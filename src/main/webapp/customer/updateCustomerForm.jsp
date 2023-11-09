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
								<td><input type="text" readonly="readonly" value="히히"></td>
							</tr>
							
							<tr>
								<th>현재PW</th>
								<td><input type="password" name="customerPw"></td>	
							</tr>
							
							<tr>
								<th>변경PW</th>
								<td><input type="password" name="newPw"></td>	
							</tr>
							
							<tr>
								<th>변경PW확인</th>
								<td><input type="password" name="newPwck"></td>	
							</tr>
							
							<tr>
								<th>이름</th>
								<td><input type="text" value="히히"></td>	
							</tr>
							
							<tr>
								<th>주소</th>
								<td><input type="text" value="히히"></td>	
							</tr>
							
							<tr>
								<th>전화번호</th>
								<td><input type="text" value="히히"></td>	
							</tr>
								
						</table>
						<button type="submit">저장하기</button>
				</fieldset>
		</div>
	</form>
</body>
</html>