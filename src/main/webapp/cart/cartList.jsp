<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
    String customerId = (String) session.getAttribute("loginId");
    CartDao cartDao = new CartDao();
    List<Cart> cartList = new ArrayList<>();
 
    OrdersDao ordersDao = new OrdersDao();
    int payment = ordersDao.selectTotalPayment(customerId);
    
    if (customerId == null) {
        response.sendRedirect(request.getContextPath() + "/customer/customerLoginForm.jsp");
    } else {
        cartList = cartDao.selectCart(customerId);
       
    }
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
<body>
    <jsp:include page="/inc/menubar.jsp"></jsp:include>
	 <jsp:include page="/inc/header.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	
	<br>
	
    <h2 style="text-align: center;">장바구니</h2>
    
    <br>

	<div style="text-align: center;">

		<a class="btn btn-outline-dark mt-auto"
			href="<%=request.getContextPath()%>/order/totalOrderForm.jsp"> 전체 주문</a>
			<div>총 <%=payment%>원</div>
	</div>
	<br>
	
<form action = "<%=request.getContextPath()%>/cart/deleteCartAction.jsp">
    <table border="1" class="table" style="text-align: center;"> 
        <tr>      
        	
        	<th>삭제</th>  	       		        	
            <th>상품이름</th>
            <th>상품단가</th>
            <th>선택수량</th>
            <th>품절여부</th>
            <th>소계</th> 
            <th>수량변경</th> 
            
        </tr>
 <tbody>
        <% for (Cart cart : cartList) { %>
       
            <tr>        
            	    	                
                <td><a href="<%=request.getContextPath()%>/cart/deleteCartAction.jsp?cartNo=<%= cart.getCartNo() %>">X</a></td>
                <td><a href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=<%=cart.getGoods().getGoodsNo()%>"><%= (cart.getGoods() != null) ? cart.getGoods().getGoodsTitle() : "" %></a></td>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getGoodsPrice() : "" %></td>
                <td><%= cart.getQuantity() %></td>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getSoldout() : "" %></td>
                <td><%= cart.getGoods().getGoodsPrice() * cart.getQuantity() %></td>
                <td>
                	<a href="<%=request.getContextPath()%>/cart/plusUpdateCartAction.jsp?cartNo=<%=cart.getCartNo()%>&quantity=<%=cart.getQuantity()%>" class="btn btn-outline-dark mt-auto">+</a>
                	<%if(cart.getQuantity() > 1){ %>
                		<a href="<%=request.getContextPath()%>/cart/minusUpdateCartAction.jsp?cartNo=<%=cart.getCartNo()%>" class="btn btn-outline-dark mt-auto">-</a>
                	<%}%>
                </td>                
            </tr>
       
        <% } %> 
         </tbody>
        </table>
</form>
    <!-- footer 시작 -->
    <jsp:include page="/inc/footer.jsp"></jsp:include>
</body>
</html>


