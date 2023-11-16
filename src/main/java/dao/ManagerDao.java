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


 // 패스워드를 해싱하여 저장
    private static String hashPassword(String password, byte[] salt) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest(password.getBytes());

            byte[] combined = new byte[salt.length + hashedPassword.length];
            System.arraycopy(salt, 0, combined, 0, salt.length);
            System.arraycopy(hashedPassword, 0, combined, salt.length, hashedPassword.length);

            return Base64.getEncoder().encodeToString(combined);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    // 입력한 패스워드와 저장된 해싱된 패스워드의 일치 여부 확인
    private static boolean checkPassword(String inputPassword, String storedPassword) {
        try {
            byte[] combined = Base64.getDecoder().decode(storedPassword);
            byte[] salt = Arrays.copyOfRange(combined, 0, 16);
            byte[] hashedInputPassword = Arrays.copyOfRange(combined, 16, combined.length);

            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] hashedPassword = md.digest(inputPassword.getBytes());

            return Arrays.equals(hashedInputPassword, hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 매니저 정보 업데이트 (비밀번호 이력 저장)
    public boolean updateManagerPassword(int managerNo, String currentPassword, String newPassword) throws Exception {
        Connection conn = db.getConnection();
        PreparedStatement stmt = null;

        try {
            conn.setAutoCommit(false);

            // 현재 비밀번호 확인
            String selectPasswordSql = "SELECT manager_pw, salt FROM manager WHERE manager_no = ?";
            stmt = conn.prepareStatement(selectPasswordSql);
            stmt.setInt(1, managerNo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("manager_pw");
                byte[] salt = Base64.getDecoder().decode(rs.getString("salt"));

                if (checkPassword(currentPassword, storedPassword)) {
                    // 현재 비밀번호가 일치하면 이전 비밀번호를 manager_pw_history에 저장
                    String insertHistorySql = "INSERT INTO manager_pw_history (manager_no, manager_pw, createdate) VALUES (?, ?, NOW())";
                    PreparedStatement stmtHistory = conn.prepareStatement(insertHistorySql);
                    stmtHistory.setInt(1, managerNo);
                    stmtHistory.setString(2, storedPassword);
                    stmtHistory.executeUpdate();

                    // 새로운 비밀번호로 업데이트
                    String updatePasswordSql = "UPDATE manager SET manager_pw = ?, salt = ? WHERE manager_no = ?";
                    stmt = conn.prepareStatement(updatePasswordSql);

                    // 새로운 salt 생성
                    byte[] newSalt = new byte[16];
                    new SecureRandom().nextBytes(newSalt);

                    stmt.setString(1, hashPassword(newPassword, newSalt));
                    stmt.setString(2, Base64.getEncoder().encodeToString(newSalt));
                    stmt.setInt(3, managerNo);

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
        Connection conn = db.getConnection();

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
