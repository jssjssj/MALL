<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
    String customerId = (String) session.getAttribute("loginId");
    CartDao cartDao = new CartDao();
    List<Cart> cartList = new ArrayList<>();
    
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
    <h2>장바구니</h2>
<form action = "<%=request.getContextPath()%>/cart/deleteCartAction.jsp">
    <table border="1"> 
        <tr>      
        	<th>	</th> 
        	<th>  삭제  </th>  	       		        	
            <th>상품이름</th>
            <th>상품단가</th>
            <th>선택수량</th>
            <th>품절여부</th>
            <th>사진</th> 
            <th>소계</th> 
            <th>수량변경</th> 
            
        </tr>
</table>
        <% for (Cart cart : cartList) { %>
         <table border="1"> 
            <tr>        
            	<td><input type="hidden" readonly="readonly" value="<%= cart.getCartNo() %>" name="cartNo"></td>       	                
                <td><a href="<%=request.getContextPath()%>/cart/deleteCartAction.jsp">X</a></td>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getGoodsTitle() : "" %></td>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getGoodsPrice() : "" %></td>
                <td><%= cart.getQuantity() %></td>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getSoldout() : "" %></td>
                <td><%= (cart.getGoodsImg() != null) ? cart.getGoodsImg().getFileName() : "" %></td>
                <td><%= cart.getGoods().getGoodsPrice() * cart.getQuantity() %></td>
                <td><select class = "quantity" name = "quantity">              
                		<%for(int i=1; i<=10; i++) { %><option><%=i%></option>
                		 <% } %>
                </select></td>                
            </tr>
        </table>
        <% } %> 
</form>
    <!-- footer 시작 -->
    <jsp:include page="/inc/footer.jsp"></jsp:include>
</body>
</html>






























