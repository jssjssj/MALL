<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%


if (session.getAttribute("loginId") != null) {
	String msg2 = URLEncoder.encode("로그인 상태입니다!");
	response.sendRedirect(request.getContextPath() + "/110011/index.jsp?msg2=" + msg2);
}
	String noMsg = request.getParameter("noMsg"); // 비활성화 계정 로그인 시 탈퇴한 계정입니다 표시
	String noUser = request.getParameter("noUser"); // ID , PW 일치하지 않습니다 -> 계정정보 불일치 시 확인메시지
%>

<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<section class="w-100 p-4 d-flex justify-content-center pb-4">
		<form style="width: 22rem;" method="post" id="logAction" action="customerLoginAction.jsp">
			<div class="container">
				<fieldset>
	<%if(noUser != null){%><div class="msg"><%=noUser%></div><%}%>
	<%if(noMsg != null){ %><div class="msg"><%=noMsg%> </div><%}%>
					<!-- Email input -->
					<div class="mb-4">
						<div class="form-outline">
							<input type="text" name="customerId" id="id" class="form-control" />
							<label class="form-label" for="id">아이디</label>
						</div>
						<div id="idMsg" class="form-text text-danger"></div>
					</div>
	
					<!-- Password input -->
					<div class="mb-4">
						<div class="form-outline">
							<input type="password" name="customerPw" id="pw" class="form-control" />
							<label class="form-label" for="pw">비밀번호</label>
						</div>
						<div id="pwMsg" class="form-text text-danger"></div>
					</div>
	
					<!-- Submit button -->
					<button type="submit" class="btn btn-primary btn-block mb-4" id="loginBtn">로그인</button>
	
					<!-- Register buttons -->
					<div class="text-center">
						<p>회원이 아니신가요? <a href="<%=request.getContextPath()%>/customer/insertCustomerForm.jsp">가입하기</a></p>
					</div>
	
				</fieldset>
	
				
			</div>
		</form>
	</section>
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
	</script>

</body>
</html>










