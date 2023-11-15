package dao;

import java.security.*;
import java.sql.*;
import java.util.*;
import util.*;
import vo.*;

public class CustomerDao extends ClassDao {

	public int insertCustomer(Customer customer, CustomerDetail customerDetail, CustomerAddr customerAddr) {
	    int customerNo = 0; // 초기화 값

	    try {
	       
	        Connection conn = db.getConnection();
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

	      
	        String sql1 = "INSERT INTO customer"
	                + "(customer_id, customer_pw, createdate, updatedate, active) "
	                + "VALUES(?, PASSWORD(?), NOW(), NOW(), 'Y')";
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
	    ResultSet rs = null;
	    Connection conn = dbUtil.getConnection();
	    PreparedStatement stmt = null;
	    String sql = "SELECT a.customer_no, a.customer_id, a.customer_pw, a.createdate, a.updatedate, a.active, "
	            + "b.address, c.customer_name, c.customer_phone FROM customer a "
	            + "INNER JOIN customer_addr b ON a.customer_no = b.customer_no "
	            + "INNER JOIN customer_detail c ON a.customer_no = c.customer_no "
	            + "WHERE a.customer_id = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, customerId);

	    rs = stmt.executeQuery() ;
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
	    
	    return customer;
	}
	
	
	public int updateCustomer(String customerId , String customerPw, 
			String newPw , 
			String customerName , String address ,String customerPhone) throws Exception {
		Connection conn = db.getConnection();
		CustomerPwHistory cph = new CustomerPwHistory();
        Customer c = new Customer();  
        ResultSet rs = null;
        int row = 0;
        int pwRow = 0;
        int customerPwHistoryNo=0;
        String sql0 = """
        		SELECT customer_no FROM customer
        		WHERE customer_id = ? AND customer_pw = PASSWORD(?)
        		""";
        PreparedStatement stmt0 = conn.prepareStatement(sql0);
        stmt0.setString(1, customerId);
        stmt0.setString(2, customerPw);
        rs = stmt0.executeQuery();
        if(rs.next()) {        	
        	String sql1 = """
        			UPDATE customer SET customer_pw = PASSWORD(?), updatedate = NOW()
        			WHERE customer_no=?
        			""";
        	PreparedStatement stmt1 = conn.prepareStatement(sql1);
        	stmt1.setString(1 , newPw);
        	stmt1.setInt(2 , rs.getInt("customer_no"));
        	
        	int row1 = stmt1.executeUpdate();
        	
        	String sql2 = """
        			UPDATE customer_detail SET customer_name = ?, customer_phone = ?
        			WHERE customer_no = ?
        			""";
        	PreparedStatement stmt2 = conn.prepareStatement(sql2);
        	stmt2.setString(1 , customerName);
        	stmt2.setString(2 , customerPhone);
        	stmt2.setInt(3 , rs.getInt("customer_no"));
        	int row2 = stmt2.executeUpdate();
        	
        	String sql3 = """
        			UPDATE customer_addr SET address = ?
        			WHERE customer_no = ?
        			""";
        	PreparedStatement stmt3 = conn.prepareStatement(sql3);
        	stmt3.setString(1 , address);
        	stmt3.setInt(2 , rs.getInt("customer_no"));
        	int row3 = stmt3.executeUpdate();
        	
        	if(row1>0 && row2>0 && row3>0) {
        		row = 1; // 수정성공
        		
        		CustomerPwHistory customerPwHistory = new CustomerPwHistory();
        		String sql4 = """
        				INSERT INTO customer_pw_history(customer_no , customer_pw , createdate) 
        				VALUES (? , ? , NOW())
        				""";
        		
        		PreparedStatement stmt4 = conn.prepareStatement(sql4, Statement.RETURN_GENERATED_KEYS);
        		stmt4.setInt(1, rs.getInt("customer_no"));
        		stmt4.setString(2 , customerPw);
        		pwRow = stmt4.executeUpdate();
        		
        		
        	} else {
        		row = 2; // 수정실패- 도무지 왜인지
        	}
        	    	
        } else { 
        	row = -100; //현재 비밀번호 불일치 또는 고객정보 없음/ 조회실패
        }
        return row;
	}

    public List<Customer> selectCustomer() throws Exception {
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();        
        String sql = """
        		SELECT a.customer_no , a.customer_id , a.customer_pw , a.createdate , a.updatedate , a.active ,
				b.address , c.customer_name , c.customer_phone FROM customer a INNER JOIN customer_addr b
				ON a.customer_no = b.customer_no 
				INNER JOIN customer_detail c 
				ON a.customer_no = c.customer_no
		        		""";
        
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
         
    }

    
    // 회원 탈퇴 메서드
    public int deleteCustomer(String customerId , String customerPw) throws Exception {
    	 int row = 0;
    	 DBUtil dbUtil = new DBUtil();
         Connection conn = dbUtil.getConnection();
         String sql0 = """
         		SELECT customer_id , customer_pw 
         		FROM customer
         		WHERE customer_id = ? AND customer_pw = PASSWORD(?)
         		""";
         PreparedStatement stmt0 = conn.prepareStatement(sql0);
         stmt0.setString(1 , customerId);
         stmt0.setString(2 , customerPw);
         ResultSet rs = stmt0.executeQuery();
         if(rs.next()) {
        	 String sql="""
        	 		UPDATE customer SET
        	 		active = 'N'
        	 		WHERE customer_id = ?
        	 		""";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1 , customerId);
        row = stmt.executeUpdate();
         }
         
    	 return row;
    }
}

        
           