<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %> 
<%
	
    CustomerDao customerDao = new CustomerDao();

    // customerId 사용
    String customerId = (String)(session.getAttribute("loginId"));

    // customerDao.customerOne 메서드에서 null을 반환하는 경우를 처리
    Customer customer = customerDao.customerOne(customerId);
    CustomerDetail customerDetail = null;
    CustomerAddr customerAddr = null;

    if (customer != null) {
        customerDetail = customer.getCustomerDetail();
        customerAddr = customer.getCustomerAddr();
    }
    
    
    String n4 = request.getParameter("n4");
	String n1 = request.getParameter("n1");
%>


<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>

	<!-- customer가 null이 아닌 경우에만 속성에 접근 -->
    <% 
    	if (customer != null) { 
    %>    
    <form method="post" action="updateCustomerForm.jsp">
		<div style="margin-left: 40%;">
			<fieldset>
			
      <% if(n4!=null) {%><div><%=n4%></div> <%} %>
      <% if(n1!=null) {%><div><%=n1%></div> <%} %>
				<legend class="container">내정보</legend>
             
					<table border="1" width="300" height="200">
						<tr>
							<th>ID</th>
							<td><%=customer.getCustomerId()%></td>				
						</tr> 
						
						<tr>
							<th>이름</th>
							<td><%=customerDetail.getCustomerName()%></td>	
						</tr>
						
						<tr>
							<th>주소</th>
							<td><%=customerAddr.getAddress()%></td>	
						</tr>
						
						<tr>
							<th>전화번호</th>
							<td><%=customerDetail.getCustomerPhone()%></td>	
						</tr>	
						
					</table>
						<br>
					<button type="submit" class="btn btn-outline-dark mt-auto">정보수정</button>	
					<a class="btn btn-outline-dark mt-auto" href="<%=request.getContextPath()%>/customer/deleteCustomerForm.jsp">회원탈퇴</a>			
			</fieldset>
		</div>
	</form>
	<%		
    	} 
     	else { %>
        <p>상단 메뉴에서 로그인 후 조회해주세요!</p>
        
    <% 
    	} 
    %>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>
















