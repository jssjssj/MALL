<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.* , vo.*, java.util.Map " %>
<%

%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
<jsp:include page="/inc/menubar.jsp"></jsp:include>
<jsp:include page="/inc/header.jsp"></jsp:include>
	<form method="POST" id="createNoticeForm"
		action="<%=request.getContextPath()%>/question/insertQuetionAction.jsp">
		<div class="container">
			<fieldset>
				<h2>문의글 등록</h2> <br>
				<h6>문의글은 수정 및 삭제할 수 없으니 신중히 등록해주세요</h6>
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
						<th>문의상품</th>
						<td><select name="goodsTitle"><% for (Goods g : goodsList) { %>
							<option><%= g.getGoodsTitle()%></option> <%} %>
						</select></td>
					</tr>
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
			$('#contentMsg').text('내용은 100자 이내로 입력가능합니다.')
		} else {
			$('#contentMsg').text('')
		}
	});
</script>
</body> 
</html>