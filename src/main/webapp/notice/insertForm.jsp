<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*, dao.*, java.util.* "%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
	Manager loginManager = (Manager)session.getAttribute("loginManager");
%>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<form method="post" id="createNoticeForm"
		action="<%=request.getContextPath()%>/notice/insertAction.jsp">
		<input type="hidden" name="managerNo" value="<%= loginManager.getManagerNo()%>">
		<div class="outer">
			<div class="inner">
				<fieldset>
					<legend>공지사항 등록</legend>
					<table class="table">
						<tr>
							<th>작성자</th>
							<td><%= loginManager.getManagerId() %></td>
						</tr>
						<!-- 제목 -->
						<tr>
							<th>제목</th>
							<td><input type="text" name="noticeTitle"
								class="title"></td>
						</tr>
						<!-- 내용 -->
						<tr>
							<th>내용</th>
							<td><textarea cols="100	" rows="20" name="noticeContent" id="content">
							</textarea>							
							</td>
						</tr>
						<tr>
							<td>
								<button class="btn btn-success" type="submit">등록하기</button>
							</td>
						</tr>
					</table>
				</fieldset>
			</div>
		</div>
	</form>
	
<!-- footer 시작 -->
   <jsp:include page="/inc/footer.jsp"></jsp:include>
<!-- footer 끝 -->	
</body>
</html>