<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	CartDao cartDao = new CartDao();
	List<Map<String, Object>> resultList = cartDao.cartList(loginCustomer);

%>

<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
    <jsp:include page="/inc/menubar.jsp"></jsp:include>
	 <jsp:include page="/inc/header.jsp"></jsp:include>
	<!-- 메뉴 끝 -->

		<h3 style="text-align: center;">상품은 각 10개까지 담을 수 있습니다.</h3>
	<table class="table table-hover">
		<thead>
			<tr>
				<th></th>
				<th>상품명</th>
				<th>선택수량</th>
				<th>소계</th>
				<th></th>
			</tr>
		</thead>
	<% for(Map<String, Object> cart : resultList) { %>
		<tbody>
			<tr>
				<td>
					<a href="<%= request.getContextPath() %>/cart/deleteAction.jsp?cartNo=<%=cart.get("cartNo")%>">
						X
					</a>
				</td>
				<td><%= cart.get("goodsTitle") %><input type="hidden" name="goodsNo" value="<%= cart.get("goodsNo") %>"/></td>
				<td><% if((int)cart.get("quantity") < 10 ){ %>
				<a href="<%= request.getContextPath()%>/cart/plusUpdateAction.jsp?cartNo=<%= cart.get("cartNo") %>">+</a>
				<% } %>
					&nbsp;<%= cart.get("quantity") %>&nbsp;
				<% if((int)cart.get("quantity") > 1 ){ %>				
				<a href="<%= request.getContextPath()%>/cart/minusUpdateAction.jsp?cartNo=<%= cart.get("cartNo") %>">-</a>
				<% } %><input type="hidden" name="quantity" value="<%= cart.get("quantity") %>"/></td>
				<td>
					<%= (int)cart.get("goodsPrice")*(int)cart.get("quantity") %>
					<input type="hidden" name="totalPrice" value="<%= (int)cart.get("goodsPrice")*(int)cart.get("quantity") %>"/>
				</td>
				<td><%= cart.get("soldout").equals("Y") ? "품절" : "" %></td>
			</tr>
		</tbody>
	<% } %>
	</table>
			<button style="margin-left: 85%" class="btn btn-success" id="orderBtn" type="button">주문하기</button>

	<br>

    <!-- footer 시작 -->
    <jsp:include page="/inc/footer.jsp"></jsp:include>
    
<script>
	$('#orderBtn').click(function(){
		alert('기능 준비 중');
	});


</script>
</body>
</html>


