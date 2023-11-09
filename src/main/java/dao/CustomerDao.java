package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import vo.*;

	
public class CustomerDao {
	
		
	public int insertCustomer(Customer customer, CustomerDetail customerDetail, CustomerAddr customerAddr ) {
	    try {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();
	        conn.setAutoCommit(false);
	        
	     // 중복 아이디 확인
            String checkSql = "SELECT customer_no FROM customer WHERE customer_id = ?";
            PreparedStatement stmtCheckid = conn.prepareStatement(checkSql);
            stmtCheckid.setString(1, customer.getCustomerId());
            ResultSet rs = stmtCheckid.executeQuery();
            
            if (rs.next()) {
                // 이미 존재하는 아이디가 있을 경우 중복으로 처리
                return -1;
            }

	        String sql1 = "INSERT INTO customer"
	                + "(customer_id, customer_pw, createdate, updatedate, active) "
	                + "VALUES(?, PASSWORD(?), NOW(), NOW(), 'Y')";
	        PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
	        stmt1.setString(1, customer.getCustomerId());
	        stmt1.setString(2, customer.getCustomerPw());
	        System.out.println(stmt1 + " <-- stmt insertCustomer()");
	        stmt1.executeUpdate();

	        ResultSet rs1 = stmt1.getGeneratedKeys();
	        int customerNo = 0; // 초기화된 값
	        if (rs1.next()) {
	            customerNo = rs1.getInt(1);
	        } else {
	            conn.rollback();
	            return -1;
	        }

	        String sql2 = "INSERT INTO customer_detail"
	                + "(customer_no, customer_name, customer_phone, createdate, updatedate) "
	                + "VALUES(?,?,?, NOW(), NOW())";
	        PreparedStatement stmt2 = conn.prepareStatement(sql2);
	        stmt2.setInt(1, customerNo); // 위 SQL문에서 얻은 customer_no 설정.
	        stmt2.setString(2, customerDetail.getCustomerName());
	        stmt2.setString(3, customerDetail.getCustomerPhone());
	        System.out.println(stmt2 + "<-- stmt2 insert테스트");

	        int row2 = stmt2.executeUpdate();
	        if (row2 != 1) {
	            conn.rollback();
	            return -1;
	        }

	        String sql3 = "INSERT INTO customer_addr"
	                + "(customer_no, address, createdate, updatedate) "
	                + "VALUES(?,?,NOW(),NOW())";
	        PreparedStatement stmt3 = conn.prepareStatement(sql3);
	        stmt3.setInt(1, customerNo); // 위 SQL문에서 얻은 customer_no 설정.
	        stmt3.setString(2, customerAddr.getAddress());
	        System.out.println(stmt3 + "<-- stmt3 insert테스트");

	        int row3 = stmt3.executeUpdate();
	        if (row3 != 1) {
	            conn.rollback();
	            return -1;
	        }

	        conn.commit();
	        stmt1.close();
	        rs1.close();
	        stmt2.close();
	        stmt3.close();
	        return customerNo;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -1;
	    }
	}


	// customerOne
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
	
	// updateAction
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
	
	public List<Customer> selectCustomer() throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        try {
            String sql = "SELECT a.customer_no , a.customer_id , a.customer_pw , a.createdate , a.updatedate , a.active ,"
            		+ "b.address , c.customer_name , c.customer_phone FROM customer a INNER JOIN customer_addr b"
            		+ "on a.customer_no = b.customer_no INNER JOIN a.customer_no = c.customer_no";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            List<Customer> customers = new ArrayList<>();

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerNo(rs.getInt("customer_no"));
                customer.setCustomerId(rs.getString("customer_id"));
                customer.setCustomerPw(rs.getString("customer_pw"));
                customer.setCreatedate(rs.getString("createdate"));
                customer.setUpdatedate(rs.getString("updatedate"));
                customer.setActive(rs.getString("active"));
                customers.add(customer);
            }

            return customers;
        } finally {
            conn.close(); // 연결 닫기
        }
    }
	
}















