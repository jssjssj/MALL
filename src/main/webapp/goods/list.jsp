<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%

	Manager loginManager = (Manager)session.getAttribute("loginManager");

	// Dao 세팅
	ManagerDao managerDao = new ManagerDao();
	GoodsDao goodsDao = new GoodsDao();
	
	Integer currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 12;
	int beginRow = (currentPage - 1) * rowPerPage;
	int totalRow = goodsDao.countOfGoods();
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage += 1;
	}
	Map<String, Integer> paramMap = new HashMap<>();
	paramMap.put("beginRow", beginRow);
	paramMap.put("rowPerPage", rowPerPage);
	
	List<Map<String, Object>> goodsList = goodsDao.goodsList(paramMap);
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<section class="py-5">
	       		<!--  상풍 리스트 -->
	 
			<div style="text-align: center;">
				<h1>상품</h1>
				<%if(loginManager != null){%>
					<a class="btn btn-success" href="<%=request.getContextPath()%>/goods/insertForm.jsp">
						상품추가
					</a>
				<%}%>
			</div>
			
		 <div class="container px-4 px-lg-5 mt-5">
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
            	<% for (Map<String, Object> goods : goodsList) { %>
                <div class="col mb-5">
                    <div class="card h-100">
                        <!-- Product image-->
                        <img style="width: 225px; height: 180px;" class="card-img-top" src="<%=request.getContextPath()+"/"+ goods.get("originName") %>" alt="...">
                        <!-- Product details-->
                        <div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder"><%= goods.get("goodsTitle") %></h5>
                                <!-- Product reviews-->
                                <div class="d-flex justify-content-center small text-warning mb-2">
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div> 
                                    <div class="bi-star"></div>                                        
                                </div>
                                <!-- Product price-->
                                <%= goods.get("goodsPrice") %>원
                            </div>
                        </div>
                        <!-- Product actions-->
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                        	<div class="btn-group  btn-group-sm">
                            <a class="btn btn-outline-dark mt-auto"
                            	 href="<%=request.getContextPath()%>/cart/insertAction.jsp?goodsNo=<%= goods.get("goodsNo") %>&quantity=1">
                            	 장바구니+
                            </a>
                           		 
                            <a class="btn btn-outline-dark mt-auto" 
                            	href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=<%= goods.get("goodsNo") %>">
                            	바로주문
                            </a>
                            </div>
                        </div>
                    </div>
                </div>
            	<% } %>
            </div>
            


            
            
 			<!-- 페이지 시작 -->	
			<div class="d-flex justify-content-center">
				<nav aria-label="Page navigation example">
				  <ul class="pagination">
				  <% if(rowPerPage < totalRow) { %>
				  	<% if(currentPage != 1) { %>
					<a class="btn btn-success" href="<%= request.getContextPath() %>/goods/list.jsp?currentPage=1">맨앞</a>
					<a class="btn btn-success" href="<%= request.getContextPath() %>/goods/list.jsp?currentPage=<%=currentPage-1%>">이전</a>
					<% } %>
					<% if(currentPage != lastPage) { %>
					<a class="btn btn-success" href="<%= request.getContextPath() %>/goods/list.jsp?currentPage=<%=currentPage+1%>">다음</a>
					<a class="btn btn-success" href="<%= request.getContextPath() %>/goods/list.jsp?currentPage=<%=lastPage%>">맨뒤</a>
				  	<% } %>
				  <% } %>
				  </ul>
				</nav>
			</div> 
			<!-- 페이지 끝 -->	
        </div>
    </section>
	
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html> 