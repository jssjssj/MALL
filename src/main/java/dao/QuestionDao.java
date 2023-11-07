package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import vo.Question;

public class QuestionDao {
    // 문의사항 추가
    public int insertQuestion(Question insertQuestion) throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 입력(insert) SQL
        String sql = "INSERT INTO question"
		        		+ "(goods_no, customer_no, question_title, question_content, createdate, updatedate) "
		        		+ "VALUES(?, ?, ?, ?, now(), now())";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, insertQuestion.getGoodsNo());
        stmt.setInt(2, insertQuestion.getCustomerNo());
        stmt.setString(3, insertQuestion.getQuestionTitle());
        stmt.setString(4, insertQuestion.getQuestionContent());

        int row = stmt.executeUpdate();

        if (row == 1) {
            System.out.println("문의사항 생성 성공");
        } else {
            System.out.println("문의사항 생성 실패");
        }
        
        return row;
    }
    // 문의사항 정보 업데이트
    public int updateQuestion(Question updateQuestion) throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 업데이트 SQL
        String sql = "UPDATE question SET question_title=?,"
		        		+ " question_content=?, updatedate=now() "
		        		+ "WHERE questionNO=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, updateQuestion.getQuestionTitle());
        stmt.setString(2, updateQuestion.getQuestionContent());
        stmt.setInt(3, updateQuestion.getQuestionNO());

        int row = stmt.executeUpdate();

        if (row == 1) {
            System.out.println("문의사항 업데이트 성공");
        } else {
            System.out.println("문의사항 업데이트 실패");
        }
        
        return row;
    }

    // 문의사항 정보 삭제
    public int deleteQuestion(int questionNO) throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 삭제 SQL
        String sql = "DELETE FROM question WHERE questionNO=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, questionNO);

        int row = stmt.executeUpdate();

        if (row == 1) {
            System.out.println("문의사항 삭제 성공");
        } else {
            System.out.println("문의사항 삭제 실패");
        }
        
        return row;
    }

    // 문의사항 정보 조회
    public List<Question> selectQuestion() throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 조회 SQL
        String sql = "SELECT * FROM question";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        List<Question> questionList = new ArrayList<>();

        while (rs.next()) {
            Question question = new Question();
            question.setQuestionNO(rs.getInt("questionNO"));
            question.setGoodsNo(rs.getInt("goods_no"));
            question.setCustomerNo(rs.getInt("customer_no"));
            question.setQuestionTitle(rs.getString("question_title"));
            question.setQuestionContent(rs.getString("question_content"));
            question.setCreatedate(rs.getString("createdate"));
            question.setUpdatedate(rs.getString("updatedate"));
            questionList.add(question);
        }
        
        return questionList;
    }
}
