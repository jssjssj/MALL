package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.Converter;
import util.DBUtil;
import vo.Customer;

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
						c.customer_no,
						c.customer_id,
						c.active,
						c.createdate,
						c.updatedate,
						cd.customer_addr_no
					FROM customer c
					INNER JOIN customer_addr cd
					ON c.customer_no = cd.customer_no
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
				rs.close();
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}	finally {
			stmt.close();
			conn.close();
		}
		return customer;
	} 
		
	// 가입
	public int insert(Map<String, Object> paramMap) throws Exception {
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
			stmt.setString(1, (String) paramMap.get("customerId"));
			stmt.setString(2, (String) paramMap.get("customerPw"));
			row = stmt.executeUpdate();
			if(row > 0) {
				String sql1 = "select LAST_INSERT_ID()"; // Statement.RETURN_GENERATED_KEYS 오류로 방법대체
				stmt1 = conn.prepareStatement(sql1);
				rs = stmt1.executeQuery();
				if(rs.next()) {
					paramMap.put("customerNo", rs.getInt("LAST_INSERT_ID()"));
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
				stmt2.setInt(1, (int) paramMap.get("customerNo"));
				stmt2.setString(2, (String) paramMap.get("customerName"));
				stmt2.setString(3, (String) paramMap.get("customerPhone"));				
				row2 = stmt2.executeUpdate();
			
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
				stmt3.setInt(1, (int) paramMap.get("customerNo"));
				stmt3.setString(2, (String) paramMap.get("address"));
				row3 = stmt3.executeUpdate();			
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
						DELETE FROM customer_addr
							WHERE customer_no = ?
						""";	
				stmt3 = conn.prepareStatement(sql3);
				stmt3.setInt(1, paramCustomer.getCustomerNo());
				row3 = stmt3.executeUpdate();
			}
			
			if(row > 0 && row2 > 0 && row3 > 0) {	// 전체 예외없이 성공 시 result == 1
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
	
	public int update(Map<String, Object> paramMap) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;		
		int result = 0;
		int row = 0; int row2 = 0;
		try {
			String sql = """
					UPDATE customer_addr SET
						address = ?,
						updatedate = NOW()
						WHERE customer_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, (String) paramMap.get("address"));
			stmt.setInt(2, (int) paramMap.get("customerNo"));
			row = stmt.executeUpdate();
			
			String sql2 = """
					UPDATE customer_detail SET
						customer_name = ?,
						customer_phone = ?,
						updatedate = NOW()
					WHERE customer_no = ?
					""";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, (String) paramMap.get("customerName"));
			stmt2.setString(2, (String) paramMap.get("customerPhone"));
			stmt2.setInt(3, (int) paramMap.get("customerNo"));
			row2 = stmt2.executeUpdate();
			
			if(row > 0 && row2 > 0) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt2.close();
			stmt.close();
			conn.close();
		}
		
			return result;
	}
	
	public int updatePw(Customer paramCustomer) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					UPDATE customer SET
						customer_pw = password(?),
						updatedate = NOW()
					WHERE customer_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerPw());
			stmt.setInt(2, paramCustomer.getCustomerNo());
			result = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	@SuppressWarnings("null")
	public Map<String, Object> customerOne(Customer paramCustomer) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Map<String, Object> resultMap = null;
		try {
			String sql = """
					SELECT
						c.customer_no customerNo,
						c.customer_id customerId,
						c.createdate, c.updatedate,
						
						cd.customer_name customerName,
						cd.customer_phone customerPhone,
						
						ca.address
					FROM customer c
					INNER JOIN customer_detail cd
					ON c.customer_no = cd.customer_no
					INNER JOIN customer_addr ca
					ON c.customer_no = ca.customer_no
					WHERE c.customer_no =  ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCustomer.getCustomerNo());
			rs = stmt.executeQuery();

			if(rs.next()) {
				resultMap = new HashMap<>();
				resultMap.put("customerNo", rs.getInt("customerNo"));
				resultMap.put("customerId", rs.getString("customerId"));
				resultMap.put("createdate", rs.getString("createdate"));
				resultMap.put("updatedate", rs.getString("updatedate"));
				resultMap.put("customerName", rs.getString("customerName"));
				resultMap.put("customerPhone", rs.getString("customerPhone"));
				resultMap.put("address", rs.getString("address"));
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return resultMap;
	}
	
	public Customer checkId(Customer paramCustomer) throws Exception {	// 가입 시 ID 중복여부 체크기능
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Customer customer = null;
		try {
			String sql = """
					SELECT
						active
					FROM customer
					WHERE customer_id = ?					
					AND active = 'Y'
					""";	// 타인정보를 찾아보는 것으로 다른 정보없이 활성화 여부만 출력 및 확인
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			rs = stmt.executeQuery();
			if(rs.next()) {
				converter = new Converter();
				customer = converter.getCustomer(rs);	
				rs.close();
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}	finally {
			stmt.close();
			conn.close();
		}
		return customer;
	} 
	
	public List<Map<String, Object>> allCustomer() throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<Map<String, Object>> list = null;
		
		try {
			String sql = """
					SELECT 
						c.customer_no,
						c.customer_id,
						c.active,
						c.createdate,
						ca.customer_addr_no,
						ca.address,
						cd.customer_name,
						cd.customer_phone
					FROM customer c
					LEFT OUTER JOIN customer_addr ca
					ON c.customer_no = ca.customer_no
					LEFT OUTER JOIN customer_detail cd
					ON c.customer_no = cd.customer_no						
					""";
			stmt = conn.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			list = new ArrayList<>();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("customerNo", rs.getInt("customer_no"));
				map.put("customerId", rs.getString("customer_id"));
				map.put("active", rs.getString("active"));
				map.put("createdate", rs.getString("createdate"));
				map.put("customerAddrNo", rs.getInt("customer_addr_no"));
				map.put("address", rs.getString("address"));
				map.put("customerName", rs.getString("customer_name"));
				map.put("customerPhone", rs.getString("customer_phone"));
				list.add(map);
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return list;
	}
}

        
           