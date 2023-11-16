<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.URLEncoder" %>

<%
	// Dao에 삽입될 데이터 지정 // 1. customerId , 2. goodsNo , 3. questionTitle , 4. questionContent
	
	// 1. customerId
	String customerId = (String)(session.getAttribute("loginId")); 

	// 2. goodsNo
	GoodsDao goodsDao = new GoodsDao();
	Goods goods = new Goods();
	request.setCharacterEncoding("utf-8");
	String goodsTitle=request.getParameter("goodsTitle");
	System.out.println(goodsTitle);
	goods = goodsDao.selectGoodsNo(goodsTitle);
	int goodsNo = goods.getGoodsNo();
	
	// 3. questionTitle
	String questionTitle = request.getParameter("questionTitle");
	
	// 4. questionContent
    String questionContent = request.getParameter("questionContent");
	
    // 데이터베이스와의 연결을 위해 QuestionDao 객체를 생성
    QuestionDao questionDao = new QuestionDao();

    
    // 데이터베이스에 데이터를 삽입 / 결과 확인.
    
        int result = questionDao.insertQuestion(customerId , goodsNo , questionTitle , questionContent);       

        if (result > 0) {
            String q = URLEncoder.encode("게시글 등록완료! 답변까지 기다려주세요");
            response.sendRedirect(request.getContextPath()+"/question/questionList.jsp?q="+q);
        } else {
        	String q = URLEncoder.encode("서버 점검 중으로 게시글이 등록되지 않았습니다. 다음에 이용해주세요");
            response.sendRedirect(request.getContextPath()+"/question/questionList.jsp?q="+q);
        }

       
    
%>