package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.*;

public class CustomerAddrDao {
	
	
	//updateForm

	public Customer selectCustomerAddrOne(int customerAddrNo) throws Exception {
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
	
	public int updateCustomerAddr(CustomerAddr customerAddr) throws Exception {
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "UPDATE customer_addr SET address = ? , updatedate = NOW() WHERE customer_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerAddr.getAddress());
		stmt.setInt(2, customerAddr.getCustomerNo());
		System.out.println(stmt + " <-- stmt updateCustomer()");
		row = stmt.executeUpdate();
		return row;		
	}
	
	//insertAction
	
		public int insertCustomerAddr(CustomerAddr customerAddr) throws Exception {
			int row = 0;
			// DB연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();		
			String sql = "INSERT INTO customer_addr"
					+ "(customer_no ,address , createdate , updatedate) "
					+ "VALUES (LAST_INSERT_ID(), ? , NOW() , NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerAddr.getAddress());
			System.out.println(stmt + " <-- stmt insertCustomer()");
			row = stmt.executeUpdate();
			return row;		
		}
}
