package util;

import java.sql.*;
import java.sql.DriverManager;
	// DB 연결 클래스 2023.11.02
public class DBUtil {
		public Connection getConnection() throws Exception {
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mariadb://localhost:3306/mall", "root", "java1234");
			return conn;
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
