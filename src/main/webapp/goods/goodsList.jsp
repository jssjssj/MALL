<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>

<%
	// total,perPage,currentPage;
	List<Page> pages = new Paginator().getPages(41,10,2);
	GoodsDao dao = new GoodsDao();
	Goods goods = new Goods();	
	DBUtil dbUtil = new DBUtil();	
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
	<h1>상품</h1>
	<table>
		<tr>
			<% 
				int i = 1;
				// for(goods g : ) {
			%>
					<td>
						<div class="card" style="width:300px">
							<img class="card-img-top" 
								src="<%=request.getContextPath()%>/goodsImg/<%=g.name%>">
							<div class="card-body"> 
								<h4 class="card-title" name="productName"><%=g.goodsName%></h4>
								<p class="card-text"><%=g.goodsPrice%></p>
								<a href="<%=request.getContextPath()%>/??=<%=%>" 
									class="btn btn-outline-danger">준비중</a>
								<a href="<%=request.getContextPath()%>/??=<%=%>" 
									class="btn btn-outline-danger">준비중</a> 
							</div>
						</div>
					</td>
			<%
					if(i%4==0) {
			%>
						</tr><tr>
			<%			
					} 
					i=i+1;
				}
				
				// 마지막 페이지면서 4로 나누어 떨어지지 않으면
				// if((i) == (rowPerPage+1)) // 마지막 페이지가 아니거나 마지막 페이지 이지만 rowPerPage로 나누어 떨어진다->4로도 나누어 떨어진다
				if((i-1) < (rowPerPage)) { // 마지막 페이지 이면서 rowPerPage로 나누어 떨어지지 않는다
					// 조건에 만족해도 4로 나누어 떨어지면 td는 필요없다
					if((i-1)%4 != 0) { // td가 더 필요하다
						for(int j=0; j<4-((i-1)%4); j=j+1) {
			%>
							<td class="bg-secondary">&nbsp;</td>
			<%				
						}
					}
				}
			%>
		</tr>
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