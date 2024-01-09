package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import util.Converter;
import util.DBUtil;
import vo.Notice;

public class NoticeDao extends ClassDao {
	Converter converter = null;
	
	public Map<String, Object> noticeList(Map<String, Integer> paramMap) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Map<String, Object> resultMap = null;
		 try {
			 String sql = """
			 		SELECT
			 			n.notice_no,
			 			n.notice_title,
			 			n.notice_content,
			 			n.createdate,
			 			n.updatedate,
			 			m.manager_id
			 		FROM notice n
			 		INNER JOIN manager m
			 		ON n.manager_no = m.manager_no
			 		
			 		LIMIT ?, ?
			 		""";
			 stmt = conn.prepareStatement(sql);
			 stmt.setInt(1, paramMap.get("beginRow"));
			 stmt.setInt(2, paramMap.get("rowPerPage"));
			 rs = stmt.executeQuery();
			 
			 if(rs.next()) {
				 resultMap = new HashMap<>();
				 resultMap.put("noticeNo", rs.getInt("notice_no"));
				 resultMap.put("noticeTitle", rs.getInt("notice_title"));
				 resultMap.put("noticeContent", rs.getInt("notice_content"));
				 resultMap.put("createdate", rs.getInt("createdate"));
				 resultMap.put("updatedate", rs.getInt("updatedate"));
				 resultMap.put("managerId", rs.getInt("manager_id"));
			 }
		 } catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
		 return resultMap;
	}
	
	public int insert(Notice paramNotice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					INSERT INTO notice (
						manager_no,
						notice_title,
						notice_content
					) VALUES (
						?,
						?,
						?
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramNotice.getManagerNo());
			stmt.setString(2, paramNotice.getNoticeTitle());
			stmt.setString(3, paramNotice.getNoticeContent());
			
			result = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public int delete(Notice paramNotice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					DELETE FROM notice
						WHERE notice_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramNotice.getNoticeNo());
			
			result = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public int update(Notice paramNotice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					UPDATE notice SET
						manager_no = ?,
						notice_title = ?,
						notice_content = ?,
						updatedate = NOW()
					WHERE notice_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramNotice.getManagerNo());
			stmt.setString(2, paramNotice.getNoticeTitle());
			stmt.setString(3, paramNotice.getNoticeContent());
			stmt.setInt(4, paramNotice.getNoticeNo());
			
			result = stmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public Notice noticeOne(Notice paramNotice) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Notice notice = null;
		try {
			String sql = """
					SELECT
						notice_no,
						notice_title,
						notice_content,
						createdate,
						updatedate,
						manager_id
					FROM notice
					WHERE notice_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramNotice.getNoticeNo());
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				converter = new Converter();
				notice = converter.getNotice(rs);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return notice;
	}
	
}