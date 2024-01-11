<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>  
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
<!--상품 추가 내용-->
<br>
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="login_form_inner mx-auto" style="width:500px;">
				<h3>상품 추가</h3>
				<form method="post" enctype="multipart/form-data" class="row login_form" action="<%=request.getContextPath()%>/goods/insertAction.jsp">
					<div class="col-md-12 form-group">
						<input type="text" class="form-control" id="goodsTitle" name="goodsTitle" placeholder="상품 이름" maxlength="15" onfocus="this.placeholder = ''" onblur="this.placeholder = '상품 이름'">
           				</div>
		            <div class="col-md-12 form-group">
						<input type="number" class="form-control" id="goodsPrice" name="goodsPrice" placeholder="상품 가격" onfocus="this.placeholder = ''" onblur="this.placeholder = '상품 가격'">
		            </div>
					<div class="col-md-12 form-group">
						<textarea class="form-control" rows="7" name="goodsMemo" placeholder="상품설명" onfocus="this.placeholder = ''" onblur="this.placeholder = '메모'"></textarea>
					</div>
					<div class="col-md-12 form-group">
						<input type="file" class="form-control" id="goodsImg" name="goodsImg">
		            </div>
		   
					<div class="col-md-12 form-group">
						<button type="submit" value="submit" class="btn btn-success w-100 mx-auto" style="margin:30px;">추가하기</button>
					</div>
				</form>
			</div>		
		</div>
	</section>
	<!--================상품 추가 폼 끝 =================-->
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->
</body>
</html>