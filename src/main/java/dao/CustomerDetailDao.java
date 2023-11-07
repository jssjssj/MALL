package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.*;

public class CustomerDetailDao {
	
	//insertAction
	public int insertCustomerDetail(CustomerDetail customerDetail) throws Exception {
		int row = 0;
		// DB연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();		
		String sql = "INSERT INTO customer_detail(customer_name , customer_phone , createdate , updatedate) VALUES (? , ? , NOW() , NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerDetail.getCustomerName());
		stmt.setString(2, customerDetail.getCustomerPhone());
		stmt.setString(3, customerDetail.getCreatedate());
		stmt.setString(4, customerDetail.getUpdatedate());
		System.out.println(stmt + " <-- stmt insertCustomerDetail()");
		row = stmt.executeUpdate();
		return row;		
	}
	
	//updateForm

		public CustomerDetail selectCustomerDetailOne(int customerNo) throws Exception {
			CustomerDetail customerDetail = null;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();	
			String sql = "SELECT customer_no , customer_name , customer_phone , createdate , updatedate FROM customer_detail WHERE customer_no=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, customerDetail.getCustomerNo());
			System.out.println(stmt + " <-- stmt selectOne()");
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				customerDetail = new CustomerDetail();
				customerDetail.setCustomerNo(rs.getInt("customerNo"));
				customerDetail.setCustomerName(rs.getString("customerName"));
				customerDetail.setCustomerPhone(rs.getString("customerPhone"));
				customerDetail.setCreatedate(rs.getString("createdate"));
				customerDetail.setUpdatedate(rs.getString("updatedate"));
			}
			return customerDetail;
		}
		
		
		//updateAction
		
		public int updateCustomerDetail(CustomerDetail customerDetail) throws Exception {
			int row = 0;
			// DB연결
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();		
			String sql = "UPDATE customer_detail SET customer_name = ? , customer_phone = ? , updatedate = NOW() WHERE customer_no = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerDetail.getCustomerName());
			stmt.setString(2, customerDetail.getCustomerPhone());
			stmt.setString(3, customerDetail.getUpdatedate());
			stmt.setInt(4, customerDetail.getCustomerNo());
			System.out.println(stmt + " <-- stmt updateCustomer()");
			row = stmt.executeUpdate();
			return row;		
		}
}
