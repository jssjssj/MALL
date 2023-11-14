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
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
    <jsp:include page="/inc/menubar.jsp"></jsp:include>

    <h2>장바구니</h2>
    <table border="1"> 
        <tr>
            <th>상품이름</th>
            <th>상품단가</th>
            <th>선택수량</th>
            <th>품절여부</th>
            <th>사진</th> 
        </tr>

        <% for (Cart cart : cartList) { %>
            <tr>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getGoodsTitle() : "" %></td>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getGoodsPrice() : "" %></td>
                <td><%= cart.getQuantity() %></td>
                <td><%= (cart.getGoods() != null) ? cart.getGoods().getSoldout() : "" %></td>
                <td><%= (cart.getGoodsImg() != null) ? cart.getGoodsImg().getFileName() : "" %></td>
            </tr>
        <% } %> 
    </table>

    <!-- footer 시작 -->
    <jsp:include page="/inc/footer.jsp"></jsp:include>
    <!-- footer 끝 -->
</body>
</html>