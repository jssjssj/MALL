<%@ page import="java.io.*,vo.*,dao.*,java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
@SuppressWarnings("unchecked") 	// List에 대한 경고 억제
int managerNo = Integer.parseInt(request.getParameter("managerNo"));
String currentPassword = request.getParameter("currentPassword");
String newPassword = request.getParameter("newPassword");

System.out.print(newPassword);
System.out.print(currentPassword);


ManagerDao managerDao = new ManagerDao();
boolean passwordUpdated = false;

try {
    // 새로운 비밀번호와 확인 비밀번호가 일치하는지 확인
    if (!newPassword.equals(request.getParameter("confirmPassword"))) {
        out.println("비밀번호 업데이트 실패: 새로운 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
        
    } else {
        // 이전에 사용한 비밀번호인지 확인
        @SuppressWarnings("rawtypes") // List에 대한 경고 억제
        List passwordHistory = managerDao.getManagerPasswordHistory(managerNo);
        if (passwordHistory.contains(newPassword)) {
            out.println("비밀번호 업데이트 실패: 이미 사용한 적 있는 비밀번호입니다.");
        } else {
            passwordUpdated = managerDao.updateManagerPassword(managerNo, currentPassword, newPassword);
            if (passwordUpdated) {
                out.println("비밀번호 업데이트 성공");
            } else {
                out.println("비밀번호 업데이트 실패: 현재 비밀번호가 일치하지 않습니다.");
            }
        }
    }
} catch (Exception e) {
    e.printStackTrace();
    // 예외 처리
}
%>
