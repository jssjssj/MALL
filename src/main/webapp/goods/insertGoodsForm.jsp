<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<style>
    .container{
    display:flex;
    justify-content:center;
    align-items:center;
    }
</style>
  
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
<form method="get" action="<%=request.getContextPath()%>/goods/insertGoodsAction.jsp">		
	<fieldset>
		<legend class="container">상품추가</legend>
				<table border="1"  class="container">
					<tr>
						<th>상품명</th> <td><input type="text" name="goodsTitle"></td>
					</tr>
					
					<tr>
						<th>상품가격</th> <td><input type="number" name="goodsPrice"></td>
					</tr>
					
					<tr>
						<th>재고</th> 
					<td>	
						<select name="soldout">
							<option>판매중</option>
							<option>품절</option>
							<option>준비중 (출시예정)</option>
						</select>	
					</td>
					</tr>
					
					<tr>
						<th>상품설명</th> <td><textarea rows="5" name="goodsMemo"></textarea></td>
					</tr>
					
					<tr>
						<th>상품이미지</th>
						<td>
							<input type="file" name="fileName">
						</td>
					</tr>
					
					<tr>
						<th>originName</th> 
						<td>
							<input type="text" name="originName">
						</td>
					</tr>
					
					<tr>
						<th>contentType</th> 
						<td>
							<input type="text" name="contentType">
						</td>
					</tr>
											
					<tr>
						<td><button type="submit">등록하기</button></td>
					</tr>				
				</table>
			
	</fieldset>
</form>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html>