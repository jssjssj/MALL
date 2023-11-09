<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>

<%
	// total,perPage,currentPage;
	List<Page> pages = new Paginator().getPages(41,10,2);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Shop Homepage</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />    
</head>
</head>
<body>	
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->
<!-- Header 시작-->
        <header class="bg-dark py-5"> 
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                </div>
            </div>
        </header>
<!-- Header 끝-->        
	<h1>상품</h1>
	<table>
	
	</table>
<!-- 페이지 시작 -->	
<div>
	<%
		for (Page p : pages) {
	%>
		<span style="padding : 4px;"><%=p.toString()%></span>
	<% } %>  	
</div>
<!-- 페이지 끝 -->	
</body>
</html> 