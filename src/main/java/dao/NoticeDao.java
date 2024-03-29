package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.Converter;
import util.DBUtil;
import vo.Notice;

public class NoticeDao extends ClassDao {
	Converter converter = null;
	
	public List<Map<String, Object>> noticeList(Map<String, Integer> paramMap) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<Map<String, Object>> resultList = null;
		 try {
			 String sql = """
			 		SELECT
			 			n.notice_no,
			 			n.notice_title,
			 			n.createdate,
			 			n.updatedate,
			 			m.manager_id
			 		FROM notice n
			 		INNER JOIN manager m
			 		ON n.manager_no = m.manager_no
			 		ORDER BY n.updatedate DESC
			 		LIMIT ?, ?
			 		""";
			 stmt = conn.prepareStatement(sql);
			 stmt.setInt(1, paramMap.get("beginRow"));
			 stmt.setInt(2, paramMap.get("rowPerPage"));
			 rs = stmt.executeQuery();
			 
			 resultList = new ArrayList<>();
			 while(rs.next()) {
				 Map<String, Object> map = new HashMap<>();
				 map.put("noticeNo", rs.getInt("notice_no"));
				 map.put("noticeTitle", rs.getString("notice_title"));
				 map.put("createdate", rs.getString("createdate"));
				 map.put("updatedate", rs.getString("updatedate"));
				 map.put("managerId", rs.getString("manager_id"));
				 resultList.add(map);
				 rs.close();
			 }
		 } catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
		 return resultList;
	}
	
	public int countOfNotice() throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		int result = 0;
		try {
			String sql = """
					SELECT
						COUNT(*) cnt
					FROM notice
					""";
			stmt = conn.prepareStatement(sql);			
			rs = stmt.executeQuery();
			
			result = rs.getInt("cnt");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
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
	
	public int delete(int noticeNo) throws Exception {
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
			stmt.setInt(1, noticeNo);
			
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
	
	public Map<String, Object> noticeOne(int noticeNo) throws Exception {
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
					WHERE notice_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultMap = new HashMap<>();
				resultMap.put("noticeNo", rs.getInt("notice_no"));
				resultMap.put("noticeTitle", rs.getString("notice_title"));
				resultMap.put("noticeContent", rs.getString("notice_content"));
				resultMap.put("createdate", rs.getString("createdate"));
				resultMap.put("updatedate", rs.getString("updatedate"));
				resultMap.put("managerId", rs.getString("manager_id"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return resultMap;
	}
	
}