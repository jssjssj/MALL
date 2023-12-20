<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	GoodsDao goodsDao = new GoodsDao();
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	Goods goods = goodsDao.selectGoodsOne(goodsNo);
	GoodsImg goodsImg = goodsDao.selectGoodsOneImg(goodsNo);
	System.out.println(goods + "<-- goods");
	System.out.println(goodsImg + "<-- goodsImg");
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    
	<br>
<form action="<%=request.getContextPath()%>/order/orderOne.jsp" method="get">
	<div style="text-align: center;">
		
		<img  src="/mall/<%= goodsImg.getFileName() %>" alt="..." style="width: 20%">
				<br>
				<br>
		<div>
			<a href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=<%=goods.getGoodsNo()%>&quantity=1""><button type="button">장바구니</button></a>			
			<button type="submit">바로구매</button>	
		</div>
		
		<br><br>
		
		<table class="table">
			<tr>
				<td>상품명</td>
				<td>
					<input type="hidden" name="goodsNo" value="<%= goods.getGoodsNo() %>">
					<input type="hidden" name="goodsTitle" value="<%= goods.getGoodsTitle() %>">
					<%= goods.getGoodsTitle() %>
				</td>
			</tr>
			
			<tr>
				<td>가격</td>
				<td>
					<input type="hidden" name="goodsPrice" value="<%= goods.getGoodsPrice() %>">
					<%= goods.getGoodsPrice() %>
				</td>
			</tr>
		
		
			<tr>
				<td>수량</td>
				<td><select name="quantity"><%for(int i=1; i<=10; i++) {%><option><%=i %></option><%}%></select></td>
			</tr>
			
			<tr>
				<td>매진여부</td>
				<td>
					<input type="hidden" name="soldout" value="<%= goods.getSoldout() %>">
					<%= goods.getSoldout() %>
				</td>
			</tr>						
		
			</table>
			
			<br>
			
				<div>상품소개</div>
				
					<textarea readonly style="outline:none; border: none; resize: none; 
					font-size:50; width: 70%; height: 100em;"><%= goods.getGoodsMemo() %></textarea>
				
			
		
		
	</div>

</form>
	<br>
	<br>
	<br>
	<br>
</body>
</html>