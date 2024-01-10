<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
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

<section class="w-100 p-4 d-flex justify-content-center pb-4">
	<form style="width: 22rem;" method="post" id="logAction" 
		action="<%=request.getContextPath()%>/manager/insertAction.jsp" method="post">
		<div class="container">
			<fieldset>
		
	<div class="mb-4">
		<div class="form-outline">
			<input type="text" name="managerId" id="id" class="form-control" />
			<label class="form-label" for="id">아이디</label>
		</div>
		<div id="idMsg" class="form-text text-danger"></div>
	</div>
	
	<div class="mb-4">
		<div class="form-outline">
			<input type="password" name="managerPw" id="pw" class="form-control" />
			<label class="form-label" for="id">비밀번호</label>
		</div>
		<div id="idMsg" class="form-text text-danger"></div>
	</div>
	
	<div class="mb-4">
		<div class="form-outline">
			<input type="password" class="form-control" />
			<label class="form-label" for="id">비밀번호 확인</label>
		</div>
		<div id="idMsg" class="form-text text-danger"></div>
	</div>
	
	<div class="mb-4">
		<div class="form-outline">
			<input type="text" name="managerName" class="form-control" />
			<label class="form-label" for="id">이름</label>
		</div>
		<div id="idMsg" class="form-text text-danger"></div>
	</div>
	
	<button type="submit" class="btn btn-primary btn-block mb-4" id="loginBtn">회원가입</button>	
						
			</fieldset>					
		</div>
	</form>
</section>

	<!-- footer 시작 -->
	<div class="footer"><jsp:include page="/inc/footer.jsp"></jsp:include></div>
	<!-- footer 끝 -->
  
</body>
</html>
