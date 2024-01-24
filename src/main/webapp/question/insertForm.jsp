<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.* , vo.*, java.util.* " %>
<%request.setCharacterEncoding("UTF-8"); %>
<%	
	GoodsDao goodsDao = new GoodsDao();
	List<Goods> goodsList = goodsDao.goodsAll();
	Customer loginCustomer = (Customer)session.getAttribute("loginCustomer");
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
<jsp:include page="/inc/menubar.jsp"></jsp:include>
<jsp:include page="/inc/header.jsp"></jsp:include>
	<form method="post" id="createNoticeForm"
		action="<%=request.getContextPath()%>/question/insertAction.jsp">
		
			
				<h2>문의글 등록</h2> <br>
				<h6>문의글은 수정할 수 없으니 신중히 등록해주세요</h6>
				<table class="table">
					<tr>
						<th>작성자</th>
						<td><%= loginCustomer.getCustomerId() %></td>
					</tr>					
					<!-- 제목 -->
					<tr>
						<th>제목</th>
						<td><textarea name="questionTitle" id="title" 
							cols="100" rows="3" style="resize: none;"/></textarea>
							<br><span id="titleMsg" class="msg"></span></td>
					</tr>
					<!-- 내용 -->
					
					<tr>
						<th>문의상품</th>
						<td><select name="goodsNo"><% for (Goods g : goodsList) { %>
							<option value="<%= g.getGoodsNo() %>"><%= g.getGoodsTitle()%></option> <%} %>
						</select></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea cols="100" rows="10" name="questionContent" 
							id="content" style="resize: none;"></textarea>
						<br><span id="contentMsg" class="msg"></span>
						</td>
					</tr>
				</table>
				<button style="margin-left: 70%;" class="btn btn-success" type="submit">등록하기</button>
			
		
	</form>
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	

</body> 
</html>