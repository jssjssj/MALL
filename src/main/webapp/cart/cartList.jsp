<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="vo.* , dao.*"%>

<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<%
	
	String customerId = (String)(session.getAttribute("loginId"));
	CartDao cartDao = new CartDao();
	List<Cart> carts = new ArrayList<>();
	if(customerId==null){
		response.sendRedirect(request.getContextPath()+"/customer/customerLoginForm.jsp");
	}
	
	Goods goods = null;
	GoodsImg goodsImg = null;
	Customer customer = null;
	carts = cartDao.selectCart(customerId);
	Cart cart  =new Cart();
	
	if(cart!=null){
		goods = cart.getGoods();
		goodsImg = cart.getGoodsImg();
		customer = cart.getCustomer();

	}
	
	
	
	 
 %>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<h2>장바구니</h2>
	<table border = "1">
		<tr>
			<th>상품이름</th> 
			<th>상품단가</th>
			<th>선택수량</th>
			<th>품절여부</th>
			<th> 사진 </th>
			<th>상품소계</th>
		</tr>
		
		<tr>
			<td><%=cart.getGoods().getGoodsTitle()%></td>
			<td><%=cart.getGoods().getGoodsPrice()%></td>
			<td><%=cart.getQuantity()%></td>
			<td><%=cart.getGoods().getSoldout()%></td>
			<td><%=cart.getGoodsImg().getFileName()%></td>
			<td><%=cart.getMidPrice()%></td>			
		</tr>
		
		<tr>
			<th>총계</th>
			<td></td>
		</tr>
	</table>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html>