package dao;

import java.sql.*;
import java.util.*;


import util.*;
import vo.*;

public class QuestionDao extends ClassDao{
    // 문의사항 추가
    public int insertQuestion(String customerId , int goodsNo , String questionTitle , String questionContent) throws Exception {
        Connection conn = null;        
        PreparedStatement stmt = null;
        conn = db.getConnection();
        int row = 0;
        String sql0 = """
        		SELECT * FROM customer
        		WHERE customer_id = ?
        		""";
        PreparedStatement stmt0 = conn.prepareStatement(sql0);
        stmt0.setString(1, customerId);
        ResultSet rs0 = stmt0.executeQuery();
        if(rs0.next()) {
            // 입력(insert)
            String sql = "INSERT INTO question"
                + "(goods_no, customer_no, question_title, question_content, createdate, updatedate) "
                + "VALUES(?, ?, ?, ?, now(), now())";
            stmt = conn.prepareStatement(sql ,  Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, goodsNo);
            stmt.setInt(2, rs0.getInt("customer_no"));
            stmt.setString(3, questionTitle);
            stmt.setString(4, questionContent);
            
            row = stmt.executeUpdate();
        }
            return row;
                 
    }

   

    // 문의사항 정보 삭제
    public int deleteQuestion(int questionNO) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = db.getConnection();

            // 삭제 SQL
            String sql = "DELETE FROM question WHERE questionNO=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, questionNO);

            int row = stmt.executeUpdate();

            if (row == 1) {
                System.out.println("문의사항 삭제 성공");
            } else {
                System.out.println("문의사항 삭제 실패");
            }

            return row;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    // 문의사항 정보 조회  //cd = customerDetail // c =customer // q = question //g = goods
    public List<Question> selectQuestion() throws Exception {
	    Connection conn = db.getConnection();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    List<Question> questionList = null;
	    String sql = """
	           SELECT q.question_no , q.goods_no , q.question_title , q.createdate AS 작성일 , 
	    		  	 IFNULL(qc.createdate,"답변대기중") AS 답변일,  
						 IFNULL(qc.updatedate,"-") AS 수정일 	, g.goods_title FROM question q			
        		LEFT outer JOIN question_comment qc
        		ON q.question_no = qc.question_no
        		INNER JOIN goods g
        		ON q.goods_no = g.goods_no
        		ORDER BY 1
	            """;

	    stmt = conn.prepareStatement(sql); 
	    rs = stmt.executeQuery();
        questionList = new ArrayList<>();
	        while (rs.next()) {
	        	Question question = new Question();  
	            question.setQuestionNo(rs.getInt("question_no"));
				question.setGoodsNo(rs.getInt("goods_no"));		
				question.setQuestionTitle(rs.getString("question_title"));
				question.setCreatedate(rs.getString("작성일"));
				
				QuestionComment questionComment = new QuestionComment();
				questionComment.setCreatedate(rs.getString("답변일"));
				questionComment.setUpdatedate(rs.getString("수정일"));

				Goods goods = new Goods();
				goods.setGoodsTitle(rs.getString("goods_title"));
				
				question.setGoods(goods);
				question.setQuestionComment(questionComment);
				questionList.add(question);
	        }	
	        stmt.close();	        
	        rs.close();
	        conn.close();
	        return questionList;
	    } 
    
    public Question QuestionOne(int questionNo) throws Exception{    	
    	Connection conn = db.getConnection();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
    	Question question = null;
    	QuestionComment questionComment = null;
    	Customer customer = null;
    	
    	
 	    String sql = """
 	    		SELECT q.question_no , q.goods_no , q.question_title , q.question_content , q.createdate AS 작성일 , 
	    		  	 IFNULL(qc.createdate,"답변대기중") AS 답변일,   IFNULL(qc.updatedate,"-") AS 수정일 	,
						 g.goods_title , c.customer_id , qc.comment 
				 FROM question q			
        		LEFT outer JOIN question_comment qc
        		ON q.question_no = qc.question_no
        		INNER JOIN goods g
        		ON q.goods_no = g.goods_no
        		INNER JOIN customer c
        		ON c.customer_no = q.customer_no
        		WHERE q.question_no = ?
 	    		""";
 	    stmt = conn.prepareStatement(sql);
 	    stmt.setInt(1, questionNo);
 	    rs = stmt.executeQuery();
 	   if(rs.next()) {
 	 		 question = new Question();
 		    	question.setQuestionNo(rs.getInt("question_no"));
 				question.setGoodsNo(rs.getInt("goods_no"));		
 				question.setQuestionTitle(rs.getString("question_title"));
 				question.setCreatedate(rs.getString("작성일"));
 				question.setQuestionContent(rs.getString("question_content"));
 		    questionComment = new QuestionComment();
 		    	questionComment.setCreatedate(rs.getString("답변일"));
 				questionComment.setUpdatedate(rs.getString("수정일"));
 				questionComment.setComment(rs.getString("qc.comment"));
 				
 			customer = new Customer();	
 				customer.setCustomerId(rs.getString("customer_id"));
 				
 				question.setQuestionComment(questionComment);
 				question.setCustomer(customer);
 	    }
 	  return question;
    }
}
    
	    
	    
	

















