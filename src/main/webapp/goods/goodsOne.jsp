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
<form action="orderOne" method="get">
	<div style="text-align: center;">
	
		<img  src="/mall/<%= goodsImg.getFileName() %>" alt="..." style="width: 20%">
		
		<br><br>
		
		<table class="table">
			<tr>
				<td>상품명</td>
				<td><%= goods.getGoodsTitle() %></td>
			</tr>
			
			<tr>
				<td>가격</td>
				<td><%= goods.getGoodsPrice() %></td>
			</tr>
		
		
			<tr>
				<td>수량</td>
				<td><select><%for(int i=1; i<=10; i++) {%><option><%=i %></option><%}%></select></td>
			</tr>
			
			<tr>
				<td>매진여부</td>
				<td><%= goods.getSoldout() %></td>
			</tr>
		
		<tr>
			<td></td>
			<td><button type="submit">바로구매</button></td>
		</tr>
		
		</table>
	</div>

</form>
</body>
</html>