<%@ page import="dao.GoodsDao" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!--  이 부분에 @MultipartConfig 애너테이션 추가 -->
<%@ MultipartConfig(
    fileSizeThreshold   = 1024 * 1024 * 2,  // 2MB
    maxFileSize         = 1024 * 1024 * 10, // 10MB
    maxRequestSize      = 1024 * 1024 * 50, // 50MB
    location            = "/tmp",           // 임시 파일 저장 경로 설정
    fileSizeThreshold   = 0
)
%>
<%
    // 요청에서 멀티파트 항목 가져오기
    Part filePart = request.getPart("goodsImg");

    // 파일명 가져오기
    String filename = getFileName(filePart);

    // 파일 저장 경로 설정
    String uploadPath = "C:\\Users\\user\\git\\MALL\\src\\main\\webapp/upload";
    String filePath = uploadPath + File.separator + filename;

    // 파일 저장 
    filePart.write(filePath);
%>
    // 파일명 추출 메소드
<%!
    String getFileName(final Part part) {
        String header = part.getHeader("content-disposition");
        String[] elements = header.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
%>


<%
    // 파일 확장자 확인
    String contentType = filePart.getContentType();
    if (!(contentType.equals("image/png") || contentType.equals("image/jpeg") || contentType.equals("image/jpg"))) {
        // 파일의 확장자가 이미지 확장자가 아니라면 이미 업로드된 파일 삭제
        File f = new File(filePath);
        if (f.exists()) {
            f.delete(); // 파일 삭제
        }

        String msg = URLEncoder.encode("이미지 파일만 저장 가능합니다.");
        response.sendRedirect(request.getContextPath() + "/addGoods.jsp?msg=" + msg);
        return;
    }

    // form에서 입력한 정보들
    String goodsTitle = request.getParameter("goodsTitle");
    int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
    String goodsMemo = request.getParameter("goodsMemo");

    // 추가한 파일에 대한 정보들 저장
    GoodsDao goodsDao = new GoodsDao();
    goodsDao.addGoods(goodsTitle, goodsPrice, goodsMemo, contentType, filename, filename); // originName 대신 filename 사용

    response.sendRedirect(request.getContextPath() + "/managerGoodsList.jsp");
%>
