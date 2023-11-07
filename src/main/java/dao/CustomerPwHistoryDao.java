package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBUtil;
import vo.*;

public class CustomerPwHistoryDao {
	
	// insert -> 비번 변경 시 CustomerDao update항목과 동시발생
	public int insertCustomerPwHistory(CustomerPwHistory customerPwHistory) throws Exception {
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "INSERT INTO customer_pw_history(customer_no , customer_pw , createdate) VALUES (? , ? , NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerPwHistory.getCustomerNo());
		stmt.setString(2, customerPwHistory.getCustomerPw());
		stmt.setString(3, customerPwHistory.getCreatedate());
		System.out.println(stmt + " <-- stmt insertCustomerPwHistory()");
		row = stmt.executeUpdate();
		return row;
	}
	
	// delete
	public int deleteTest(int customerPwHistoryNo) throws Exception{
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();				
		String sql = "DELETE FROM customer_pw_history WHERE customer_pw_history_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerPwHistoryNo);
		System.out.println(stmt + " <-- stmt deleteTest()");
		row = stmt.executeUpdate();
		return row;  
	}
}
