package dao;
import vo.*;
import java.sql.*;
import java.util.*;

import util.Converter;
import util.DBUtil;

public class CartDao extends ClassDao{
	Converter converter = null;
	
	public Map<String, Object> cartList(Customer paramCustomer) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Map<String, Object> resultMap = null;
		
		try {
			String sql = """
					SELECT
						c.cart_no,
						g.goods_title,
						c.quantity,
						g.goods_price,
						g.soldout
					FROM cart c
					INNER JOIN goods g
					ON c.goods_no = g.goods_no
					WHERE c.customer_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCustomer.getCustomerNo());
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultMap = new HashMap<>();
				resultMap.put("cartNo", rs.getInt("cart_no"));
				resultMap.put("goodsTitle", rs.getString("goods_title"));
				resultMap.put("quantity", rs.getInt("quantity"));
				resultMap.put("goodsPrice", rs.getInt("goods_price"));
				resultMap.put("soldout", rs.getString("soldout"));
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}	finally {
			rs.close();
			stmt.close();
			conn.close();
		}
		return resultMap;
	}
	
	public int insert(Cart paramCart) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		
		try {
			String sql = """
					INSERT INTO cart (
						goods_no,
						customer_no,
						quantity
					) VALUES (
						?,
						?,
						?
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCart.getGoodsNo());
			stmt.setInt(2, paramCart.getCustomerNo());
			stmt.setInt(3, paramCart.getQuantity());
			result = stmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}	finally {
			stmt.close();
			conn.close();
		}
		return result;
	}
	
	public int delete(Cart paramCart) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		
		try {
			String sql = """
					DELETE FROM cart
					WHERE cart_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCart.getCartNo());			
			result = stmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}	finally {
			stmt.close();
			conn.close();
		}
		return result;
	}
	
	public int update(Cart paramCart) throws Exception {	//update - Quantity
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		
		try {
			String sql = """
					UPDATE cart SET
						quantity = ?
					WHERE cart_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCart.getCartNo());
			stmt.setInt(2, paramCart.getQuantity());
			result = stmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}	finally {
			stmt.close();
			conn.close();
		}
		return result;
	}
}


