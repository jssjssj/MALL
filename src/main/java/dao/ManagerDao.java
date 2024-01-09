package dao;
import java.sql.*;
import java.util.*;

import util.Converter;
import util.DBUtil;
import vo.*;
import java.security.*;

public class ManagerDao extends ClassDao{
	Converter converter = null;
	
	public Manager login(Manager paramManager) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Manager manager = null;
		try {
			String sql = """
					SELECT 
						manager_no,
						manager_id,
						manager_name,
						active,
						createdate,
						updatedate
					FROM manager
					WHERE manager_id = ?
					AND manager_pw = password(?)
					AND active = 'Y'
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramManager.getManagerId());
			stmt.setString(2, paramManager.getManagerPw());
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				converter = new Converter();
				manager = converter.Manager(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			stmt.close();
			conn.close();
		}
			return manager;
	}
	
	public int insert(Manager paramManager) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					INSERT INTO manager (
						manager_id,
						manager_pw,
						manager_name
					) VALUES (
						?,
						?,
						?
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramManager.getManagerId());
			stmt.setString(2, paramManager.getManagerPw());
			stmt.setString(3, paramManager.getManagerName());
			
			result = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
			return result;
	}
	
	public int delete(Manager paramManager) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					UPDATE manager SET
						active = 'N'
					WHERE manager_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramManager.getManagerNo());
			
			result = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
			return result;
	}
	
	
}    
