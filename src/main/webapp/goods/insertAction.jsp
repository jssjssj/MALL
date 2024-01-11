<%@ page import="java.util.Collection" %>
<%@ page import="javax.servlet.http.Part" %>

<%
    String uploadPath = getServletContext().getRealPath("/assets");

    // 폴더가 없으면 생성
    java.io.File uploadDir = new java.io.File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    // 모든 파트(파일) 처리
    Collection<Part> parts = request.getParts();
    for (Part part : parts) {
        if (part.getSubmittedFileName() != null) { // 파일 업로드를 요청한 경우에만 처리
            String fileName = "";
            String contentDisp = part.getHeader("content-disposition");
            String[] items = contentDisp.split(";");
            for (String item : items) {
                if (item.trim().startsWith("filename")) {
                    fileName = item.substring(item.indexOf("=") + 2, item.length() - 1);
                }
            }

            String filePath = uploadPath + java.io.File.separator + fileName;
            part.write(filePath);
            out.println("파일 업로드 완료: " + fileName + "<br>");
        }
    }
%>
