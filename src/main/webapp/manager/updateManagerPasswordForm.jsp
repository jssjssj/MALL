<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 수정</title>
</head>
<body>
    <form action="updateManagerPasswordAction.jsp" method="post">
        <input type="hidden" name="managerNo" value="<%= request.getParameter("managerNo") %>">
        현재 비밀번호: <input type="password" name="currentPassword"><br>
        새로운 비밀번호: <input type="password" name="newPassword"><br>
        <input type="submit" value="비밀번호 수정">
    </form>
</body>
</html>
