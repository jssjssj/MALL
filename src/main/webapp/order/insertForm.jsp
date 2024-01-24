<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	int customerAddrNo = loginCustomer.getCustomerAddrNo();
	
	String goodsTitle = request.getParameter("goodsTitle");
	String address = loginCustomer.getAddress();
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));	
	int totalPrice = quantity*goodsPrice;
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
%>

<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    
    <form action="<%= request.getContextPath() %>/order/insertAction.jsp" method="post"
    								id="orderAct">
    	<table class="table">
    		<tr>
    			<td>상품명</td>
    			<td><input type="hidden" name="goodsNo" value="<%= goodsNo %>"/><%= goodsTitle %></td>
    		</tr>
    		
    		<tr>
    			<td>주문수량</td>
    			<td><input type="hidden" name="quantity" value="<%= quantity %>"/><%= quantity %></td>
    		</tr>
    		
    		<tr>
    			<td>배송주소</td>
    			<td><input type="hidden" name="customerAddrNo" value="<%= customerAddrNo %>"/><%= address %></td>
    		</tr>
    		
    		<tr>
    			<td>결제 예정가격</td>
    			<td><input type="hidden" name="totalPrice" value="<%= quantity * goodsPrice %>"/><%= quantity * goodsPrice %>원</td>
    		</tr>
    	</table>
    	
    		<button id="orderBtn" type="button" class="btn btn-success">주문(결제)</button>
    </form>
    
    <jsp:include page="/inc/footer.jsp"></jsp:include>
    
<script>
	$('#orderBtn').click(function() {
		if(confirm('결제 후에는 주문내용을 수정할 수 없습니다. 결제하시겠습니까?')){
			$('#orderAct').submit();
		}
	});

</script>
</body>
</html>