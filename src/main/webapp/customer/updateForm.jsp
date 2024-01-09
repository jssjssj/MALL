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
	
	// 페이지 접속 시 로그인 필요
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
<form method="post" action="updateCustomerAction.jsp" id="updateBtn">
    <div class="container">
        <fieldset>
            <legend>정보수정</legend>
      <h6>pw:4글자 이상 이름:2글자 이상 , 주소:2글자 이상 , 번호:2글자 이상으로 작성필요</h6>
      <%if(n2!=null){%><div><%=n2%></div><%}%>
      <%if(n3!=null){%><div><%=n3%></div><%}%>
      <%if(n1!=null){%><div><%=n1%></div><%}%>
      <%for (CustomerPwHistory c : cph){%><input type="hidden" value="<%=c.getCustomerPw()%>" id="pwHis"><%}%>
            <table border="1">
                <tr>
                    <th>ID</th>
                    <td><input type="text" name = "customerId" readonly="readonly" value="<%=customerId%>"></td>
                </tr>
                
                <tr>
                    <th>현재PW</th>
                    <td><input type="password" name="customerPw" id="customerPw"></td>
                </tr>                
                
				<tr>
                    <th>변경PW</th>
                    <td><input type="password" name="newPw" id="newPw"></td>
                    <td><span id="newPwMsg"></span></td>                    
                </tr>                
                
                <tr>
                    <th>변경PW확인</th>
                    <td><input type="password" name="ghkrdls" id="ghkrdls"></td>
                    <td><span id="ghkrdlsMsg"></span></td>
                </tr>                

                <tr>
                    <th>이름</th>
                    <td><input type="text" name="customerName" id="customerName" value="<%= (customer != null && customer.getCustomerDetail() != null) ? customer.getCustomerDetail().getCustomerName() : "" %>"></td>
                	<td><span id="nameMsg"></span></td>
                </tr> 

                <tr>
                    <th>주소</th>
                    <td><input type="text" name="address" id="address" value="<%= (customer != null && customer.getCustomerAddr() != null) ? customer.getCustomerAddr().getAddress() : "" %>"></td>
                	<td><span id="addressMsg"></span></td>
                </tr>

                <tr>
                    <th>전화번호</th>
                    <td><input type="text" name="customerPhone" id="customerPhone" value="<%= (customer != null && customer.getCustomerDetail() != null) ? customer.getCustomerDetail().getCustomerPhone() : "" %>"></td>
                	<td><span id="phoneMsg"></span></td>
                </tr>
                
            </table>
       			<br>
            <button type="button" id="actionBtn" class="btn btn-outline-dark mt-auto">저장하기</button>
        </fieldset>
    </div>
</form>
<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
<script>
 $('#newPw').keyup(function(){
	 if($('#newPw').val() == $('#pwHis').val()){
		 $('#newPwMsg').text('이전에 사용한 PW 재사용불가')
	 } else if($('#newPw').val().length<4){
		 $('#newPwMsg').text('PW는 4자 이상입니다')
	 } else {
		 $('#newPwMsg').text('')
	 }
 });
 
 $('#ghkrdls').keyup(function(){
	 if($('#newPw').val() != $('#ghkrdls').val()){
		 $('#ghkrdlsMsg').text('입력하신 PW와 일치하지 않습니다!')
	 } else {
		 $('#ghkrdlsMsg').text('입력하신 PW와 일치합니다!')
	 }		 
 });
 
 $('#newPw').keyup(function(){
	 if($('#newPw').val() != $('#ghkrdls').val()){
		 $('#ghkrdlsMsg').text('입력하신 PW와 일치하지 않습니다!')
	 } else {
		 $('#ghkrdlsMsg').text('입력하신 PW와 일치합니다!')
	 }		 
 });
 
 $('#customerName').keyup(function(){
	 if($('#customerName').val().length<2){
		 $('#nameMsg').text('이름은 2자 이상입니다')
	 } else {
		 $('#nameMsg').text('')
	 }
 });
 
 $('#address').keyup(function(){
	 if($('#address').val().length<2){
		 $('#addressMsg').text('주소는 2자 이상입니다')
	 } else {
		 $('#addressMsg').text('')
	 }
 });
 
 $('#customerPhone').keyup(function(){
	 if($('#customerPhone').val().length<10){
		 $('#phoneMsg').text('전화번호는 10자 이상입니다')
	 } else {
		 $('#phoneMsg').text('')
	 }
 });
  
 $('#actionBtn').click(function(){
	 if($('#newPw').val() != $('#pwHis').val()&&
			 $('#newPw').val().length>=4 &&
			 $('#newPw').val() == $('#ghkrdls').val() && 
			 $('#customerName').val().length>=2 &&
			 $('#address').val().length>=2 &&
			 $('#customerPhone').val().length>=10) {
		 $('#updateBtn').submit();
	 } else {
		 alert('정보수정 필수사항을 확인해주세요');
		 return;
	 }
 });
 
</script>
</body>
</html>