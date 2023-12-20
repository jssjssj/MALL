package dao;
import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class CartDao extends ClassDao{
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	/*
	 * final String RESET = "\u001B[0m"; 
	 * final String KIM = "\u001B[42m"; 
	 * final String PARK = "\u001B[44m";
	 */
    
	
	
  // select
	public List<Cart> selectCart(String customerId) throws Exception {
	    Connection conn = db.getConnection();
	    List<Cart> result = new ArrayList<>();
	    String sql = """
	            SELECT a.*, b.*,  c.*, a.quantity * b.goods_price AS 상품소계 
	            FROM cart a
	            INNER JOIN goods b ON a.goods_no = b.goods_no
	            INNER JOIN goods_img c ON b.goods_no = c.goods_no
	            INNER JOIN customer d ON a.customer_no = d.customer_no
	            WHERE d.customer_id = ?
	            """;
	  
	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, customerId);
	        ResultSet rs = stmt.executeQuery();

	        List<Cart> cartList = new ArrayList<>();
	        while (rs.next()) {
	            Cart cart = converter.getCart(rs);
	            cartList.add(cart);
	        }

	        result = cartList;
	    } finally {
	        conn.close();
	    }
	    return result;
	}


  	
  	
  	// delete
  	public int deleteCart(int cartNo) throws Exception {
  		DBUtil dbUtil = new DBUtil();
  		Connection conn = dbUtil.getConnection();
  		int row = 0;		
  		
  		
  		String sql = """
  				DELETE FROM cart WHERE cart_no=?
  				""";
  		
  		PreparedStatement stmt = conn.prepareStatement(sql);
  		stmt.setInt(1, cartNo);
  		row = stmt.executeUpdate();  
  		return row;
  		  		
  	}

 // update
   	public int plusCart(int cartNo) throws Exception {
   		int row = 0;
   		DBUtil dbUtil = new DBUtil();
   		Connection conn = dbUtil.getConnection();
   		String sql = """
   				UPDATE cart SET 
   					quantity = quantity+1 , 
   					updatedate = NOW() 
   				WHERE cart_no = ?
   				""";
   		PreparedStatement stmt = conn.prepareStatement(sql);
   		stmt.setInt(1, cartNo);  		
   		row = stmt.executeUpdate();
   		return row;
   	}
   	
 // update
   	public int minusCart(int cartNo) throws Exception {
   		int row = 0;
   		DBUtil dbUtil = new DBUtil();
   		Connection conn = dbUtil.getConnection();
   		String sql = """
   				UPDATE cart SET 
   					quantity = quantity-1 , 
   					updatedate = NOW() 
   				WHERE cart_no = ?
   				""";
   		PreparedStatement stmt = conn.prepareStatement(sql);
   		stmt.setInt(1, cartNo);  		
   		row = stmt.executeUpdate();
   		return row;
   	}
   	
    // count
   	public int countCart(String customerId) throws Exception {
   		int cnt = 0;
   		DBUtil dbUtil = new DBUtil();
   		Connection conn = dbUtil.getConnection();
   		ResultSet rs = null;
   		String sql = """
   				SELECT COUNT(cart_no) AS cnt
			FROM cart c 
			INNER JOIN customer cu
			ON c.customer_no = cu.customer_no
			WHERE cu.customer_id = ?
   				""";
   		PreparedStatement stmt = conn.prepareStatement(sql);
   		stmt.setString(1, customerId);
   		rs = stmt.executeQuery();
   		if(rs.next()) {
   		cnt = rs.getInt("cnt");
   		}
   		return cnt;
   	}
   	
   	// select
   	public int selectCart(int godosNo) throws Exception {
   		int cartNo = 0;
   		DBUtil dbUtil = new DBUtil();
	  	Connection conn = dbUtil.getConnection();
	  	String sql="""
	  		SELECT cart_no AS cartNo FROM cart
	  			WHERE goods_no = ?
	  			""";
	  	PreparedStatement stmt= conn.prepareStatement(sql);
	  	stmt.setInt(1, godosNo);
	  	ResultSet rs = stmt.executeQuery();
	  	if(rs.next()) {
	  	cartNo = rs.getInt("cartNo");
	  	}
   		return cartNo;
   	}
   	
   	
   		// insert
   		  	public int insertCart(String customerId, int goodsNo , int quantity) throws Exception {
   		  		DBUtil dbUtil = new DBUtil();
   		  		Connection conn = dbUtil.getConnection();
   		  		int row = 0;
   		  		String sql0 = """
   		  				SELECT customer_no FROM customer
   		  				WHERE customer_id = ?
   		  				""";
   		  		PreparedStatement stmt0 = conn.prepareStatement(sql0);
   		  		stmt0.setString(1, customerId);
   		  		ResultSet rs = stmt0.executeQuery();
   		  		if(rs.next()) {
   		  			Customer customer = new Customer();
   		  			customer.setCustomerNo(rs.getInt("customer_no"));
   		  			
   		  		String sql = "INSERT INTO cart(goods_no , customer_no , quantity , createdate , updatedate)"
   		  				+ "VALUES (? , ? , ? , NOW() , NOW())";
   		  		PreparedStatement stmt = conn.prepareStatement(sql);
   		  		stmt.setInt(1, goodsNo);
   		  		stmt.setInt(2, customer.getCustomerNo());
   		  		stmt.setInt(3 , quantity);
   		  		row = stmt.executeUpdate();
   		  		}
   		  		
   		  		return row;
   		  	}
   		  	
  
}





















