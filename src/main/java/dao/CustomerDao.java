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
	

	public Customer customerOne(String customerId) throws Exception {
	    Customer customer = null;
	    DBUtil dbUtil = new DBUtil();

	    try (Connection conn = dbUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement("SELECT a.customer_no, a.customer_id, a.customer_pw, a.createdate, a.updatedate, a.active, "
	                 + "b.address, c.customer_name, c.customer_phone FROM customer a "
	                 + "INNER JOIN customer_addr b ON a.customer_no = b.customer_no "
	                 + "INNER JOIN customer_detail c ON a.customer_no = c.customer_no "
	                 + "WHERE a.customer_id = ?")) {
	        stmt.setString(1, customerId);

	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                customer = new Customer();
	                CustomerAddr customerAddr = new CustomerAddr();
	                CustomerDetail customerDetail = new CustomerDetail();

	                customer.setCustomerNo(rs.getInt("customer_no"));
	                customer.setCustomerId(rs.getString("customer_id"));
	                customer.setCustomerPw(rs.getString("customer_pw"));
	                customer.setCreatedate(rs.getString("createdate"));
	                customer.setUpdatedate(rs.getString("updatedate"));
	                customer.setActive(rs.getString("active"));
	                customerDetail.setCustomerName(rs.getString("customer_name"));
	                customerDetail.setCustomerPhone(rs.getString("customer_phone"));
	                customerAddr.setAddress(rs.getString("address"));

	                customer.setCustomerDetail(customerDetail);
	                customer.setCustomerAddr(customerAddr);
	            }
	        }
	    }

	    return customer;
	}
	
	
	
	// updateAction
	public int updateCustomer(Customer customer) throws Exception {
	    int row = 0;
	    // DB연결
	    DBUtil dbUtil = new DBUtil();
	    Connection conn = dbUtil.getConnection();

	    // 고객 정보 업데이트 쿼리
	    String updateCustomerQuery = "UPDATE customer SET customer_pw = PASSWORD(?), createdate = NOW(), updatedate = NOW() WHERE customer_no = ?";
	    try (PreparedStatement stmt = conn.prepareStatement(updateCustomerQuery)) {
	        stmt.setString(1, customer.getCustomerPw());
	        stmt.setInt(2, customer.getCustomerNo());
	        System.out.println(stmt + " <-- stmt updateCustomer()");
	        row = stmt.executeUpdate();
	    }

	    // 고객 상세 정보 업데이트 쿼리
	    String updateCustomerDetailQuery = "UPDATE customer_detail SET customer_name = ?, customer_phone = ? WHERE customer_no = ?";
	    try (PreparedStatement stmt = conn.prepareStatement(updateCustomerDetailQuery)) {
	        stmt.setString(1, customer.getCustomerDetail().getCustomerName());
	        stmt.setString(2, customer.getCustomerDetail().getCustomerPhone());
	        stmt.setInt(3, customer.getCustomerNo());
	        System.out.println(stmt + " <-- stmt updateCustomerDetail()");
	        stmt.executeUpdate();
	    }

	    // 고객 주소 정보 업데이트 쿼리
	    String updateCustomerAddrQuery = "UPDATE customer_addr SET address = ? WHERE customer_no = ?";
	    try (PreparedStatement stmt = conn.prepareStatement(updateCustomerAddrQuery)) {
	        stmt.setString(1, customer.getCustomerAddr().getAddress());
	        stmt.setInt(2, customer.getCustomerNo());
	        System.out.println(stmt + " <-- stmt updateCustomerAddr()");
	        stmt.executeUpdate();
	    }

	    return row;
	}
	
	public List<Customer> selectCustomer() throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        try {
            String sql = "SELECT a.customer_no , a.customer_id , a.customer_pw , a.createdate , a.updatedate , a.active ,"
            		+ "b.address , c.customer_name , c.customer_phone FROM customer a INNER JOIN customer_addr b"
            		+ "ON a.customer_no = b.customer_no INNER JOIN customer_detail c ON a.customer_no = c.customer_no";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            List<Customer> customers = new ArrayList<>();

            while (rs.next()) {
                Customer customer = new Customer();
                CustomerAddr customerAddr = new CustomerAddr();
                CustomerDetail customerDetail = new CustomerDetail();
                customer.setCustomerNo(rs.getInt("customer_no"));
                customer.setCustomerId(rs.getString("customer_id"));
                customer.setCustomerPw(rs.getString("customer_pw"));
                customerDetail.setCustomerName(rs.getString("customer_name"));
                customerDetail.setCustomerPhone(rs.getString("customer_phone"));
                customerAddr.setAddress(rs.getString("address"));
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















