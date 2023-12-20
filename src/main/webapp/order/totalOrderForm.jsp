<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
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
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
    <jsp:include page="/inc/menubar.jsp"></jsp:include>
	 <jsp:include page="/inc/header.jsp"></jsp:include>
	<!-- 메뉴 끝 -->
	<table class="table table-sm" style="text-align: center;"> 
        <tr>              	 		        	
            <th>상품이름</th>
            <th>상품단가</th>
            <th>선택수량</th>           
            <th>소계</th>             
        </tr>
 <tbody>
        <% for (Cart cart : cartList) { %>
       
            <tr> 
            <td><%= (cart.getGoods() != null) ? cart.getGoods().getGoodsTitle() : "" %></td>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getGoodsPrice() : "" %>원</td>
                <td><%= cart.getQuantity() %></td>
                <td><%= cart.getGoods().getGoodsPrice() * cart.getQuantity() %>원</td>                
            </tr>
       
        <% } %> 
         </tbody>
         <tr></tr>
         <tfoot>
         <tr>
         	<td></td><td></td><td></td>
         	<td colspan="2"><div>총 <%=payment%>원</div>
         	<a href="" class="btn btn-outline-dark mt-auto">결제</a></td>
         </tr>
         </tfoot>
        </table>
</body>
</html>