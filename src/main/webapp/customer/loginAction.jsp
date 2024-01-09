<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="util.*"%>
<%
    // 로그인

    // controller
    String customerId = request.getParameter("customerId");
    String customerPw = request.getParameter("customerPw");

    // model 코드
    DBUtil dbUtil = new DBUtil();
    Connection conn = dbUtil.getConnection();

    try {
        String sql = "SELECT customer_id, active FROM customer WHERE customer_id=? AND customer_pw = PASSWORD(?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, customerId);
        stmt.setString(2, customerPw);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) { 
            String active = rs.getString("active");

            if ("Y".equals(active)) {
                // 활성화된 계정인 경우에만 로그인 성공 처리
                session.setAttribute("loginId", customerId);
                response.sendRedirect(request.getContextPath() + "/110011/index.jsp");
            } else {
                // 비활성화된 계정인 경우
                System.out.println("로그인 실패: 비활성화된 계정");
                String noMsg = URLEncoder.encode("탈퇴한 계정입니다");
                response.sendRedirect(request.getContextPath() + "/customer/customerLoginForm.jsp?noMsg=" + noMsg);
            }
        } else {
            // 로그인 실패
            System.out.println("로그인 실패" + "\n" + "입력ID : " + customerId + "\n" + "입력PW : " + customerPw);
            String noUser = URLEncoder.encode("아이디와 비밀번호를 확인하세요");
            response.sendRedirect(request.getContextPath() + "/customer/customerLoginForm.jsp?noUser=" + noUser);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>