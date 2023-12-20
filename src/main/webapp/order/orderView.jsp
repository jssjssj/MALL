<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.* , dao.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%
	String customerId = (String)(session.getAttribute("loginId"));
	if(customerId==null) {
		response.sendRedirect(request.getContextPath()+"/customer/customerLoginForm.jsp");
	}
	Orders oreders = new Orders();
	List<Orders> ordersList = new ArrayList<>();
	
	OrdersDao ordersDao = new OrdersDao();
	
	ordersList = ordersDao.select(customerId);
	
	
%>
<!DOCTYPE html>
<html>
<style>
table, td, th {
  border : 1px solid black;
  border-collapse : collapse;
}
table {
  width : 1000px;
  height : 50px;
}
th, td {
  text-align: center;
}
</style>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<head>
<meta charset="UTF-8">
<title>orderView</title>
</head>
<body>
				<jsp:include page="/inc/menubar.jsp"></jsp:include>
			    <jsp:include page="/inc/header.jsp"></jsp:include>
		
	<h2 style="text-align: center;">주문화면</h2>
			<table border="1" class="table">
			<thead>
					<tr>
						<td>	</td>
						<td>주문번호</td>
						<td>상품명</td>
						<td>주문수량</td>
						<td>상품소계</td>
						<td>배송진행여부</td>
						<td>배송주소</td>
					</tr>
			</thead>
			<tbody>
	<%
		for(Orders o : ordersList) {
	%>
			
					<tr>
						<td>
							<a href="<%=request.getContextPath()%>/order/deleteOrdersAction.jsp?ordersNo=<%=o.getOrdersNo()%>">
								X
							</a>
						</td>
						
						<td>		<%=o.getOrdersNo()%>			 </td>
						<td>		<%=o.getGoods().getGoodsTitle()%></td>
						<td>		<%=o.getQuantity()%>			 </td>
						<td>		<%=o.getTotalPrice()%>			 </td>
						<td>		<%=o.getOrdersState()%>			 </td>
						<td>	<%=o.getCustomerAddr().getAddress()%></td>
					</tr>
			
	<%		
		 }
	%>	
		</tbody></table>

<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html>