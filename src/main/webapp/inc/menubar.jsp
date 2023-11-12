<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String customerId = (String)(session.getAttribute("loginId"));
	String msg2 = request.getParameter("msg2");
%>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="<%=request.getContextPath()%>/110011/assets/favicon.ico" />
	<!-- Bootstrap icons-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
	<!-- Core theme CSS (includes Bootstrap)-->
	<link href="<%=request.getContextPath()%>/css/styles.css" rel="stylesheet" />    
<!-- 메뉴 네비게이션-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="#!">Start Bootstrap</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="http://localhost/mall/110011/loginForm.jsp">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/110011/index.jsp">Home</a></li>
                
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customer/customerLoginForm.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/goods/goodsList.jsp">상품보기</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/question/questionList.jsp">문의하기</a></li>                        
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지사항</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/manager/managerLoginForm.jsp">관리자페이지</a></li> 
            </ul>
            <% 
            	if(msg2!=null) {
            %>
            	<div><%=msg2%></div>
            <%		
            	}
            %>
            
            <%
	            if(customerId!=null) {
	        %>	        
            <div class="nav-link"><%=customerId%>님 반갑습니다.</div>
            <a href="<%=request.getContextPath()%>/customer/logoutAction.jsp">로그아웃</a>
            <%    	
	            }
            %>
		     <form class="d-flex" action="<%=request.getContextPath()%>/cart/cartList.jsp">
		     <a href="<%=request.getContextPath()%>/customer/customerOne.jsp">
		     마이페이지
		     </a>
		         <button class="btn btn-outline-dark" type="submit"> 
		             <i class="bi-cart-fill me-1"></i>
		             장바구니
		             <span class="badge bg-dark text-white ms-1 rounded-pill">0</span> 
		         </button>
		     </form>
        </div> 
    </div>
</nav>

<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Shop in style</h1>
            <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
        </div>
    </div>
</header> 