<%@page import="javax.swing.plaf.synth.SynthOptionPaneUI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.util.*" %>
<%
    // 매니저 로그인 여부 확인
    session = request.getSession();
    Manager loginManager = (Manager) session.getAttribute("loginManager");
	String customerId = (String)(session.getAttribute("loginId"));
	
	CustomerDao customerDao = new CustomerDao();


    // 인삿말 위한 customerName 불러오기
    Customer customer = customerDao.customerOne(customerId);
    CustomerDetail customerDetail = null;
    CustomerAddr customerAddr = null;

    if (customer != null) {
        customerDetail = customer.getCustomerDetail();
        customerAddr = customer.getCustomerAddr();
    }
    
    
    String t = request.getParameter("t"); // 회원탈퇴 시 탈퇴완료 메시지
    
    // 장바구니 옆 숫자 세팅
    CartDao cartDao = new CartDao();
    System.out.println(customerId + "<----customerId");
    int cnt = cartDao.countCart(customerId);
%>

<% if (loginManager == null) { 
	 %>           
<!-- 메뉴 네비게이션-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
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
           <%if(t!=null){%><div><%=t%><%}%> <!-- 회원탈퇴 시 탈퇴완료 메시지  -->
           <%
            if(customerId!=null) {
	       %>
           	   
	          <a href="<%=request.getContextPath()%>/order/orderView.jsp">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
            주문기록
            </button>
            </a>
            <a href="<%=request.getContextPath()%>/customer/logoutAction.jsp">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
            로그아웃
            </button>
            </a>
            <form class="d-flex" action="<%=request.getContextPath()%>/cart/cartList.jsp">
		     <a href="<%=request.getContextPath()%>/customer/customerOne.jsp">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
          마이페이지
            </button>
            </a>
            
            <button class="btn btn-outline-dark" type="submit"> 
		             <i class="bi-cart-fill me-1"></i>
		             장바구니
		             <span class="badge bg-dark text-white ms-1 rounded-pill"><%=cnt%></span> 
		         </button>
		         </form>
<%
	            }
%>       	</div>
        </div> 
    </div>
</nav>



<!--  매니저 메뉴  -->

<% } else { %>
<!-- 메뉴 네비게이션-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="http://localhost/mall/110011/loginForm.jsp">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="<%=request.getContextPath()%>/manager/dashboard.jsp">Home</a></li>                
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/goods/goodsList.jsp">상품 관리</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/question/questionList.jsp">문의내용 확인</a></li>                        
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp">공지 작성</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지 확인</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/customer/allCustomerList.jsp">고객 관리</a></li>
            </ul>

            <div class="nav-link"><%=loginManager.getManagerName()%>님 반갑습니다.</div>
            <a href="<%=request.getContextPath()%>/customer/logoutAction.jsp">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
            로그아웃
            </button>
            </a>
             <a href="<%=request.getContextPath()%>/manager/managerOne.jsp?manager_no=<%=loginManager.getManagerNo()%>">
            <button type="button" class="btn btn-link" data-mdb-ripple-color="dark">
          마이페이지
            </button>
            </a>
        </div> 
    </div>
</nav>
<% } %>