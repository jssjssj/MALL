<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<style>
	.msg {color : #FF0000;}
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
<title>MALL : 회원가입</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

 <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Shop Homepage</title>
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
        
<div class="outer">
  <div class="inner">
	<h2>회원가입</h2>
   <form id="signinForm" action="/js1219/signinAction.jsp">
      <table border="1">
            
         <!-- 아이디 -->
         <tr>
            <td>아이디</td>
            <td>
               <input type="text" name="costomerId" id="id"> 
               <span id="idMsg" class="msg"></span>
            </td>
         </tr>
         <!-- 비밀번호 -->
         <tr>
            <td>
               <div>비밀번호</div>
               <div>비밀번호확인</div>
            </td>
            <td>
               <div>
                  <input type="password" name="costomerPw" id="pw">
                  <span id="pwMsg" class="msg"></span>
               </div>
               <div>
                  <input type="password" name="costomerPwCk" id="pwck">
               </div>
            </td>
         </tr>
         <!-- 이름 -->
         <tr>
            <td>이름</td>
            <td>
               <input type="text" name="costomerName" id="name">
               <span id="nameMsg" class="msg"></span>
            </td>
         </tr>
                
         <!-- 성별 -->
         <tr>
            <td>성별</td>
            <td>
               <input type="radio" name="gender" class="gender">남 
               <input type="radio" name="gender" class="gender">여
               <span id="genderMsg" class="msg"></span>
            </td>   
        </tr>
         
         <tr>
         	<td>주소</td>
         	<td><input type="text" name="address"></td>
         </tr>
         
         <tr>
         	<td>전화번호</td>
         	<td><input type="text" name="CustomerPhone" id="CustomerPhone"></td>
         </tr>
        
         
      </table>
      <button type="button" id="signinBtn">회원가입</button>      
   </form>
  </div>
</div>

<script>
	$('id').focus();
	   // id폼 유효성체크
	   $('#id').blur(function() {
		   if($('#id').val().length < 4) {
			   $('#idMsg').text('ID를 4자 이상 입력하세요')
			   $('#id').focus();
		   } else {
			   $('#idMsg').text('')
			   $('#pw').focus();
		   }
	   });
	   
	   
		// pw폼 유효성체크
		$('#pw').blur(function() {
		   if($('#pw').val().length < 4) {
			   $('#pwMsg').text('PW를 4자 이상 입력하세요')
			   $('#pw').focus();
		   } else {
			   $('#pwMsg').text('')
			   $('#pwch').focus();
		   }
	   });
		
		// pwck폼 유효성체크
		$('#pwck').blur(function() {
		   if($('#pw').val()!= $('#pwck').val()) {
			   $('#pwMsg').text('PW를 확인하세요')
			   $('#pw').focus();
		   } else {
			   $('#pwMsg').text('')
			   $('#name').focus();
		   }
	   });
		
		// name폼 유효성체크
		$('#name').blur(function() {
		   if($('#name').val().length < 1) { // $('#name').val() == ''
			   $('#nameMsg').text('이름을 입력하세요')
			   $('#name').focus();
		   } else {
			   $('#nameMsg').text('')
			   $('#birth').focus();
		   }
	   });


</script>

</body>
</html>













