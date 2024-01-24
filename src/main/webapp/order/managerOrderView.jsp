<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Manager loginManager = null;
	
	if(session.getAttribute("loginCustomer")!=null){
		response.sendRedirect(request.getContextPath() + "/public/home.jsp") ;
		return;
	} else if(session.getAttribute("loginManager")==null){
		response.sendRedirect(request.getContextPath() + "/public/loginForm.jsp") ;
		return;
	} else if(session.getAttribute("loginManager")!=null){
		loginManager = (Manager)session.getAttribute("loginManager");
	}


	OrdersDao ordersDao = new OrdersDao();
	List<Orders> orderList = ordersDao.totalOrder();
	
	
	 // 대시보드 정보 가져오기
    DashboardInfoDao dashboardInfoDao = new DashboardInfoDao();
    DashboardInfo dashboardInfo = dashboardInfoDao.getDashboardInfo();
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
    
    <p>안녕하세요, <%= loginManager.getManagerName() %>님!</p>
    <p>누적 주문량: <%= dashboardInfo.getOrderCount() %>건</p>
	<p>신규 가입 고객 수: <%= dashboardInfo.getNewCustomers() %>명</p>

	<table class="table">
		<thead>
			<tr>
				<th>주문번호</th>
				<th>상품번호</th>
				<th>고객번호</th>
				<th>배송지 번호</th>
				<th>주문수량</th>
				<th>총 결제금액</th>
				<th>주문상태 변경</th>
				<th>최초 주문일</th>
				<th>배송 시작일</th>
			</tr>
		</thead>

		<% for(Orders list : orderList) { %>
		<tbody>
			<tr>
				<td><%= list.getOrdersNo() %></td>
				<td><%= list.getGoodsNo() %></td>
				<td><%= list.getCustomerNo() %></td>
				<td><%= list.getCustomerAddrNo() %></td>
				<td><%= list.getQuantity() %></td>
				<td><%= list.getTotalPrice() %></td>
				<td><%= list.getOrdersState() %> -> 
					<a href="<%= request.getContextPath() %>/order/managerUpdateOrderAction.jsp?ordersNo=<%= list.getOrdersNo() %>&ordersState=<%= list.getOrdersState() %>">
						<%= list.getOrdersState().equals("주문완료") ? "배송출발" : "배송완료" %>
					</a>
				</td>
				<td><%= list.getCreatedate() %></td>
				<td><%= list.getUpdatedate().equals(list.getCreatedate()) ? "-" : list.getUpdatedate() %></td>
			</tr>
		</tbody>
		<% } %>
	</table>


	<jsp:include page="/inc/footer.jsp"></jsp:include>
</body>
</html>