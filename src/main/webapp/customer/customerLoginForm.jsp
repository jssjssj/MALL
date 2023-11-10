<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
	String msg = request.getParameter("msg");
	String msg3= request.getParameter("msg3");

	if(session.getAttribute("loginId") != null) {
		String msg2 = URLEncoder.encode("로그인 상태입니다!");
		response.sendRedirect("http://localhost/mall/110011/index.jsp?msg2="+msg2);
		}
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
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

 <!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
        
        
        <form method="post" id="logAction" action="customerLoginAction.jsp">
      <div class="outer">
  <div class="inner">
  
     <fieldset> 
<%
if(msg3 != null) {
%>
	<div class="msg"><%=msg3%></div>
	
<%
}
%>
	<div>로그인</div>
	
<%
if(msg != null) {
%>
	<div class="msg"><%=msg%></div>
	
<%
}
%>

		<table border="1" >
			<tr>
				<th>ID</th>  <th><input type="text" name="customerId" id="id"></th>
				<td><span id="idMsg" ></span></td>
			</tr>
			
			<tr>
				<th>PW</th>  <th><input type="password" name="customerPw" id="pw"></th>
				<td><span id="pwMsg" ></span></td>
			</tr>
			
			<tr>
				<th colspan="2"><button id="loginBtn" type="button">로그인</button>
					<button><a href="<%=request.getContextPath()%>/customer/insertCustomerForm.jsp">회원가입</a></button></th>
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










