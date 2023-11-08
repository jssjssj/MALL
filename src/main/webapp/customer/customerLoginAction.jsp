<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="util.*"%>
<%
	// 로그인
	
	// cotroller
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	
	// model 코드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		

	String sql = "SELECT customer_id FROM customer WHERE customer_id=? AND customer_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerId);
	stmt.setString(2, customerPw);
	ResultSet rs = stmt.executeQuery();
	if(rs.next()) { // 로그인 성공
		
		System.out.println("로그인 성공");
		session.setAttribute("loginId", customerId);
		response.sendRedirect("http://localhost/mall/110011/index.jsp");
	} else { // 로그인 실패
		System.out.println("로그인 실패" + customerId + customerPw);
		String msg = URLEncoder.encode("아이디와 비밀번호를 확인하세요");
		response.sendRedirect("customerLoginForm.jsp?msg="+msg);	
	}
	/*
	1. pw / pw확인 불일치 시에도 경고msg 발생 후 회원가입됨
	2. ID / PW 일치 시에도 로그인 실패sysout출력됨
	*/
	
%>