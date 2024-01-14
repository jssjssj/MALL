package dao;

import java.sql.*;
import java.util.*;


import util.*;
import vo.*;

public class QuestionDao extends ClassDao{
	Converter converter = null;
	
	
	public List<Map<String, Object>> questionList(Map<String, Integer> paramMap) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<Map<String, Object>> resultList = null;
		try {
			 String sql = """
			 		SELECT
			 			q.question_no,
			 			g.goods_title,
			 			q.question_title,
			 			q.createdate,
			 			q.updatedate
			 		FROM question q
			 		INNER JOIN goods g
			 		ON q.goods_no = g.goods_no
			 		ORDER BY q.updatedate DESC
			 		LIMIT ?, ?
			 		""";
			 stmt = conn.prepareStatement(sql);
			 stmt.setInt(1, paramMap.get("beginRow"));
			 stmt.setInt(2, paramMap.get("rowPerPage"));
			 rs = stmt.executeQuery();
			 Map<String, Object> map = null;
			 resultList = new ArrayList<>();
			 while(rs.next()) {
				 map = new HashMap<>();
				 map.put("questionNo", rs.getInt("question_no"));
				 map.put("goodsTitle", rs.getString("goods_title"));
				 map.put("questionTitle", rs.getString("question_title"));
				 map.put("createdate", rs.getString("createdate"));
				 map.put("updatedate", rs.getString("updatedate"));
				 resultList.add(map);
			 }
		 } catch (Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			stmt.close();
			conn.close();
		}
		 return resultList;
	}
	
	public int insert(Question paramQuestion) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					INSERT INTO question (
						goods_no,
						customer_no,
						question_title,
						question_content						
					) VALUES (
						?,
						?,
						?,
						?
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramQuestion.getGoodsNo());
			stmt.setInt(2, paramQuestion.getCustomerNo());
			stmt.setString(3, paramQuestion.getQuestionTitle());
			stmt.setString(4, paramQuestion.getQuestionContent());
			
			result = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public int delete(Question paramQuestion) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					DELETE FROM question
						WHERE question_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramQuestion.getQuestionNo());
			
			result = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public Map<String, Object> questionOne(int questionNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Map<String, Object> resultMap = null;
		try {
			String sql = """
					SELECT
			 			q.question_no,
			 			c.customer_id,
			 			g.goods_title,
			 			q.question_title,
			 			q.question_content,
			 			q.createdate,
			 			q.updatedate
			 		FROM question q
			 		INNER JOIN goods g
			 		ON q.goods_no = g.goods_no
			 		INNER JOIN customer c
			 		ON q.customer_no = c.customer_no			 		
			 		WHERE q.question_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, questionNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultMap = new HashMap<>();
				resultMap.put("questionNo", rs.getInt("question_no"));
				resultMap.put("customerId", rs.getString("customer_id"));
				resultMap.put("goodsTitle", rs.getString("goods_title"));
				resultMap.put("questionTitle", rs.getString("question_title"));
				resultMap.put("questionContent", rs.getString("question_content"));
				resultMap.put("createdate", rs.getString("createdate"));
				resultMap.put("updatedate", rs.getString("updatedate"));
				rs.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return resultMap;
	}
	
	public int countOfQuestion() throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		int result = 0;
		try {
			String sql = """
					SELECT
						COUNT(*) count
					FROM question
					""";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("count");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
			return result;
	}
	
/*											question 종료 - questionComment 시작										*/
	
	public Map<String, Object> commentOne(int questionNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Map<String, Object> resultMap = null;
		try {
			String sql = """
					SELECT
						q.question_comment_no,
						q.question_no,
						m.manager_name,
						q.comment,
						q.createdate,
						q.updatedate
					FROM question_comment q
					INNER JOIN manager m
					ON q.manager_no = m.manager_no
					
					WHERE q.question_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, questionNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultMap = new HashMap<>();
				resultMap.put("questionCommentNo", rs.getInt("question_comment_no"));
				resultMap.put("questionNo", rs.getInt("question_no"));
				resultMap.put("managerName", rs.getString("manager_name"));
				resultMap.put("comment", rs.getString("comment"));
				resultMap.put("createdate", rs.getString("createdate"));
				resultMap.put("updatedate", rs.getString("updatedate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			stmt.close();
			conn.close();
		}
			return resultMap;
	}
	
	public int insertCommet(QuestionComment paramQuestionComment) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					INSERT INTO notice (
						question_no,
						manager_no,
						comment										
					) VALUES (
						?,
						?,
						?
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramQuestionComment.getQuestionNo());
			stmt.setInt(2, paramQuestionComment.getManagerNo());
			stmt.setString(3, paramQuestionComment.getComment());			
			result = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public int deleteCommet(Question paramQuestion) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					DELETE FROM question_comment
						WHERE question_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramQuestion.getQuestionNo());
			
			result = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	
	
}