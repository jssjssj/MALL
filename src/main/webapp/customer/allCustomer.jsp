<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*"%>
<%request.setCharacterEncoding("UTF-8"); %>

<% 
	CustomerDao customerDao = new CustomerDao();
	List<Customer> customers = new ArrayList<>();
	customers = customerDao.selectCustomer();
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
		<h2>전체 고객정보</h2>
		    
		    <table border="1">
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
		        
		        <% for (Customer customer : customers) { %>
		            <tr>
		            	<td><%= customer.getCustomerNo() %></td>
		            
		                <td><%= customer.getCustomerId() %></td>
		                
		                <td><%= customer.getCustomerDetail() != null ? customer.getCustomerDetail().getCustomerName() : " " %></td>
		                
		                <td><%= customer.getCustomerDetail() != null ? customer.getCustomerDetail().getCustomerPhone() : " " %></td>
		                
		                <td><%= customer.getCustomerAddr() != null ?  customer.getCustomerAddr().getAddress() : " "%></td>
		                
		                <td><%= customer.getCreatedate() %></td>
		                
		                <td><%= customer.getUpdatedate() %></td>
		                
		                <td><%= customer.getActive() %></td>
		            </tr>
		        <% } %>
		    </table>
				<!-- footer 시작 -->
				   <jsp:include page="/inc/footer.jsp"></jsp:include>
				<!-- footer 끝 -->	
</body>
</html>