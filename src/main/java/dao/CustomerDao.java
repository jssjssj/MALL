package dao;


import java.sql.*;

import util.*;
import vo.*;

public class CustomerDao extends ClassDao {
	Converter converter = null;
	
	public Customer login(Customer paramCustomer) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Customer customer = null;
		try {
			String sql = """
					SELECT
						customer_id,
						customer_active,
						createdate,
						updatedate
					FROM customer
					WHERE customer_id = ?
					AND customer_pw = password(?)
					AND active = 'Y'
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPw());
			rs = stmt.executeQuery();
			if(rs.next()) {
				converter = new Converter();
				customer = converter.getCustomer(rs);			
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}	finally {
			rs.close();
			stmt.close();
			conn.close();
		}
		return customer;
	} 
		
	// 가입
	public int insert(Customer paramCustomer, CustomerDetail paramCustomerDetail, 
							CustomerAddr paramCustomerAddr) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		
		ResultSet rs = null;
		int result = 0;
		int row = 0;	int row2 = 0; 	int row3 = 0;
		try {			
			String sql = """
					INSERT INTO customer (
						customer_id,
						customer_pw
					) VALUES (
						?,
						password(?)						
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPw());
			row = stmt.executeUpdate();
			if(row > 0) {
				String sql1 = "select LAST_INSERT_ID()";
				stmt1 = conn.prepareStatement(sql1);
				rs = stmt1.executeQuery();
				if(rs.next()) {
					paramCustomer.setCustomerNo(rs.getInt("LAST_INSERT_ID()"));
				}				
				
				String sql2 = """
					INSERT INTO customer_detail (
						customer_no,
						customer_name,
						customer_phone
					) VALUES (
						?,
						?,
						?
					)
						""";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setInt(1, paramCustomer.getCustomerNo());
				stmt2.setString(2, paramCustomerDetail.getCustomerName());
				stmt2.setString(3, paramCustomerDetail.getCustomerPhone());				
				row2 = stmt2.executeUpdate();
			if(row2 > 0) {
				String sql3 = """
						INSERT INTO customer_addr (
							customer_no,
							address
						) VALUES (
							?,
							?
						)
							""";
				stmt3 = conn.prepareStatement(sql3);
				stmt3.setInt(1, paramCustomer.getCustomerNo());
				stmt3.setString(2, paramCustomerAddr.getAddress());
				row3 = stmt3.executeUpdate();
			}
			}
			if(row > 0 && row2 > 0 && row3 > 0) {
				result = 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			stmt3.close();
			stmt2.close();
			stmt.close();
			conn.close();
		}	
		
		return result;
	}
	
	public int delete(Customer paramCustomer) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		
		int result = 0;
		int row = 0;	int row2 = 0;	int row3 = 0;
		try {
			String sql = """
					UPDATE customer SET
						active = 'N'
					WHERE customer_no = ?
						""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCustomer.getCustomerNo());
			
			row = stmt.executeUpdate();
			if(row > 0) {
				String sql2 = """
						DELETE FROM customer_detail
							WHERE customer_no = ?
						""";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setInt(1, paramCustomer.getCustomerNo());
				row2 = stmt2.executeUpdate();
				
				String sql3 = """
						DELETE FROM customer_detail
							WHERE customer_no = ?
						""";	
				stmt3 = conn.prepareStatement(sql3);
				stmt3.setInt(1, paramCustomer.getCustomerNo());
				row3 = stmt3.executeUpdate();
			}
			
			if(row > 0 && row2 > 0 && row3 > 0) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt3.close();
			stmt2.close();
			stmt.close();
			conn.close();
		}
			return result;
	}
	

}

        
           