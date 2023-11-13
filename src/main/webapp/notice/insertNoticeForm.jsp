<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.net.URLEncoder.*" %>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<jsp:include page="/inc/meta.jsp"></jsp:include>
<body>	
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
    <jsp:include page="/inc/header.jsp"></jsp:include>
	<form method="post" id="createNoticeForm"
		action="<%=request.getContextPath()%>/notice/insertNoticeAction.jsp">
		<input type="hidden" name="managerNo" value="<%= ((Manager)session.getAttribute("loginManager")).getManagerNo()%>">
		<div class="outer">
			<div class="inner">
				<fieldset>
					<legend>공지사항 등록</legend>
					<table border="1">
						<!-- 제목 -->
						<tr>
							<th>제목</th>
							<td><input type="text"  name="noticeTitle" id="title"
								class="title"> <span id="titleMsg" class="msg"></span></td>
						</tr>
						<!-- 내용 -->
						<tr>
							<th>내용</th>
							<td><textarea cols="100	" rows="20" name="noticeContent" id="content"  class="content">
							</textarea>
							<span id="contentMsg" class="msg"></span>
							</td>
						</tr>
						<tr>
							<td>
								<button type="submit" id="createBtn">등록하기</button>
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