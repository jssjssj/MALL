package dao;
import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class CartDao {
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
	/*
	 * final String RESET = "\u001B[0m"; 
	 * final String KIM = "\u001B[42m"; 
	 * final String PARK = "\u001B[44m";
	 */
    
  // select
  	public int selectCart(int customerNo) throws Exception {
  		int row = 0;
  		// DB연결
  		DBUtil dbUtil = new DBUtil();
  		Connection conn = dbUtil.getConnection();		
  		String sql = "SELECT a.goods_title , a.goods_price , b.quantity , a.goods_price*b.quantity FROM goods a INNER JOIN cart b"
  				+ "ON a.goods_no = b.goods_no WHERE b.customer_no = ?" ;
  		PreparedStatement stmt = conn.prepareStatement(sql);
  		stmt.setInt(1, customerNo);
  		System.out.println(stmt + " <-- stmt deleteCustomer()");
  		ResultSet rs = stmt.executeQuery();
  		return row;	
  	}

  	// insert
  	public int insertCart(int customerNo , int goodsNo , int quantity) throws Exception {
  		DBUtil dbUtil = new DBUtil();
  		Connection conn = dbUtil.getConnection();
  		String sql = "INSERT INTO cart(goods_no , customer_no , quantity , createdate , updatedate)"
  				+ "VALUES (? , ? , ? , NOW() , NOW())";
  		PreparedStatement stmt = conn.prepareStatement(sql);
  		stmt.setInt(1, goodsNo);
  		stmt.setInt(2, customerNo);
  		stmt.setInt(3 , quantity);
  		int row = stmt.executeUpdate();
  		return row;
  	}
  	
  	// delete
  	public int deleteCart(int cartNo) throws Exception {
  		DBUtil dbUtil = new DBUtil();
  		Connection conn = dbUtil.getConnection();
  		String sql = "DELETE FROM cart WHERE cartNo = ?";
  		PreparedStatement stmt = conn.prepareStatement(sql);
  		stmt.setInt(1, cartNo);
  		int row = stmt.executeUpdate();
  		return row;
  	}
  	
 // update
   	public int updateCart(int quantity , int cartNo) throws Exception {
   		DBUtil dbUtil = new DBUtil();
   		Connection conn = dbUtil.getConnection();
   		String sql = "UPDATE cart SET quantity = ? WHERE cartNo = ?";
   		PreparedStatement stmt = conn.prepareStatement(sql);
   		stmt.setInt(1, quantity);
   		stmt.setInt(2, cartNo);  		
   		int row = stmt.executeUpdate();
   		return row;
   	}
  	
}





















