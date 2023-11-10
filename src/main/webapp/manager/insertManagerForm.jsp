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
<title>관리자 계정 추가</title>
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
	
   <form method="post" id="signinForm" action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp">
   <div class="outer">
  <div class="inner">
  <fieldset>
  <legend>admin 생성</legend>
      <table border="1">
            
         <!-- 아이디 -->
         <tr>
            <th>ID</th>
            <td>
               <input type="text" name="managerId" id="id" class="id"> 
               <span id="idMsg" class="msg"></span>
            </td>
         </tr>
         <!-- 비밀번호 -->
         <tr>
            <th>PW</th>
            <td>
               <input type="password" name="managerPw" id="pw" class="pw"> 
               <span id="pwMsg" class="msg"></span>
            </td>
         </tr>
         
          <tr>
            <th>PW확인</th>
            <td>
               <input type="password" name="managerPwck" id="pwck" class="pwck"> 
               <span id="pwckMsg" class="msg"></span>
            </td>
         </tr>
         
          <!-- 이름 -->
         <tr>
            <th>이름</th>
            <td>
               <input type="text" name="managerName" id="name" class="name"> 
               <span id="nameMsg" class="msg"></span>
            </td>
         </tr>
         
         <tr>
         	<td>
               <button type="button" id="signinBtn" >계정 생성</button>
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
		 if( ($('#id').val().length>=4) && ($('#pw').val().length>=4) && ($('#pw').val()==$('#pwck').val())  ) {
			 alert('매니저 계정 생성 성공 ');
				$('#signinForm').submit();
			 } else{
				 alert('ID , PW 조건을 확인해주세요');
			 	return;
			 }
		});
	</script>
	
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>