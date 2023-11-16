package dao;


import java.sql.*;
import java.util.*;
import vo.*;


public class CustomerPwHistoryDao extends ClassDao {
	public List<CustomerPwHistory> select(String customerId) throws Exception {
		int customerNo = 0;
		String customerPw = null;
		CustomerPwHistory customerPwHistory = null;
		List<CustomerPwHistory> cph = null;		
		Connection conn = db.getConnection();		
		String sql0 = """
				SELECT customer_no FROM customer WHERE customer_id = ?
				""";
		PreparedStatement stmt0 = conn.prepareStatement(sql0);
		stmt0.setString(1, customerId);
		ResultSet rs0 = stmt0.executeQuery();
		if(rs0.next()) {
			cph = new ArrayList<>();
			customerPwHistory = new CustomerPwHistory();
			customerNo = rs0.getInt("customer_no");
		String sql = """				
				SELECT customer_pw_history_no ,customer_no , 
				customer_pw , createdate FROM customer_pw_history
				WHERE customer_no = ?
				""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);		
		ResultSet rs = stmt.executeQuery();		
		while(rs.next()) {
			customerPwHistory.setCustomerPwHistoryNo(rs.getInt("customer_pw_history_no"));
			customerPwHistory.setCustomerNo(rs.getInt("customer_no"));
			customerPwHistory.setCustomerPw(rs.getString("customer_pw"));
			customerPwHistory.setCreatedate(rs.getString("createdate"));
			cph.add(customerPwHistory);
			}			
		}
		return cph;
	}
	
}
