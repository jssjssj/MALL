<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>공지사항 수정</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->

<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Shop in style</h1>
            <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
        </div>
    </div>
</header>
<form method="post" id="signinForm" action="<%=request.getContextPath()%>/customer/insertCustomerAction.jsp">
   <div class="outer">
  <div class="inner">
  <fieldset>
  <legend>회원가입</legend>
      <table border="1">
            
         <!-- 아이디 -->
         <tr>
            <th>제목</th>
            <td>
               <input type="text" name="customerId" id="id" class="id"> 
               <span id="idMsg" class="msg"></span>
            </td>
         </tr>
         <!-- 비밀번호 -->
         <tr>
            <th>PW</th>
            <td>
               <input type="password" name="customerPw" id="pw" class="pw"> 
               <span id="pwMsg" class="msg"></span>
            </td>
         </tr>
         
          <tr>
            <th>PW확인</th>
            <td>
               <input type="password" name="customerPwck" id="pwck" class="pwck"> 
               <span id="pwckMsg" class="msg"></span>
            </td>
         </tr>
         
         <tr>
         	<td>
               <button type="submit" id="signinBtn" >가입하기</button>
            </td>
         </tr>
         
         
         
      </table>
    
      
      </fieldset>    
        </div>
</div>
   </form>


<script>
	
	$('#id').keyup(function() {
		if($('#id').val().length<4) {
		$('#idMsg').text('ID는 4자 이상입니다.');
	}	else{
		$('#idMsg').text('');
		}
	});
	
	$('#pw').keyup(function() {
		if($('#pw').val().length<4) {
		$('#pwMsg').text('PW는 4자 이상입니다.');
		} else {
			$('#pwMsg').text('');	
		}
	});
	
	$('#pwck').keyup(function() {
		if($('#pw').val()!=$('#pwck').val()){
			$('#pwckMsg').text('PW와 일치하지 않습니다.');
		} else {
			$('#pwckMsg').text('PW와 일치합니다!');
		}
	})
	
	$('#signinBtn').click(function() {
	 if ($('#id').val().length<4 || $('#pw').val().length<4 || $('#pw').val()!=$('#pwck').val()) {
		 alert('ID , PW 필수조건을 확인하세요.')
		 return;
		 } else{
			 alert('회원가입 성공 , 로그인 후 이용해주세요~');
		$('#signinForm').submit();
		 }
	});
	

	
	
	</script>
</body>
</html>