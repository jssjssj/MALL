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
	
		
	public int insertCustomer(Customer customer , CustomerAddr customerAddr) throws Exception {
		
		// DB연결	
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql1 = """
				INSERT INTO customer(customer_id , customer_pw , createdate , updatedate )
				VALUES (? , PASSWORD(?) , NOW() , NOW() )
				""";
		PreparedStatement stmt1 = conn.prepareStatement(sql1 , Statement.RETURN_GENERATED_KEYS);
		stmt1.setString(1, customer.getCustomerId());
		stmt1.setString(2, customer.getCustomerPw());
		int row = stmt1.executeUpdate();
		ResultSet rs = stmt1.getGeneratedKeys();
		System.out.println(stmt1 + " <-- stmt1 insertCustomer()");
		int customerNo = 0;
		if(rs.next()) {
			customerNo = rs.getInt(1);
		}

		
		String sql2 = "INSERT INTO customer_addr("
				+ "customer_no, address , createdate , updatedate"
				+ ") VALUES(? , ? , NOW() , NOW())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, customerNo); // 
		stmt2.setString(2, customerAddr.getAddress()); 
		int row2 = stmt2.executeUpdate();
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















