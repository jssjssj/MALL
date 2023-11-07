package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import vo.QuestionComment;

public class QuestionCommentDao {
    // 문의사항 댓글 추가
    public int insertQuestionComment(QuestionComment insertQuestionComment) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            // 입력(insert) SQL
            String sql = "INSERT INTO questionComment"
                + "(question_no, manager_no, comment, createdate, updatedate) "
                + "VALUES(?, ?, ?, now(), now())";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, insertQuestionComment.getQuestionNo());
            stmt.setInt(2, insertQuestionComment.getManagerNo());
            stmt.setString(3, insertQuestionComment.getComment());

            int row = stmt.executeUpdate();

            if (row == 1) {
                System.out.println("문의사항 댓글 생성 성공");
            } else {
                System.out.println("문의사항 댓글 생성 실패");
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

    // 문의사항 댓글 정보 업데이트 (수정)
    public int updateQuestionComment(QuestionComment updateQuestionComment) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            // 업데이트 SQL
            String sql = "UPDATE questionComment SET comment=?, updatedate=now() WHERE questionCommentNo=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, updateQuestionComment.getComment());
            stmt.setInt(2, updateQuestionComment.getQuestionCommentNo());

            int row = stmt.executeUpdate();

            if (row == 1) {
                System.out.println("문의사항 댓글 업데이트 성공");
            } else {
                System.out.println("문의사항 댓글 업데이트 실패");
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

    // 문의사항 댓글 정보 삭제
    public int deleteQuestionComment(int questionCommentNo, int managerNo) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            // 삭제 SQL - managerNo를 확인하여 삭제 권한을 부여
            String sql = "DELETE FROM questionComment WHERE questionCommentNo=? AND manager_no=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, questionCommentNo);
            stmt.setInt(2, managerNo);

            int row = stmt.executeUpdate();

            if (row == 1) {
                System.out.println("문의사항 댓글 삭제 성공");
            } else {
                System.out.println("문의사항 댓글 삭제 실패");
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

    // 문의사항 댓글 정보 조회
    public List<QuestionComment> selectQuestionComments(int questionNo) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            // 조회 SQL
            String sql = "SELECT * FROM questionComment WHERE question_no=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, questionNo);
            rs = stmt.executeQuery();

            List<QuestionComment> questionCommentList = new ArrayList<>();

            while (rs.next()) {
                QuestionComment questionComment = new QuestionComment();
                questionComment.setQuestionCommentNo(rs.getInt("questionCommentNo"));
                questionComment.setQuestionNo(rs.getInt("question_no"));
                questionComment.setManagerNo(rs.getInt("manager_no"));
                questionComment.setComment(rs.getString("comment"));
                questionComment.setCreatedate(rs.getString("createdate"));
                questionComment.setUpdatedate(rs.getString("updatedate"));
                questionCommentList.add(questionComment);
            }

            return questionCommentList;
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