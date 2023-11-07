<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.GoodsDao" %>
<%@ page import="vo.Goods" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Goods</title>
</head>
<body>
<%	
    int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); // 삭제할 상품 번호를 파라미터로 받음

    GoodsDao dao = new GoodsDao();
    int row = dao.deleteGoods(goodsNo); // 상품 및 굿즈 이미지 정보 삭제

    if (row == 1) {
        // 이미지 파일 경로
        String imagePath = getServletContext().getRealPath("/goodsImg"); // 실제 경로 가져오기
        String fileName = "imageFileName.jpg"; // 이미지 파일명

        // 이미지 파일 삭제
        java.io.File imageFile = new java.io.File(imagePath, fileName);
        if (imageFile.exists()) {
            if (imageFile.delete()) {
                out.println("이미지 파일 삭제 성공");
            } else {
                out.println("이미지 파일 삭제 실패");
            }
        }
%>
        <h2>상품 삭제 성공</h2>
        <p>상품 정보 및 굿즈 이미지 정보가 성공적으로 삭제되었습니다.</p>
<%
    } else {
%>
        <h2>상품 삭제 실패</h2>
        <p>상품 정보 및 굿즈 이미지 정보를 삭제하는 중에 오류가 발생했습니다.</p>
<%
    }
%>

    <a href="goodsList.jsp">상품 목록으로 돌아가기</a>
</body>
</html>
