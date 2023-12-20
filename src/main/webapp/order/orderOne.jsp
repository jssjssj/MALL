<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*,dao.*" %>
<%
	String customerId = (String)session.getAttribute("loginId");
	String goodsTitle = request.getParameter("goodsTitle");
	  int goodsPrice  = Integer.parseInt(request.getParameter("goodsPrice"));
	  int quantity    = Integer.parseInt(request.getParameter("quantity"));
	String  soldout   = request.getParameter("soldout");
	  int goodsNo	  = Integer.parseInt(request.getParameter("goodsNo"));
	
	if(soldout.equals("Y")){
		response.sendRedirect(request.getContextPath()+"/goods/goodsOne.jsp?goodsNo="+goodsNo);
	}
	CustomerDao customerDao = new CustomerDao();
	Customer customer = customerDao.customerOne(customerId);
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    
    <form method="post" action="<%=request.getContextPath()%>/order/insertOrderAction.jsp">
    		<div style="text-align: center;">
	<table class="table">
		<tr>
			<td>주문상품</td>
			<td>
				<input type="hidden" name="goodsNo" value="<%=goodsNo %>">
				<input type="hidden" name="goodsTitle" value="<%=goodsTitle %>">
				<%= goodsTitle%></td>
		</tr>
		
		<tr>
			<td>주문수량</td>
			<td>
				<input type="hidden" name="quantity" value="<%=quantity %>">
				<%= quantity%>
			</td>
		</tr>
		
		<tr>
			<td>배송지 입력</td>
			<td>
				<input type="hidden" name="address" value="<%=customer.getCustomerAddr().getAddress()%>">
				<%=customer.getCustomerAddr().getAddress()%>
			</td>
		</tr>
		
		<tr>
			<td>결제 예정금액</td>
			<td>
				<input type="hidden" name="totalPrice" value="<%=quantity * goodsPrice %>">
				<%= quantity * goodsPrice%>
			</td>
		</tr>	
		
		<tr>
			<td></td>
			<td><button type="submit">결제하기</button></td>
		</tr>		
	</table>
			</div>
	</form>
</body>
</html>