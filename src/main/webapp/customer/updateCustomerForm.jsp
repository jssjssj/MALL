<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.net.URLEncoder" %> 
<%@ page import="java.util.*" %> 
<%
	
	
    // 세션에서 고객 ID 가져오기
    String customerId = (String)(session.getAttribute("loginId"));
	
	String n2 = request.getParameter("n2");
	String n3 = request.getParameter("n3");
	String n1 = request.getParameter("n1");
    // CustomerDao 인스턴스 생성
    CustomerDao customerDao = new CustomerDao();
	Customer customer = customerDao.customerOne(customerId);
	
	
	// 이전 비밀번호 재사용불가 기능ㅜ
	CustomerPwHistory customerPwHistory = new CustomerPwHistory();
	CustomerPwHistoryDao customerPwHistoryDao = new CustomerPwHistoryDao();
	List<CustomerPwHistory> cph = new ArrayList<>();
	cph = customerPwHistoryDao.select(customerId);
	if(customerId==null){
		response.sendRedirect(request.getContextPath()+"/customer/customerLoginForm.jsp");
	}
%>
<html>
<style>
table, td, th {
  border : 1px solid black;
  border-collapse : collapse;
}

th, td {
  text-align: center;
}


</style>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
<form method="post" action="updateCustomerAction.jsp">
    <div class="container">
        <fieldset>
            <legend>정보수정</legend>
      
      <%if(n2!=null){%><div><%=n2%></div><%}%>
      <%if(n3!=null){%><div><%=n3%></div><%}%>
      <%if(n1!=null){%><div><%=n1%></div><%}%>
      <%-- <% 
      		for (CustomerPwHistory c : cph) {
      %>
      		<input type="text" value="<%=c.getCustomerPw()%>" id="pwHis">
      		
      <%
      		}
      %> --%>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <td><input type="text" name = "customerId" readonly="readonly" value="<%=customerId%>"></td>
                </tr>
                
                <tr>
                    <th>현재PW</th>
                    <td><input type="password" name="customerPw"></td>
                </tr>
                
                
				<tr>
                    <th>변경PW</th>
                    <td><input type="password" name="newPw" id="newPw"></td>
                </tr>
                
                
                <tr>
                    <th>변경PW확인</th>
                    <td><input type="password" name="ghkrdls"></td>
                </tr>
                

                <tr>
                    <th>이름</th>
                    <td><input type="text" name="customerName" value="<%= (customer != null && customer.getCustomerDetail() != null) ? customer.getCustomerDetail().getCustomerName() : "" %>"></td>
                </tr> 

                <tr>
                    <th>주소</th>
                    <td><input type="text" name="address" value="<%= (customer != null && customer.getCustomerAddr() != null) ? customer.getCustomerAddr().getAddress() : "" %>"></td>
                </tr>

                <tr>
                    <th>전화번호</th>
                    <td><input type="text" name="customerPhone" value="<%= (customer != null && customer.getCustomerDetail() != null) ? customer.getCustomerDetail().getCustomerPhone() : "" %>"></td>
                </tr>
            </table>
            <button type="submit">저장하기</button>
        </fieldset>
    </div>
</form>
<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
<script>
 $('#pwHis')
 $('#newPw').keyup(function(){
	 
 });
</script>
</body>
</html>