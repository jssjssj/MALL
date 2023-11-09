<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
<%
	String address = request.getParameter("address");

	CustomerAddr customerAddr = new CustomerAddr();
	CustomerAddrDao customerAddrDao = new CustomerAddrDao();
	
	
	customerAddr.setAddress(address);
	
	int row = customerAddrDao.insertCustomerAddr(customerAddr);
	
	if(row == 1) {
		System.out.println("insert adress 성공");
		response.sendRedirect(request.getContextPath()+"/customer/insertCustomerDetailAction.jsp"
		);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>