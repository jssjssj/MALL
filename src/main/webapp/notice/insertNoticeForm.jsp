<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>공지사항 등록</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
<body>
<!-- 메뉴 시작 -->
	<jsp:include page="/inc/menubar.jsp"></jsp:include>
<!-- 메뉴 끝 -->

<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Shop in style</h1>
            <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
        </div>
    </div>
</header>
	<form method="post" id="createNoticeForm"
		action="<%=request.getContextPath()%>/notice/insertNoticeAction.jsp">
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
</body>
</html>