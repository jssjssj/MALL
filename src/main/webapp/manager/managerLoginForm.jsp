<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager Login</title>
</head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->	
    <form method="post" action="managerLoginAction.jsp">
        ID: <input type="text" name="managerId" required><br>
        Password: <input type="password" name="managerPw" required><br>
        <button type="submit">Login</button>
    </form>
    

<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->    
</body>
</html>
