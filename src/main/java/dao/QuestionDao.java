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
    public int insertQuestion(Question question) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            // 입력(insert) SQL
            String sql = "INSERT INTO question"
                + "(goods_no, customer_no, question_title, question_content, createdate, updatedate) "
                + "VALUES(?, ?, ?, ?, now(), now())";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, question.getGoodsNo());
            stmt.setInt(2, question.getCustomerNo());
            stmt.setString(3, question.getQuestionTitle());
            stmt.setString(4, question.getQuestionContent());

            int row = stmt.executeUpdate();

            return row;
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    // 문의사항 정보 업데이트
    public int updateQuestion(Question updateQuestion) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            // 업데이트 SQL
            String sql = "UPDATE question SET question_title=?,"
                + " question_content=?, updatedate=now() "
                + "WHERE questionNO=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, updateQuestion.getQuestionTitle());
            stmt.setString(2, updateQuestion.getQuestionContent());
            stmt.setInt(3, updateQuestion.getQuestionNo());

            int row = stmt.executeUpdate();

            if (row == 1) {
                System.out.println("문의사항 업데이트 성공");
            } else {
                System.out.println("문의사항 업데이트 실패");
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

    // 문의사항 정보 삭제
    public int deleteQuestion(int questionNO) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

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

    // 문의사항 정보 조회
    public List<Question> selectQuestion() throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            // 조회 SQL
            String sql = "SELECT * FROM question";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            List<Question> questionList = new ArrayList<>();

            while (rs.next()) {
                Question question = new Question();
                question.setQuestionNo(rs.getInt("questionNo"));
                question.setGoodsNo(rs.getInt("goods_no"));
                question.setCustomerNo(rs.getInt("customer_no"));
                question.setQuestionTitle(rs.getString("question_title"));
                question.setQuestionContent(rs.getString("question_content"));
                question.setCreatedate(rs.getString("createdate"));
                question.setUpdatedate(rs.getString("updatedate"));
                questionList.add(question);
            }

            return questionList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
}
