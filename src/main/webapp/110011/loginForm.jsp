<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
	<style>
	.color {color : #6799FF;}
	</style>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	<h2>ㅇㅇ</h2>
	
<div class="color">


    <div>
      ID <input type="text" name="costomerId">
    </div>
  
    <div>
      PW <input type="password" name="costomerPw">
    </div>
  
  
    <div>
	    <a href ="<%=request.getContextPath()%>/110011/loginAction.jsp"><button>LOGIN</button></a>
	    <a href ="<%=request.getContextPath()%>/110011/insertCostomerForm.jsp"><button>JOIN</button></a>
    </div>
  
  
</div>

</body>
</html>