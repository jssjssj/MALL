package dao;
import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.Manager;

public class ManagerDao {
    /* 디버깅 색깔 지정 */ 
    // ANSI CODE    
    final String RESET = "\u001B[0m"; 
    final String KIM = "\u001B[42m";
    final String PARK = "\u001B[44m";

    // 매니저 추가 (비밀번호 이력 저장)
    public int insertManager(Manager insertManager) throws Exception {
        // db연결
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        try {
            // 트랜잭션 시작
            conn.setAutoCommit(false);

            // 비밀번호를 managerPwHistory 테이블에 저장
            String insertHistorySql = """
            							INSERT INTO managerPwHistory
            							(manager_no, manager_pw, createdate)
            							VALUES(LAST_INSERT_ID(), ?, now()) 
            							""";
            PreparedStatement historyStmt = conn.prepareStatement(insertHistorySql);
            historyStmt.setString(1, insertManager.getManagerPw());
            historyStmt.executeUpdate();

            // 매니저 정보 추가
            String insertSql = "INSERT INTO manager"
			            		+ "(manager_id, manager_pw, manager_name, createdate, updatedate, active) "
			            		+ "VALUES(?, ?, ?, now(), now(), ?)";
            PreparedStatement stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, insertManager.getManagerId());
            stmt.setString(2, insertManager.getManagerPw());
            stmt.setString(3, insertManager.getManagerName());
            stmt.setString(4, insertManager.getActive());
            int row = stmt.executeUpdate();

            // 트랜잭션 커밋
            conn.commit();

            if (row == 1) {
                System.out.println("생성 성공");
            } else {
                System.out.println("생성 실패");
            }

            return row;
        } catch (Exception e) {
            // 트랜잭션 롤백
            conn.rollback();
            e.printStackTrace();
            return 0;
        } finally {
            conn.setAutoCommit(true);
        }
    }

    // 매니저 정보 업데이트 (비밀번호 이력 저장)
    public int updateManager(Manager updateManager) throws Exception {
        // db연결
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        try {
            // 트랜잭션 시작
            conn.setAutoCommit(false);

            // 이전 비밀번호를 managerPwHistory 테이블에 저장
            String insertHistorySql = "INSERT INTO managerPwHistory"
				            		+ "(manager_no, manager_pw, createdate) "
				            		+ "VALUES((SELECT manager_no FROM manager WHERE manager_id=?), "
				            		+ "(SELECT manager_pw FROM manager WHERE manager_id=?), now())";
            PreparedStatement historyStmt = conn.prepareStatement(insertHistorySql);
            historyStmt.setString(1, updateManager.getManagerId());
            historyStmt.setString(2, updateManager.getManagerId());
            historyStmt.executeUpdate();

            // 매니저 비밀번호 업데이트
            String updateSql = "UPDATE manager SET manager_pw=?, "
			            		+ "manager_name=?, updatedate=now(), active=? "
			            		+ "WHERE manager_id=?";
            PreparedStatement stmt = conn.prepareStatement(updateSql);
            stmt.setString(1, updateManager.getManagerPw());
            stmt.setString(2, updateManager.getManagerName());
            stmt.setString(3, updateManager.getActive());
            stmt.setString(4, updateManager.getManagerId());
            int row = stmt.executeUpdate();

            // 트랜잭션 커밋
            conn.commit();

            if (row == 1) {
                System.out.println("업데이트 성공");
            } else {
                System.out.println("업데이트 실패");
            }

            return row;
        } catch (Exception e) {
            // 트랜잭션 롤백
            conn.rollback();
            e.printStackTrace();
            return 0;
        } finally {
            conn.setAutoCommit(true);
        }
    }

 // 매니저 정보 삭제
    public int deleteManager(String managerId) throws Exception {
    	//db 연결
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        try {
            String sql = "DELETE FROM manager WHERE manager_id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, managerId);

            int row = stmt.executeUpdate();

            if (row == 1) {
                System.out.println("삭제 성공");
            } else {
                System.out.println("삭제 실패");
            }

            return row;
        } finally {
            conn.close(); // 연결 닫기
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
                Manager manager = new Manager();
                manager.setManagerNo(rs.getInt("manager_no"));
                manager.setManagerId(rs.getString("manager_id"));
                manager.setManagerPw(rs.getString("manager_pw"));
                manager.setManagerName(rs.getString("manager_name"));
                manager.setCreatedate(rs.getString("createdate"));
                manager.setUpdatedate(rs.getString("updatedate"));
                manager.setActive(rs.getString("active"));
                managers.add(manager);
            }

            return managers;
        } finally {
            conn.close(); // 연결 닫기
        }
    }
}    
