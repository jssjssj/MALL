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
            stmt = conn.prepareStatement(sql);
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
	    List<Question> result = new ArrayList<>();
	    String sql = """
	           SELECT q.* , cd.* , c.* , g.* , qc.* FROM question q
        			INNER JOIN customer_detail cd
        		ON q.customer_no = cd.customer_no
        			INNER JOIN customer c
        		ON cd.customer_no = c.customer_no
        			INNER JOIN goods g
        		ON g.goods_no = q.goods_no
        			INNER JOIN question_comment qc
        		ON q.question_no = qc.question_no
	            """;

	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        ResultSet rs = stmt.executeQuery();

	        List<Question> questionList = new ArrayList<>();
	        while (rs.next()) {
	        	Question question = converter.getQuestion(rs);
	            questionList.add(question);
	            
	        }

	        result = questionList;
	    } finally {
	        conn.close();
	    }
	    return result;
	}
}
















