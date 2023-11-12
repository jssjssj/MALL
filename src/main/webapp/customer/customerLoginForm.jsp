<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
String msg = request.getParameter("msg");
String msg3 = request.getParameter("msg3");
String noMsg = request.getParameter("noMsg");

if (session.getAttribute("loginId") != null) {
	String msg2 = URLEncoder.encode("로그인 상태입니다!");
	response.sendRedirect(request.getContextPath() + "/110011/index.jsp?msg2=" + msg2);
}
%>

<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>

	<form method="post" id="logAction" action="customerLoginAction.jsp">
		<div class="container">
			<fieldset>
<%
				if (msg3 != null) {
%>
				<div class="msg"><%=msg3%></div>

<%
				}
%>
				<div>로그인</div>

<%
				if (msg != null) {
%>
				<div class="msg"><%=msg%></div>

<%
				}
%>
<%
				if (noMsg != null) {
%>
				<div><%=noMsg%></div>
<%
				}
%>
				<!-- Email input -->
				<div class="form-outline mb-4">
					<input type="text" name="customerId" id="id" class="form-control" />
					<label class="form-label" for="id">아이디</label>
					<span id="idMsg"></span>
				</div>

				<!-- Password input -->
				<div class="form-outline mb-4">
					<input type="password" name="customerPw" id="pw" class="form-control" />
					<label class="form-label" for="pw">비밀번호</label>
					<span id="pwMsg"></span>
				</div>

				<!-- Submit button -->
				<button type="button" class="btn btn-primary btn-block mb-4" id="loginBtn">로그인</button>

				<!-- Register buttons -->
				<div class="text-center">
					<p>회원이 아니신가요? <a href="<%=request.getContextPath()%>/customer/insertCustomerForm.jsp">가입하기</a></p>
				</div>

			</fieldset>

			
		</div>
	</form>
<!-- footer 시작 -->
   <div class="footer"><jsp:include page="/inc/footer.jsp"></jsp:include></div>
<!-- footer 끝 -->	
	<script>
		$('#id').click(function() {
			$('#id').val('');
		});

		$('#pw').click(function() {
			$('#pw').val('');
		});

		$('#id').keyup(function() {
			if ($('#id').val().length < 4) {
				$('#idMsg').text('ID는 4자 이상입니다.');
			} else {
				$('#idMsg').text('');
			}
		});

		$('#pw').keyup(function() {
			if ($('#pw').val().length < 4) {
				$('#pwMsg').text('ID는 4자 이상입니다.');
			} else {
				$('#pwMsg').text('');
			}
		});

		$('#loginBtn').click(function() {
			$('#logAction').submit();
		});
	</script>

</body>
</html>










