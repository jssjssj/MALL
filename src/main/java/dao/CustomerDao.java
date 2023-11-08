package dao;

import java.sql.*;


import util.DBUtil;
import vo.Customer;

	
public class CustomerDao {
	//insertAction
	public int insertCustomer(Customer customer) throws Exception {
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = """
				INSERT INTO customer(customer_id , customer_pw , createdate , updatedate )
				VALUES (? , PASSWORD(?) , NOW() , NOW() )
				""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		int row = 0;
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		System.out.println(stmt + " <-- stmt insertCustomer()");
		row = stmt.executeUpdate();
		return row;		
	}
	

	//deleteAction
	public int deleteCustomer(int customerNo) throws Exception {
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "DELETE FROM customer WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(stmt + " <-- stmt deleteCustomer()");
		row = stmt.executeUpdate();
		return row;		
	}

	// updateForm
	public Customer selectCustomerOne(int customerNo) throws Exception {
		Customer customer = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		String sql = "SELECT customer_id, createdate , updatedate FROM customer WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerNo);
		System.out.println(stmt + " <-- stmt selectOne()");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			customer = new Customer();
			customer.setCustomerId(rs.getString("customerNo"));
			customer.setCreatedate(rs.getString("createdate"));
			customer.setUpdatedate(rs.getString("updatedate"));
		}
		return customer;
	}
	
	//updateAction
	public int updateCustomer(Customer customer) throws Exception {
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "UPDATE customer SET customer_pw = PASSWORD(?) WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerPw());
		stmt.setInt(2, customer.getCustomerNo());
		System.out.println(stmt + " <-- stmt updateCustomer()");
		row = stmt.executeUpdate();
		return row;		
	}
	

	
}















