<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.sql.*" %>
   
<%
	String updateMsg1 = request.getParameter("updateMsg1");	
	String updateMsg2 = request.getParameter("updateMsg2");
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
%>


<!DOCTYPE html>
<html>
<head>
<style>
	.container{
	display:flex;
	justify-content:center;
	align-items:center;
	}
</style>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->

	<!-- customer가 null이 아닌 경우에만 속성에 접근 -->
    <% 
    	if (customer != null) { 
    %>    
    <form method="post" action="updateCustomerForm.jsp">
		<div class="container">
			<fieldset>
				<legend class="container">내정보</legend>
			<%
            	if(updateMsg2!=null) {
           	%>
           		<div><%=updateMsg2%></div>
           	<%
            	}
            
            %>
            
             <%
            	if(updateMsg1!=null) {
           	%>
           		<div><%=updateMsg1%></div>
           	<%
            	}
            
            %>
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
					<button type="submit">정보수정</button>	
					<button><a href="<%=request.getContextPath()%>/customer/deleteCustomerForm.jsp">회원탈퇴</a></button>				
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
















