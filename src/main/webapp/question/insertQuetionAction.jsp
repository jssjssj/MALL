<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Question"%>
<%@ page import="dao.QuestionDao"%>
<%@ page import="java.net.URLEncoder" %>

<%
    // 데이터베이스와의 연결을 위해 QuestionDao 객체를 생성합니다.
    QuestionDao questionDao = new QuestionDao();
    
    // request에서 파라미터를 가져옵니다.
    String questionTitle = request.getParameter("questionTitle");
    String questionContent = request.getParameter("questionContent");

    // Question 객체를 생성하여 값을 설정합니다.
    Question question = new Question();
    question.setQuestionTitle(questionTitle);
    question.setQuestionContent(questionContent);

    // 데이터베이스에 데이터를 삽입하고 결과를 확인합니다.
    
        int result = questionDao.insertQuestion(question);       

        if (result > 0) {
        	System.out.println(result);
            String quesMsg = URLEncoder.encode("게시글 등록완료! 답변까지 기다려주세요");
            response.sendRedirect(request.getContextPath()+"/question/questionList.jsp?quesMsg="+quesMsg);
        } else {
            response.sendRedirect(request.getContextPath()+"/question/questionList.jsp");
            System.out.println();
        }

       
    
%>