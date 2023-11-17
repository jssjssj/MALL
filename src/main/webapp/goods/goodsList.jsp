<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>

<%
	Manager loginManager = (Manager) session.getAttribute("loginManager");
	// 샘플 데이터 입력.
	GoodsDao goodsDao = new GoodsDao();
	SampleData sample = new SampleData();
	for(int i = 0; i < 0; i++) {
		Goods goods = sample.getGoods();
		GoodsImg goodsImg = sample.getGoodsImg(); 
		goodsDao.insertGoods(goods,goodsImg);
	}
%>

<%
	/*
		TODO:
			1. 굿즈 리스트를 가져온다.
			2. 페이징을 한다.
	*/
	String p_page = request.getParameter("page");
	if (p_page == null || p_page.equals("")) p_page = "1";
	int _page = Integer.parseInt(p_page);
	int perPage = 8;
	
	// GoodsDao 한테서 select해온다.
	GoodsDao dao = new GoodsDao();
	List<Goods> goodsList = dao.selectGoods(_page, perPage);
	
	// total,perPage,currentPage;
	List<Page> pages = new Paginator().getPages(dao.getAllGoodsCount(), perPage, _page);
	System.out.println(dao.getAllGoodsCount());
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<section class="py-5">
	
        <div class="container px-4 px-lg-5 mt-5">
   <%if(loginManager != null){%><a href="<%=request.getContextPath()%>/goods/insertGoodsForm.jsp"><button>상품추가</button></a><%}%>
       		<!--  상풍 리스트 -->
			<h1>상품</h1>
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
            	<% for (Goods goods : goodsList) { %>
                <div class="col mb-5">
                    <div class="card h-100">
                        <!-- Product image-->
                        <img class="card-img-top" src="/mall/<%= goods.getGoodsImg().getFileName() %>" alt="...">
                        <!-- Product details-->
                        <div class="card-body p-4">
                            <div class="text-center">
                                <!-- Product name-->
                                <h5 class="fw-bolder"><%= goods.getGoodsTitle() %></h5>
                                <!-- Product reviews-->
                                <div class="d-flex justify-content-center small text-warning mb-2">
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div> 
                                    <div class="bi-star"></div>                                        
                                </div>
                                <!-- Product price-->
                                \ <%= goods.getGoodsPrice() %>
                            </div>
                        </div>
                        <!-- Product actions-->
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="text-center">
                            <a class="btn btn-outline-dark mt-auto" href="<%=request.getContextPath()%>/cart/insertCartAction.jsp">장바구니 담기
                            </a>
                            <a class="btn btn-outline-dark mt-auto" href="<%=request.getContextPath()%>/cart/insertCartAction.jsp">주문하기
                            </a></div>
                        </div>
                    </div>
                </div>
            	<% } %>
            </div>
            
			<!-- 페이지 시작 -->	
			<div class="d-flex justify-content-center">
				<nav aria-label="Page navigation example">
				  <ul class="pagination">
					<%
						for (Page p : pages) {
					%>
				    	<li class="page-item <%= p.isActive ? "active" : "" %>">
				    		<a class="page-link" href="?page=<%= p.page%>">
				    			<%= p.text %>
			    			</a>
			    		</li>
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