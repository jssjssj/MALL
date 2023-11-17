package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;
import java.security.*;

public class ManagerDao extends ClassDao{
    /* 디버깅 색깔 지정 */ 
    // ANSI CODE    
    final String RESET = "\u001B[0m"; 
    final String KIM = "\u001B[42m";
    final String PARK = "\u001B[44m";

 // 매니저 추가

    public int insertManager(Manager manager) throws Exception {
        Connection conn = db.getConnection();
        PreparedStatement stmtManager = null;
        PreparedStatement stmtHistory = null;
        int managerNo = 0;

        try {
            conn.setAutoCommit(false);
            
         // 중복 아이디 확인
            String checkSql = "SELECT manager_no FROM manager WHERE manager_id = ?";
            PreparedStatement stmtCheckid = conn.prepareStatement(checkSql);
            stmtCheckid.setString(1, manager.getManagerId());
            ResultSet rs = stmtCheckid.executeQuery();
            
            if (rs.next()) {
                // 이미 존재하는 아이디가 있을 경우 중복으로 처리
                return -1;
            }
            

            // 매니저 정보 추가
            String insertManagerSql = """
            							INSERT INTO manager
            							(manager_id, manager_pw, manager_name, createdate, updatedate)
            							VALUES(?, PASSWORD(?), ?, NOW(), NOW())
            					""";  
            stmtManager = conn.prepareStatement(insertManagerSql, Statement.RETURN_GENERATED_KEYS);
            stmtManager.setString(1, manager.getManagerId());
            stmtManager.setString(2, manager.getManagerPw());
            stmtManager.setString(3, manager.getManagerName());
            stmtManager.executeUpdate();

            ResultSet generatedKeys = stmtManager.getGeneratedKeys();
            if (generatedKeys.next()) {
                managerNo = generatedKeys.getInt(1);
            } else {
                conn.rollback();
                return 0;
            }

            // 매니저 비밀번호 이력 추가
            String insertHistorySql = "INSERT INTO manager_pw_history"
                + "(manager_no, manager_pw, createdate) "
                + "VALUES(?, PASSWORD(?), NOW())";

            stmtHistory = conn.prepareStatement(insertHistorySql);
            stmtHistory.setInt(1, managerNo);
            stmtHistory.setString(2, manager.getManagerPw());
            stmtHistory.executeUpdate();
            conn.commit();

        } catch (Exception e) {
            if (conn != null) {
                conn.rollback();
            }
            e.printStackTrace();
            return 0;
        } finally {
            if (stmtManager != null) {
                stmtManager.close();
            }
            if (stmtHistory != null) {
                stmtHistory.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }

        return 1;
    }

    public int updateManagerPw(int managerNo, String currentPassword, String newPassword) throws Exception {
		
		Connection conn = db.getConnection();
		conn.setAutoCommit(false);
		
		// 변경할 비밀번호가 이전에 사용했던 비밀번호와 다른지 확인
		String sql0 = """
						SELECT manager_pw managerPw FROM manager_pw_history
						WHERE manager_no = ? AND manager_pw = PASSWORD(?)
					""";
		PreparedStatement stmt0 = conn.prepareStatement(sql0);
		stmt0.setInt(1, managerNo);
		stmt0.setString(2, newPassword);
		ResultSet rs = stmt0.executeQuery();
		if(rs.next()) { // 변경할 비밀번호가 이전에 사용했던 비밀번호와 같다면
			conn.rollback();
			return 1;
		}
		
			
		// 입력한 비밀번호가 원래 비밀번호와 일치하는지 대조하고 일치한다면 manager 테이블 데이터 수정(비밀번호 수정)
		String sql1 = """
					UPDATE manager SET manager_pw = password(?), updatedate = NOW() 
					WHERE manager_no = ? AND manager_pw = password(?)
					""";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, newPassword);
		stmt1.setInt(2, managerNo);
		stmt1.setString(3, currentPassword);
	
		int row1 = stmt1.executeUpdate();
		
		if(row1 != 1) {
			conn.rollback();
			return 2;
		}
		
		// 비밀번호를 수정하고 manager_pw_history 테이블에 비밀번호 변경 내역 추가
		String sql2 = """
					INSERT INTO manager_pw_history(manager_no, manager_pw, createdate) 
					VALUES(?, PASSWORD(?), NOW())
					""";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, managerNo);
		stmt2.setString(2, newPassword);
		int row2 = stmt2.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			return 3;
		}
		
		conn.commit();
		return 4;
		
	} 
 
   
    // managerOne 페이지
    public Manager getManagerOne(int manager_no) throws Exception {
    	ResultSet rs = db.executeQuery("SELECT * FROM manager WHERE manager_no = ?", manager_no);
    	Manager manager = null;
    	if (rs.next()) {
    		manager = converter.getManager(rs);
    	}
    	return manager;
    }
    
 // 매니저 아이디와 패스워드로 매니저 로그인
    public Manager getManagerByIdAndPassword(String managerId, String managerPw) throws Exception {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Connection conn = null;

        try {
            conn = db.getConnection(); // db 연결

            String sql = "SELECT * FROM manager WHERE manager_id = ? AND manager_pw = PASSWORD(?) AND active = 'Y' ";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, managerId);
            stmt.setString(2, managerPw);
            rs = stmt.executeQuery();

            if (rs.next()) {
                Manager manager = converter.getManager(rs);
                
                return manager;
            } else {
                return null; // 매니저가 없음
            }
        } finally {
            db.close(rs, stmt, conn); // DB 자원 닫기
        }
    }
    
 // 계정 비활성화 메서드
    public int deleteManager(String managerId) throws Exception {
        int row = 0;
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = db.getConnection();
            
            // 쿼리를 실행하기 전에 rs를 초기화하지 않도록 수정
            String sql = """
                    UPDATE manager SET
                    active = 'N'
                    WHERE manager_id = ?
                    """;
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, managerId);
            
            // executeUpdate를 호출하여 쿼리를 실행하고 업데이트된 행의 수를 얻음
            row = stmt.executeUpdate();
        } finally {
            // 사용한 자원을 닫음
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return row;
    }


}    
