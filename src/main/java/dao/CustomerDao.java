package dao;

import java.security.*;
import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class CustomerDao {

	public int insertCustomer(Customer customer, CustomerDetail customerDetail, CustomerAddr customerAddr) {
	    int customerNo = 0; // 초기화된 값

	    try {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();
	        conn.setAutoCommit(false);

	        // 중복 아이디 확인
	        String checkSql = "SELECT customer_no FROM customer WHERE customer_id = ?";
	        try (PreparedStatement stmtCheckid = conn.prepareStatement(checkSql)) {
	            stmtCheckid.setString(1, customer.getCustomerId());
	            try (ResultSet rs = stmtCheckid.executeQuery()) {
	                if (rs.next()) {
	                    // 이미 존재하는 아이디가 있을 경우 중복으로 처리
	                    conn.rollback();
	                    return -1;
	                }
	            }
	        }

	        // 변경된 부분: 평문 비밀번호 직접 저장
	        String sql1 = "INSERT INTO customer"
	                + "(customer_id, customer_pw, createdate, updatedate, active) "
	                + "VALUES(?, ?, NOW(), NOW(), 'Y')";
	        try (PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS)) {
	            stmt1.setString(1, customer.getCustomerId());
	            stmt1.setString(2, customer.getCustomerPw()); // 평문으로 저장
	            stmt1.executeUpdate();

	            try (ResultSet rs1 = stmt1.getGeneratedKeys()) {
	                if (rs1.next()) {
	                    customerNo = rs1.getInt(1);
	                } else {
	                    conn.rollback();
	                    return -1;
	                }
	            }
	        }

	        String sql2 = "INSERT INTO customer_detail"
	                + "(customer_no, customer_name, customer_phone, createdate, updatedate) "
	                + "VALUES(?,?,?, NOW(), NOW())";
	        try (PreparedStatement stmt2 = conn.prepareStatement(sql2)) {
	            stmt2.setInt(1, customerNo);
	            stmt2.setString(2, customerDetail.getCustomerName());
	            stmt2.setString(3, customerDetail.getCustomerPhone());

	            int row2 = stmt2.executeUpdate();
	            if (row2 != 1) {
	                conn.rollback();
	                return -1;
	            }
	        }

	        String sql3 = "INSERT INTO customer_addr"
	                + "(customer_no, address, createdate, updatedate) "
	                + "VALUES(?,?,NOW(),NOW())";
	        try (PreparedStatement stmt3 = conn.prepareStatement(sql3)) {
	            stmt3.setInt(1, customerNo);
	            stmt3.setString(2, customerAddr.getAddress());

	            int row3 = stmt3.executeUpdate();
	            if (row3 != 1) {
	                conn.rollback();
	                return -1;
	            }
	        }

	        conn.commit();
	        return customerNo;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -1;
	    }
	}
	
	
	public Customer customerOne(String customerId) throws Exception {
	    Customer customer = null;
	    DBUtil dbUtil = new DBUtil();
	    Connection conn = dbUtil.getConnection();
	    String sql = "SELECT a.customer_no, a.customer_id, a.customer_pw, a.createdate, a.updatedate, a.active, "
	            + "b.address, c.customer_name, c.customer_phone FROM customer a "
	            + "INNER JOIN customer_addr b ON a.customer_no = b.customer_no "
	            + "INNER JOIN customer_detail c ON a.customer_no = c.customer_no "
	            + "WHERE a.customer_id = ?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, customerId);

	    try (ResultSet rs = stmt.executeQuery()) {
	        if (rs.next()) {
	            customer = new Customer();
	            CustomerAddr customerAddr = new CustomerAddr();
	            CustomerDetail customerDetail = new CustomerDetail();

	            customer.setCustomerNo(rs.getInt("customer_no"));
	            customer.setCustomerId(rs.getString("customer_id"));

	            // 변경된 부분: 비밀번호를 해시에서 평문으로 변경
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
	    return customer;
	}
	

	public int updateCustomer(Customer customer, CustomerDetail customerDetail, CustomerAddr customerAddr) {
	    try {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();
	        // 고객 정보 업데이트
	        String sql1 = "UPDATE customer SET customer_pw = ? , updatedate = NOW() WHERE customer_no = ?";
	        PreparedStatement stmt = conn.prepareStatement(sql1);
	        stmt.setString(1, customer.getCustomerPw()); // 평문으로 저장
	        stmt.setInt(2, customer.getCustomerNo());
	        int row1 = stmt.executeUpdate();

            // 고객 상세 정보 업데이트
            String sql2 = "UPDATE customer_detail SET customer_name = ?, customer_phone = ? WHERE customer_no = ?";
            PreparedStatement stmt2 = conn.prepareStatement(sql2);
            stmt2.setString(1, customerDetail.getCustomerName());
            stmt2.setString(2, customerDetail.getCustomerPhone());
            stmt2.setInt(3, customer.getCustomerNo());
            int row2 = stmt2.executeUpdate();

            // 고객 주소 정보 업데이트
            String sql3 = "UPDATE customer_addr SET address = ? WHERE customer_no = ?";
            PreparedStatement stmt3 = conn.prepareStatement(sql3);
            stmt3.setString(1, customerAddr.getAddress());
            stmt3.setInt(2, customer.getCustomerNo());
            int row3 = stmt3.executeUpdate();

            if (row1 > 0 && row2 > 0 && row3 > 0) {
                return 1; // 성공적으로 업데이트됨
            } else {
                return -1; // 업데이트 실패
            }
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
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

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());

            // Convert to hexadecimal representation
            StringBuilder hexString = new StringBuilder();
            for (byte hashByte : hashBytes) {
                String hex = Integer.toHexString(0xff & hashByte);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    // 회원 탈퇴 메서드
    public int deleteCustomer(String customerId) throws Exception {
    	 int row = 0;
    	 DBUtil dbUtil = new DBUtil();
    	 Customer customer = new Customer();
         Connection conn = dbUtil.getConnection();
         PreparedStatement stmt = null;
         try {String sql = """
         		UPDATE customer SET active='N' WHERE customer_id = ?
         		""";
         stmt = conn.prepareStatement(sql);
         stmt.setString(1, customerId);
         row = stmt.executeUpdate();
         }
         
         finally {
        	 
        	 if (stmt != null) {
                 stmt.close();
             }
             if (conn != null) {
                 conn.close();
             } 
         }
         
        return row;
        
    }

}

        
           