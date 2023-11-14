<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
    
<%
    // 대시보드 페이지에서 매니저 로그인 여부 확인
    session = request.getSession();
    Manager loginManager = (Manager) session.getAttribute("loginManager");

    // 매니저가 로그인되어 있으면 관리 페이지로 리다이렉트
    if (loginManager != null) {
    	response.sendRedirect(request.getContextPath() + "/manager/dashboard.jsp");
    } 
    	
    
   
    // 매니저가 로그인되어 있으면 대시보드 페이지 출력
%>  
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    <section class="w-100 p-4 d-flex justify-content-center pb-4">
    <form style="width: 22rem;" method="post" 
    action="managerLoginAction.jsp" id="logAction">
     <div class="container">>
  	   <fieldset>
  	   <!-- Id input -->
  	   	<div class="mb-4">
  	   		<div class="form-outline">
  	   			<input type="text" name="managerId" id="id" class="form-control"/>
  	   			<label class="form-label" for="id">ID</label>
			</div>
			<div id="idMsg" class="form-text text-danger"></div>
		</div>
		<!-- Password input -->
		<div class="mb-4">
			<div class="form-outline">
				<input type="password" name="managerPw" id="pw" class="form-control" />
				<label class="form-label" for="pw">PASSWORD</label>
			</div>
			<div id="pwMsg" class="form-text text-danger"></div>
		</div>
		<!-- 실행 button -->
		<button type="submit" class="btn btn-primary btn-block mb-4" id="loginBtn">로그인</button>
		<!-- 관리자 추가 buttons -->
		<div class="text-center">
			<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">관리자 추가</a>
		</div>
        </fieldset> 
      </div>
    </form>
   </section> 
    <script>
	$('#id').click(function() {
		$('#id').val('');
	});
	
	$('#pw').click(function() {
		$('#pw').val('');
	});
	
	
	$('#id').keyup(function() {
		if($('#id').val().length<4) {
		$('#idMsg').text('ID는 4자 이상입니다.');
	}	else{
		$('#idMsg').text('');
		}
	});
	
	$('#pw').keyup(function() {
		if($('#pw').val().length<4) {
		$('#pwMsg').text('ID는 4자 이상입니다.');
		} else {
			$('#pwMsg').text('');	
		}
	});
	
	$('#loginBtn').click(function() {
		$('#logAction').submit();
	});
	</script>
<!-- footer 시작 -->
   <div class="footer"><jsp:include page="/inc/footer.jsp"></jsp:include></div>
<!-- footer 끝 -->	        
</body>
</html>
