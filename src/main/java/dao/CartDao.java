package dao;
import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class CartDao {
	/* 디버깅 색깔 지정 */
	// ANSI CODE   
    final String RESET = "\u001B[0m"; 
    final String KIM  =  "\u001B[42m";
    final String PARK = "\u001B[44m";
    
  //deleteAction
  	public int deleteCart(int cartNo) throws Exception {
  		int row = 0;
  		// DB연결
  		DBUtil dbUtil = new DBUtil();
  		Connection conn = dbUtil.getConnection();		
  		String sql = "DELETE FROM cart WHERE cart_no = ?";
  		PreparedStatement stmt = conn.prepareStatement(sql);
  		stmt.setInt(1, cartNo);
  		System.out.println(stmt + " <-- stmt deleteCustomer()");
  		row = stmt.executeUpdate();
  		return row;		
  	}
}