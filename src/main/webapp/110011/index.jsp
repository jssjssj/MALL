
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*"%>
<%	
	Goods goods = new Goods();
	String msg1 = request.getParameter("msg1");
	String msg2 = request.getParameter("msg2");
	String msg4 = request.getParameter("msg4");
	
%>

<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
	<jsp:include page="/inc/header.jsp"></jsp:include>
	<!-- Section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Product image-->
						<img class="card-img-top"
							src="<%=request.getContextPath()%>/assets/image1.png" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">부대찌개</h5>
								<!-- Product reviews-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star"></div>
								</div>
								<!-- Product price-->
								\ 15,000
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=3">바로구매</a>
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=3&quantity=1">장바구니+</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Sale badge-->
						<div class="badge bg-dark text-white position-absolute"
							style="top: 0.5rem; right: 0.5rem">Sale</div>
						<!-- Product image-->
						<img class="card-img-top"
							src="<%=request.getContextPath()%>/assets/image2.png" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Special Item</h5>
								<!-- Product reviews-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
								</div>
								<!-- Product price-->
								<span class="text-muted text-decoration-line-through">\
									19,900</span> \ 16,000
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=4">바로구매</a>
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=4&quantity=1">장바구니+</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Sale badge-->
						<div class="badge bg-dark text-white position-absolute"
							style="top: 0.5rem; right: 0.5rem">Sale</div>
						<!-- Product image-->
						<img class="card-img-top"
							src="<%=request.getContextPath()%>/assets/image3.png" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Sale Item</h5>
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star"></div>
								</div>
								<!-- Product price-->
								<span class="text-muted text-decoration-line-through">\
									28,000</span> \ 23,900
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=5">바로구매</a>
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=5&quantity=1">장바구니+</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Product image-->
						<img class="card-img-top"
							src="<%=request.getContextPath()%>/assets/image4.png" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Popular Item</h5>
								<!-- Product reviews-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
								</div>
								<!-- Product price-->
								\ 18,500
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=6">바로구매</a>
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=6&quantity=1">장바구니+</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Sale badge-->
						<div class="badge bg-dark text-white position-absolute"
							style="top: 0.5rem; right: 0.5rem">Sale</div>
						<!-- Product image-->
						<img class="card-img-top"
							src="<%=request.getContextPath()%>/assets/image5.png" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Sale Item</h5>
								<!-- Product price-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
								</div>
								<span class="text-muted text-decoration-line-through">\
									25,000</span> \ 21,900
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=7">바로구매</a>
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=7&quantity=1">장바구니+</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Product image-->
						<img class="card-img-top"
							src="<%=request.getContextPath()%>/assets/image6.png" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Fancy Product</h5>
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
								</div>
								<!-- Product price-->
								\ 16,900
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=8">바로구매</a>
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=8&quantity=1">장바구니+</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Sale badge-->
						<div class="badge bg-dark text-white position-absolute"
							style="top: 0.5rem; right: 0.5rem">Sale</div>
						<!-- Product image-->
						<img class="card-img-top"
							src="<%=request.getContextPath()%>/assets/image7.png" alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Special Item</h5>
								<!-- Product reviews-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star"></div>
								</div>
								<!-- Product price-->
								<span class="text-muted text-decoration-line-through">\
									21,000</span> \ 24,900
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=9">바로구매</a>
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=9&quantity=1">장바구니+</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col mb-5">
					<div class="card h-100">
						<!-- Product image-->
						<img class="card-img-top"
							src="<%=request.getContextPath()%>/assets/image8.png" " alt="..." />
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-center">
								<!-- Product name-->
								<h5 class="fw-bolder">Popular Item</h5>
								<!-- Product reviews-->
								<div
									class="d-flex justify-content-center small text-warning mb-2">
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
									<div class="bi-star-fill"></div>
								</div>
								<!-- Product price-->
								\ 15,000
							</div>
						</div>
						<!-- Product actions-->
						<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
							<div class="text-center">
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/goods/goodsOne.jsp?goodsNo=10">바로구매</a>
								<a class="btn btn-outline-dark mt-auto"
									href="<%=request.getContextPath()%>/cart/insertCartAction.jsp?goodsNo=10&quantity=1">장바구니+</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- footer 시작 -->
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	<!-- footer 끝 -->
</body>
</html>