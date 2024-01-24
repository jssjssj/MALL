<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

	GoodsDao goodsDao = new GoodsDao();
	Map<String, Object> goodsMap = goodsDao.select(goodsNo);
%>

<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    
	<br>
		<% if(goodsMap.get("soldout").equals("Y")) { %>
			<div class="alert alert-warning" style="text-align: center;">
	  			<strong>매진!</strong> 해당상품은 현재 매진되어 주문할 수 없습니다. 재입고를 기다려주세요.
			</div>		
		<% } %>
	<div style="text-align: center;">
		<form action="<%= request.getContextPath() %>/order/insertForm.jsp" method="post">
		<img src="/mall/<%= goodsMap.get("originName") %>" alt="..." style="width: 20%">
				<br>
				<br>
		<div>
			<button type="submit" id="orderBtn" class="btn btn-outline-dark mt-auto">구매</button>	
		</div>
		
		<br><br>
		
		<table class="table">
			<tr>
				<td>상품명</td>
				<td>
					<input type="hidden" name="goodsNo" value="<%= goodsMap.get("goodsNo") %>">
					<input type="hidden" name="goodsTitle" value="<%= goodsMap.get("goodsTitle") %>">
					<%= goodsMap.get("goodsTitle") %>
				</td>
			</tr>
			
			<tr>
				<td>가격</td>
				<td>
					<input type="hidden" name="goodsPrice" value="<%= goodsMap.get("goodsPrice") %>">
					<%= goodsMap.get("goodsPrice") %>
				</td>
			</tr>
		
		
			<tr>
				<td>수량</td>
				<td><select id="quantity"name="quantity"><%for(int i=1; i<=10; i++) {%><option value="<%=i%>"><%=i %></option><%}%></select></td>
			</tr>
			
			<tr>
				<td>매진여부</td>
				<td>
					<span id="soldout"><%= goodsMap.get("soldout") %></span>
				</td>
			</tr>						
		
			</table>
			
			<br>
			
				<h3>상품소개</h3>
				
					<textarea readonly style="outline:none; border: none; resize: none; 
					font-size:50; width: 70%; height: 80em;"><%= goodsMap.get("goodsMemo") %></textarea>	
		</form>
	</div>


	<br>

	<jsp:include page="/inc/footer.jsp"></jsp:include>
<script>
	$(document).ready(function() {
		if(<%= goodsMap.get("soldout").equals("Y") %>){
			$('#orderBtn').attr("disabled", "true")
		}
	});

</script>
</body>
</html>