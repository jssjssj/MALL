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
	List<Orders> ordersList = new ArrayList<>();
	
	OrdersDao ordersDao = new OrdersDao();
	
	ordersList = ordersDao.select(customerId);
	
	System.out.println(orderses);
	System.out.println(customerId);
	
	Orders oreders = new Oreders();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>주문화면</h3>
<form method="post" action = "<%=request.getContextPath()%>/order.endOrder.jsp">
	<table border="1">
	<%
		for(ordersList : orders) { 
	%>
		<tr> 
			<td>주문총액</td>
			<td><%=orderses.getQuantity()%></td>
		</tr>
		
		<tr>
			<td>배송주소</td>
			<td></td>
		</tr>
		
		<tr>
			<td><button type="submit">결제하기</button></td>
		</tr>
		
	</table>	
</form>
</body>
</html>