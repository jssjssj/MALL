package util;

import java.sql.Connection;
import java.sql.DriverManager;
	// DB 연결 클래스 2023.11.02
public class DBUtil {
		public Connection getConnection() throws Exception {
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mariadb://localhost:3306/mall", "root", "java1234");
			return conn;
		}
	}
