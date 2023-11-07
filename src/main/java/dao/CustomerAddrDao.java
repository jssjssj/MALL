package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.*;

public class CustomerAddrDao {
	
	
	//updateForm

	public Customer selectCustomerOne(int customerAddrNo) throws Exception {
		Customer customer = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		String sql = "SELECT customer_addr_no , customer_no , address , createdate , updatedate FROM customer_addr WHERE customer_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, customerAddrNo);
		System.out.println(stmt + " <-- stmt selectOne()");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			customer = new Customer();
			customer.setCustomerId(rs.getString("no"));
		}
		return customer;
	}
	
	
	//updateAction
	
	public int updateCustomer(CustomerAddr customerAddr) throws Exception {
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "UPDATE customer_addr SET address = ? , updatedate = NOW() WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerAddr.getAddress());
		stmt.setString(2, customerAddr.getUpdatedate());
		stmt.setInt(3, customerAddr.getCustomerNo());
		System.out.println(stmt + " <-- stmt updateCustomer()");
		row = stmt.executeUpdate();
		return row;		
	}
	
	//insertAction
	
		public int insertCustomer(CustomerAddr customerAddr) throws Exception {
			int row = 0;
			// DB연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();		
			String sql = "INSERT INTO customer_addr(customer_no , address , createdate , updatedate) VALUES (? , ? , NOW() , NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerAddr.getCustomerNo());
			stmt.setString(2, customerAddr.getAddress());
			stmt.setString(3, customerAddr.getCreatedate());
			stmt.setString(4, customerAddr.getUpdatedate());
			System.out.println(stmt + " <-- stmt insertCustomer()");
			row = stmt.executeUpdate();
			return row;		
		}
}
