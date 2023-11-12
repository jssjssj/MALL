package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

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


 // 매니저 정보 업데이트 (비밀번호 이력 저장)
    public boolean updateManagerPassword(int managerNo, String currentPassword, String newPassword) throws Exception {
        Connection conn = db.getConnection();
        PreparedStatement stmt = null;

        try {
            conn.setAutoCommit(false);

            // 현재 비밀번호 확인
            String selectPasswordSql = "SELECT manager_pw FROM manager WHERE manager_no = ?";
            stmt = conn.prepareStatement(selectPasswordSql);
            stmt.setInt(1, managerNo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("manager_pw");
                if (currentPassword.equals(storedPassword)) {
                    // 현재 비밀번호가 일치하면 이전 비밀번호를 manager_pw_history에 저장
                    String insertHistorySql = "INSERT INTO manager_pw_history (manager_no, manager_pw, createdate) VALUES (?, ?, NOW())";
                    PreparedStatement stmtHistory = conn.prepareStatement(insertHistorySql);
                    stmtHistory.setInt(1, managerNo);
                    stmtHistory.setString(2, storedPassword);
                    stmtHistory.executeUpdate();

                    // 새로운 비밀번호로 업데이트
                    String updatePasswordSql = "UPDATE manager SET manager_pw = ? WHERE manager_no = ?";
                    stmt = conn.prepareStatement(updatePasswordSql);
                    stmt.setString(1, newPassword);
                    stmt.setInt(2, managerNo);
                    stmt.executeUpdate();

                    conn.commit();
                    return true; // 비밀번호 업데이트 성공
                }
            }

            return false; // 현재 비밀번호가 일치하지 않음

        } catch (Exception e) {
            if (conn != null) {
                conn.rollback();
            }
            e.printStackTrace();
            return false; // 비밀번호 업데이트 실패
        } finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

 // 매니저의 이전 비밀번호 목록 가져오기
    public List<String> getManagerPasswordHistory(int managerNo) throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String sql = "SELECT manager_pw FROM manager_pw_history WHERE manager_no = ? ORDER BY createdate DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, managerNo);

            rs = stmt.executeQuery();

            List<String> passwordHistory = new ArrayList<>();
            while (rs.next()) {
                passwordHistory.add(rs.getString("manager_pw"));
            }

            return passwordHistory;
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



 // 매니저 정보 조회
    public List<Manager> selectManager() throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        try {
            String sql = "SELECT * FROM manager";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            List<Manager> managers = new ArrayList<>();

            while (rs.next()) {
                Manager manager = converter.getManager(rs);
                managers.add(manager);
            }

            return managers;
        } finally {
            conn.close(); // 연결 닫기
        }
    }
    
    public Manager getManagerOne(int manager_no) throws Exception {
    	ResultSet rs = db.executeQuery("SELECT * FROM manager WHERE manager_no = ?", manager_no);
    	Manager manager = null;
    	if (rs.next()) {
    		manager = converter.getManager(rs);
    	}
    	return manager;
    }
    
 // 매니저 아이디와 패스워드로 매니저 조회
    public Manager getManagerByIdAndPassword(String managerId, String managerPw) throws Exception {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        DBUtil dbUtil = new DBUtil();
        Connection conn = null;

        try {
            conn = dbUtil.getConnection(); // db 연결

            String sql = "SELECT * FROM manager WHERE manager_id = ? AND manager_pw = PASSWORD(?)";
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
            dbUtil.close(rs, stmt, conn); // DB 자원 닫기
        }
    }

}    
