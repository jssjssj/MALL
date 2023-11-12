<%@ page import="java.io.Console"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>

<% 
	// 객체 값 넣기
	request.setCharacterEncoding("UTF-8");
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");
	
	System.out.println(managerId+ managerPw+ managerName);
	
	// 지정
	ManagerDao managerDao = new ManagerDao(); 
	Manager manager = new Manager();

	
	manager.setManagerId(managerId);
	manager.setManagerPw(managerPw);
	manager.setManagerName(managerName);

	
	int row = managerDao.insertManager(manager);
	System.out.println(row);
	
	if(row == 1) {
		System.out.println("manager계정 생성 성공" );
		// TODO: 매니저 비번 히스토리에 추가한다.
		response.sendRedirect(request.getContextPath()+"/110011/index.jsp");
	} else {
		response.sendRedirect(request.getContextPath()+"/manager/insertManagerForm.jsp");
	}
	
%>