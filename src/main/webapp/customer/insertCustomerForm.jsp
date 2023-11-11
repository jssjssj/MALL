<%@page import="org.eclipse.jdt.internal.compiler.parser.RecoveredRequiresStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String msg4= request.getParameter("msg4");
String msg5= request.getParameter("msg5");
%>
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

	
   <form method="post" id="signinForm" action="<%=request.getContextPath()%>/customer/insertCustomerAction.jsp">
   <div class="outer">
  <div class="inner">
  <fieldset>
  <legend>회원가입</legend>
  	<% if(msg5 != null){
  	%> 
  		<div><%=msg5%></div>
  		<%  
  		}
  	    %>
      <table border="1">
            
         <!-- 아이디 -->
         <tr>
            <th>ID</th>
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
            <th>이름</th>
            <td>
               <input type="text" name="customerName" id="name" class="name"> 
               <span id="nameMsg" class="msg"></span>
            </td>
         </tr>
         
         <tr>
            <th>주소</th>
            <td>
               <input type="text" name="address" id="address" class="address"> 
               <span id="addressMsg" class="msg"></span>
            </td>
         </tr>
         
         <tr>
            <th>전화번호</th>
            <td>
               <input type="text" name="customerPhone" id="tel" class="tel"> 
               <span id="telMsg" class="msg"></span>
            </td>
         </tr>
         
         <tr>
         	<td>
               <button type="button" id="signinBtn" >가입하기</button>
            </td>
         </tr>
         
         
         
      </table>
    
      
      </fieldset>    
        </div>
</div>
   </form>

<!-- footer 시작 -->
   <div class="footer"><jsp:include page="/inc/footer.jsp"></jsp:include></div>
<!-- footer 끝 -->	
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
	});
	
	$('#name').keyup(function() {
		if($('#name').val().length < 2){
			$('#nameMsg').text('2글자 이상 입력해주세요.');
		} else {
			$('#nameMsg').text('');
		}
	});
	
	$('#address').keyup(function() {
		if($('#address').val().length < 2){
			$('#addressMsg').text('2글자 이상 입력해주세요.');
		} else {
			$('#addressMsg').text('');
		}
	});
	
	$('#tel').keyup(function() {
		if($('#tel').val().length < 10){
			$('#telMsg').text('10글자 이상 입력해주세요.');
		} else {
			$('#telMsg').text('');
		}
	});
	
	$('#signinBtn').click(function() {
		 if( ($('#id').val().length>=4) && ($('#pw').val().length>=4) && ($('#pw').val()==$('#pwck').val()) 
				 && ($('#name').val().length>=2) && ($('#tel').val().length>=10) && ($('#address').val().length>=2) ) {
				$('#signinForm').submit();
			 } else{
				 alert('ID , PW 조건을 확인해주세요');
			return;
			 }
		});

	</script>

</body>
</html>