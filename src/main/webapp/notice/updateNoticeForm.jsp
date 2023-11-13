<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder.*" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>

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
	
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>