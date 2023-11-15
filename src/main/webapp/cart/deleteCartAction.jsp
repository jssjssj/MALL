<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<% 
	CartDao cartDao = new CartDao();
	String cartNo = request.getParameter("cartNo");
	int row = cartDao.deleteCart(goodsNo , customerNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>ㅋㅋ</h4>
 
</body>
</html>