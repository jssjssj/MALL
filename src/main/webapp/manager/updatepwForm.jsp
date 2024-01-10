<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.* "%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>	

    <form name="passwordForm" action="updateManagerPasswordAction.jsp" method="post" onsubmit="return validateForm()">
        <%-- 세션에서 가져온 매니저 정보를 이용하여 폼 필드 채우기 --%>
        <input type="hidden" name="managerNo" value="<%= loginManager.getManagerNo() %>">
        현재 비밀번호: <input type="password" name="currentPassword"><br>
        새로운 비밀번호: <input type="password" name="newPassword"><br>
        확인 비밀번호: <input type="password" name="confirmPassword"><br>
        <input type="submit" value="비밀번호 수정">
    </form>
    

<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->    
    <script>
        function validateForm() {
            var newPassword = document.forms["passwordForm"]["newPassword"].value;
            var confirmPassword = document.forms["passwordForm"]["confirmPassword"].value;

            if (newPassword !== confirmPassword) {
                alert("새로운 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                return false;
            }
        }
    </script>
</body>
</html>
