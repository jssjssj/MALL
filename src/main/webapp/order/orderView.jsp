<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	if(session.getAttribute("loginCustomer")==null){
		response.sendRedirect(request.getContextPath() + "/public/loginForm.jsp") ;
		return;
	}
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	
	OrdersDao ordersDao = new OrdersDao();
	List<Map<String, Object>> orderList = ordersDao.select(loginCustomer);
	System.out.println(!orderList.isEmpty() ? "주문내역 출력 완" : "주문내역 없음");
	
	
	Manager loginManager = null;
	if(session.getAttribute("loginManager") != null){
		loginManager = (Manager)session.getAttribute("loginManager");
	}
%>

<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    
<div class="alert alert-warning" style="text-align: center;">
  <p>주문상태는 '주문완료', '배송출발', '배송완료' 로 구분되며 
  주문내역 삭제는 배송이 완료된 상태에서만 가능합니다.</p>
</div>

	<table class="table table-sm">
		<thead>
			<tr>
				<th>No</th>
				<th>상품명</th>
				<th>배송주소</th>
				<th>단가</th>
				<th>주문수량</th>
				<th>주문상태</th>
				<th>주문일자</th>
				<th>배송출발</th>
				<th>총 결제가격</th>	
				<th>내역삭제</th>	
			</tr>
		</thead>

		<%
		for (Map<String, Object> list : orderList) {
		%>
		<tbody>
			<tr>
				<td><%=list.get("ordersNo")%></td>
				<td><%=list.get("goodsTitle")%></td>
				<td><%=list.get("address")%></td>
				<td><%=list.get("goodsPrice")%></td>
				<td><%=list.get("quantity")%></td>
				<td><%=list.get("ordersState")%></td>
				<td><%=list.get("createdate")%></td>
				<td><%=list.get("updatedate").equals(list.get("createdate"))  ? "-" : list.get("updatedate")%></td>
				<td><%=list.get("totalPrice")%></td>
				<td>
					<% if(list.get("ordersState").equals("배송완료")) { %>
					<a href="<%= request.getContextPath() %>/order/deleteOrdersAction.jsp?ordersNo=<%=list.get("ordersNo")%>"
									class="btn btn-outline-success">X</a>
					<% } else {%>
						<button type="button" class="btn btn-outline-default" disabled="disabled">X</button>
					<% } %>
				</td>
			</tr>
		</tbody>
		<%
		}
		%>
	</table>



	<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->

</body>
</html>