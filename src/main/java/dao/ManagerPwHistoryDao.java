package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.Converter;
import util.DBUtil;
import vo.Manager;
import vo.ManagerPwHistory;

public class ManagerPwHistoryDao {
	Converter converter = null;
	
	public int insertHistory(Manager paramManager) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					INSERT INTO manager_pw_history (
						manager_no,
						manager_pw
					) VALUES (
						?,
						password(?)
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramManager.getManagerNo());
			stmt.setString(2, paramManager.getManagerPw());
			
			result = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public List<ManagerPwHistory> selectPw (Manager paramManager) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<ManagerPwHistory> resultList = null;
		try {
			String sql = """
					SELECT * FROM manager_pw_history
						WHERE manager_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramManager.getManagerNo());
			
			rs = stmt.executeQuery();
			resultList = new ArrayList<>();
			while(rs.next()) {
				converter = new Converter();
				ManagerPwHistory pw = converter.getManagerPwHistory(rs);
				resultList.add(pw);				
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
}
