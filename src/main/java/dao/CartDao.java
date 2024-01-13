package dao;
import vo.*;
import java.sql.*;
import java.util.*;

import util.Converter;
import util.DBUtil;

public class CartDao extends ClassDao{
	Converter converter = null;
	
	public List<Map<String, Object>> cartList(Customer paramCustomer) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<Map<String, Object>> resultList = null;
		
		try {
			String sql = """
					SELECT
						c.cart_no,
						g.goods_title,
						c.quantity,
						g.goods_price,
						g.soldout,
						g.goods_no
					FROM cart c
					INNER JOIN goods g
					ON c.goods_no = g.goods_no
					WHERE c.customer_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCustomer.getCustomerNo());
			rs = stmt.executeQuery();
			Map<String, Object> paramMap = null;
			resultList = new ArrayList<>();
			while(rs.next()) {
				paramMap = new HashMap<>();
				paramMap.put("cartNo", rs.getInt("cart_no"));
				paramMap.put("goodsTitle", rs.getString("goods_title"));
				paramMap.put("quantity", rs.getInt("quantity"));
				paramMap.put("goodsPrice", rs.getInt("goods_price"));
				paramMap.put("soldout", rs.getString("soldout"));
				paramMap.put("goodsNo", rs.getInt("goods_no"));				
				resultList.add(paramMap);
				rs.close();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}	finally {
			stmt.close();
			conn.close();
		}
		return resultList;
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


