package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.Converter;
import util.DBUtil;
import vo.Customer;
import vo.CustomerPwHistory;

public class CustomerPwHistoryDao extends ClassDao {
	Converter converter = null;
	
	public int insertHistory(Customer paramCustomer) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					INSERT INTO customer_pw_history (
						customer_no,
						customer_pw
					) VALUES (
						?,
						password(?)
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCustomer.getCustomerNo());
			stmt.setString(2, paramCustomer.getCustomerPw());
			
			result = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public List<CustomerPwHistory> selectPw (Customer paramCustomer) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<CustomerPwHistory> resultList = null;
		try {
			String sql = """
					SELECT * FROM customer_pw_history
						WHERE customer_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCustomer.getCustomerNo());
			
			rs = stmt.executeQuery();
			resultList = new ArrayList<>();
			while(rs.next()) {
				converter = new Converter();
				CustomerPwHistory pw = converter.getCustomerPwHistory(rs);
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
