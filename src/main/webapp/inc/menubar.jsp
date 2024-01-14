<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.* "%>
<%
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
	Manager loginManager = (Manager)session.getAttribute("loginManager");
%> 
<% 
	if (loginManager == null) {
%>           
<!-- 메뉴 네비게이션-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="http://localhost/mall/public/loginForm.jsp">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>/public/home.jsp">Home</a></li>
                <% if(loginCustomer == null) {%>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/public/loginForm.jsp">로그인</a></li>
                <% } else {%>
                 <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/public/logoutAction.jsp">로그아웃</a></li>
                 <% } %>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/goods/list.jsp">상품보기</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/question/list.jsp">문의하기</a></li>                        
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/notice/list.jsp">공지사항</a></li>
            </ul>
          
           	  <% if(loginCustomer != null) {%> 
	          <a href="<%= request.getContextPath() %>/order/orderView.jsp">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
            주문기록
            </button>
            </a>
           
           
		     <a href="<%= request.getContextPath() %>/customer/customerOne.jsp">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
          마이페이지
            </button>
            </a>
            
            <a href="<%= request.getContextPath() %>/cart/list.jsp" class="btn btn-outline-dark" type="submit"> 
		             <i class="bi-cart-fill me-1"></i>
		             장바구니
		             <span class="badge bg-dark text-white ms-1 rounded-pill"></span> 
		         </a>
		     <% } %>    
       	</div>
        </div>    
</nav>


<%	 } else { %> 



<!--  매니저 메뉴  -->

 

<!-- 메뉴 네비게이션-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="http://localhost/mall/public/loginForm.jsp">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>/manager/dashboard.jsp">Home</a></li>                
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/goods/list.jsp">상품 관리</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/question/list.jsp">문의내용 확인</a></li>        
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/notice/list.jsp">공지 확인</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/customer/list.jsp">고객 관리</a></li>
            </ul>

            <div class="nav-link"><%= loginManager.getManagerName() %>님 반갑습니다.</div>
            <a href="<%= request.getContextPath() %>/public/logoutAction.jsp">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
            로그아웃
            </button>
            </a>
             <a href="<%= request.getContextPath() %>/manager/managerOne.jsp">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
          마이페이지
            </button>
            </a>
        </div> 
    </div>
</nav>
<% } %>