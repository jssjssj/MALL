<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
    
<%
    // 대시보드 페이지에서 매니저 로그인 여부 확인
    session = request.getSession();
    Manager loginManager = (Manager) session.getAttribute("loginManager");
    System.out.println(loginManager);
    // 매니저가 로그인되어 있지 않으면 로그인 페이지로 리다이렉트
    if (loginManager == null) {
        response.sendRedirect(request.getContextPath() + "/manager/managerLoginForm.jsp");
    }
    
 	
    
    
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
    <p>현재 주문량: <%= dashboardInfo.getOrderCount() %>건</p>
	<p>신규 가입 고객 수: <%= dashboardInfo.getNewCustomers() %>명</p>
    
    <!-- 필요한 정보에 따라 추가 -->
    <!-- 대시보드 페이지의 내용 추가 --> 
<!-- footer 시작 -->
<jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html>