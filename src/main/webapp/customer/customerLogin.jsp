<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	
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
	
	<header class="bg-dark py-5"> 
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                </div>
            </div>
        </header>
        
        
        <form method="post" action="">
      <div class="outer">
  <div class="inner">
  
     <fieldset> 
	<legend>로그인</legend>
		<table border="1" >
			<tr>
				<th>ID</th>  <th><input type="text" id="id"></th>
				<td><span id="idMsg"></span></td>
			</tr>
			
			<tr>
				<th>PW</th>  <th><input type="text" id="pw"></th>
				<td><span id="pwMsg"></span></td>
			</tr>
			
			<tr>
				<th colspan="2"><button id="login" type="submit">로그인</button>
					<button><a href="<%=request.getContextPath()%>/customer/insertCustomerForm.jsp">회원가입</a></button></th>
			</tr>
		</table>
		
	</fieldset>
	
		</div>
	</div>
	</form>
	
	<script>
	$('#id').click(function() {
		$('#id').val("");
	});
	
	$('#pw').click(function() {
		$('#pw').val("");
	});
	
	$('#login').click(function() {
		if($('#id').val().length<4) {
			alert('아이디는 4자 이상입니다.')	
			return;
			} else if ($('#pw').val().length<4) {
			alert('비밀번호는 4자 이상입니다.')	
			return;
		}
	});
	
	
	
	</script>
</body>
</html>










