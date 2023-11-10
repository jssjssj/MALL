package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// DB 연결 클래스 2023.11.02
public class DBUtil {

   public Connection getConnection() throws Exception {
      Class.forName("org.mariadb.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall", "root", "java1234");
      return conn;
   }

   public ResultSet executeQuery(String sql, Object... params) {
      Connection conn = null;
      PreparedStatement stmt = null;
      ResultSet result = null;
      try {
         conn = getConnection();
         stmt = conn.prepareStatement(sql);
         for (int i = 1; i <= params.length; i++) {
            stmt.setObject(i, params[i - 1]);
         }
         result = stmt.executeQuery();
      } catch (Exception e) {
         // TODO 자동 생성된 catch 블록
         e.printStackTrace();
         return result;
      } finally {
         // 자원 종료
         close(null, stmt, conn);
      }
      
      return result;
   }

   // DBUtil 클래스의 close 메서드
   public void close(ResultSet rs, Statement stmt, Connection conn) {
      try {
         if (rs != null) {
            rs.close();
         }
         if (stmt != null) {
            stmt.close();
         }
         if (conn != null) {
            conn.close();
         }
      } catch (SQLException e) {
         e.printStackTrace(); // 또는 로깅 등으로 변경
      }
   }
}