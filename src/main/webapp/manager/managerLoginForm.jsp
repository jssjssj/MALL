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
<head>
<style>
	.msg{color:#FF0000;}
	.outer{position:relative;
			width:100%;
			height:100%;
			font-size:25px;
			margin:50;}
	.inner{position: absolute;
			transform; transate{50%,-50%};
			left:50%;
			top:50%;}
	</style>
    <meta charset="UTF-8">
    <title>Manager Login</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>    
</head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->	
    <form method="post" action="managerLoginAction.jsp" id="logAction">
     <div class="outer">
  	  <div class="inner">
  	   <fieldset>
  	   	<table border="1">
  	   		<tr>
				<th>ID</th>
				<th><input type="text" name="managerId" id="id" required></th>
				<td><span id="idMsg" ></span></td>
			</tr>
			
			<tr>
				<th>PW</th>  <th><input type="password" name="managerPw" id="pw" required></th>
				<td><span id="pwMsg" ></span></td>
			</tr>
			
			<tr>
				<th colspan="2"><button id="loginBtn" type="button">로그인</button>
					<button><a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">관리자 추가</a></button></th>
			</tr>
         </table>
        </fieldset> 
      </div>
	 </div>
    </form>
    
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
        
</body>
</html>
