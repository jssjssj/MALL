package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class ManagerDao {
    /* 디버깅 색깔 지정 */ 
    // ANSI CODE    
    final String RESET = "\u001B[0m"; 
    final String KIM = "\u001B[42m";
    final String PARK = "\u001B[44m";

 // 매니저 추가

    public int insertManager(Manager manager) throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
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
            String insertManagerSql = "INSERT INTO manager"
                + "(manager_id, manager_pw, manager_name, createdate, updatedate) "
                + "VALUES(?, PASSWORD(?), ?, NOW(), NOW())";

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
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
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
                Map<String, Object> managerData = new HashMap<>();
                managerData.put("managerNo", rs.getInt("manager_no"));
                managerData.put("managerId", rs.getString("manager_id"));
                managerData.put("managerPw", rs.getString("manager_pw"));
                managerData.put("managerName", rs.getString("manager_name"));
                managerData.put("createdate", rs.getString("createdate"));
                managerData.put("updatedate", rs.getString("updatedate"));
                managerData.put("active", rs.getString("active"));

                Manager manager = createManagerFromMap(managerData);
                managers.add(manager);
            }

            return managers;
        } finally {
            conn.close(); // 연결 닫기
        }
    }

    private Manager createManagerFromMap(Map<String, Object> managerData) {
        Manager manager = new Manager();
        manager.setManagerNo((Integer) managerData.get("managerNo"));
        manager.setManagerId((String) managerData.get("managerId"));
        manager.setManagerPw((String) managerData.get("managerPw"));
        manager.setManagerName((String) managerData.get("managerName"));
        manager.setCreatedate((String) managerData.get("createdate"));
        manager.setUpdatedate((String) managerData.get("updatedate"));
        manager.setActive((String) managerData.get("active"));
        return manager;
    }

}    
