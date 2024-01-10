<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.* "%>
<%
	Manager paramManager = new Manager();
	paramManager.setManagerId(request.getParameter("managerId"));
	paramManager.setManagerPw(request.getParameter("managerPw"));
	paramManager.setManagerName(request.getParameter("managerName"));
	
	ManagerDao managerDao = new ManagerDao();
	Manager check = managerDao.checkId(paramManager);	// 중복여부 확인
	int result = 0;
	if(check != null){ // 계정 조회됨 -> 중복
		response.sendRedirect(request.getContextPath()+"/public/home.jsp");
	} else {
		result = managerDao.insert(paramManager);
		
		if(result > 0){	// 가입 완료
			response.sendRedirect(request.getContextPath()+"/manager/insertForm.jsp");
		} else {
			response.sendRedirect(request.getContextPath()+"/public/home.jsp");
		}
	}	
	
%>