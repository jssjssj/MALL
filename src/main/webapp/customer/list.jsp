<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	CustomerDao customerDao = new CustomerDao();
	List<Map<String,Object>> list = customerDao.allCustomer();
 	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>allCustomerList</title>
</head>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
				<jsp:include page="/inc/menubar.jsp"></jsp:include>
				<jsp:include page="/inc/header.jsp"></jsp:include>
		<h2 style="text-align: center;">전체 고객정보</h2>
		    
		    <table class="table table-hover">
		        <tr>
		        	<th>고객 번호</th>
		            <th>고객 ID</th>
		            <th>고객 이름</th>
		            <th>고객 tel</th>
		            <th>고객 주소</th>
		            <th>계정 가입일</th>
		            <th>계정 수정일</th>
		            <th>활성화상태(Y/N)</th>
		        </tr>
		        
		        <% for (Map<String,Object> customer : list) { %>
		            <tr>
		            	<td><%= customer.get("customerNo") %></td>
		                       
		                <td><%= customer.get("customerId") %></td>
		                        
		                <td><%= customer.get("customerName") %></td>
		                        
		                <td><%= customer.get("customerPhone") %></td>
		                       
		                <td><%= customer.get("address") %></td>
		                        
		                <td><%= customer.get("createdate") %></td>
		                       
		                <td><%= ((customer.get("updatedate") == null) || (customer.get("updatedate").equals(customer.get("createdate")))) ? "-" : customer.get("updatedate") %></td>
		                       
		                <td><%= customer.get("active") %></td>
		            </tr>
		        <% } %>
		    </table>
				<!-- footer 시작 -->
				   <jsp:include page="/inc/footer.jsp"></jsp:include>
				<!-- footer 끝 -->	
</body>
</html>