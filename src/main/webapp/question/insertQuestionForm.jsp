<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	CustomerDao customerDao = new CustomerDao();
	
	// customerId 사용
	String customerId = (String)(session.getAttribute("loginId"));
	
	// customerDao.customerOne 메서드에서 null을 반환하는 경우를 처리
	Customer customer = customerDao.customerOne(customerId);
	CustomerDetail customerDetail = null;
	CustomerAddr customerAddr = null;
	
	if (customer != null) {
	    customerDetail = customer.getCustomerDetail();
	    customerAddr = customer.getCustomerAddr();
	}
%>
<!DOCTYPE html>
<html>
<head>
<style>
	
	.container {
            display: flex;
            justify-content: center;
            align-items: center;
        }    
	</style>
<meta charset="UTF-8">
<title>InsertQuetion</title> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->
	<form method="post" id="createNoticeForm"
		action="<%=request.getContextPath()%>/question/insertQuetionAction.jsp">
		<div class="container">
			<fieldset>
				<legend>문의글 등록</legend>
				<table border="1">
					<!-- 제목 -->
					<tr>
						<th>제목</th>
						<td><textarea cols="100" name="questionTitle" id="title" maxlength="15"
							class="title"></textarea>
							<br><span id="titleMsg" class="msg"></span></td>
					</tr>
					<!-- 내용 -->
					<tr>
						<th>내용</th>
						<td><textarea cols="100" rows="10" name="questionContent" id="content"  class="content"
						 maxlength="100">
						</textarea>
						<br><span id="contentMsg" class="msg"></span>
						</td>
					</tr>
					
					<tr>
						<td>
							<button type="submit">등록하기</button>
						</td>
					</tr>
					
				</table>
			</fieldset>
		</div>
	</form>
	
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
<script>


	$('#title').keyup(function(){
		if($('#title').val().length>0){
			$('#titleMsg').text('제목은 15자 이내로 입력가능합니다.')
		} else {
			$('#titleMsg').text('')
		}
	});
	
	$('#content').keyup(function(){
		if($('#content').val().length>0){
			$('#contentMsg').text('문의글은자 100자 이내로 입력가능합니다.')
		} else {
			$('#contentMsg').text('')
		}
	});

	
</script>
</body> 
</html>