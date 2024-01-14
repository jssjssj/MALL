package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.Converter;
import util.DBUtil;
import vo.Orders;

public class OrdersDao extends ClassDao {
	Converter converter = null;
	
	public int insert(Orders paramOrders) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					INSERT INTO orders (
						goods_no,
						customer_no,
						customer_addr_no,
						quantity,
						total_price
					) VALUES (
						?,
						?,
						?,
						?,
						?
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramOrders.getGoodsNo());
			stmt.setInt(2, paramOrders.getCustomerNo());
			stmt.setInt(3, paramOrders.getCustomerAddrNo());
			stmt.setInt(4, paramOrders.getQuantity());
			stmt.setInt(5, paramOrders.getTotalPrice());
			
			result = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public int delete(Orders paramOrders) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					DELETE FROM orders
						WHERE orders_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramOrders.getOrdersNo());
			
			result = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	public int update(Orders paramOrders) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		int result = 0;
		try {
			String sql = """
					UPDATE orders SET
						goods_no = ?,
						customer_addr_no = ?,
						quantity = ?,
						total_price = ?,
						orders_state = ?,
						updatedate = NOW()
					WHERE orders_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramOrders.getGoodsNo());
			stmt.setInt(2, paramOrders.getCustomerAddrNo());
			stmt.setInt(3, paramOrders.getQuantity());
			stmt.setInt(4, paramOrders.getTotalPrice());
			stmt.setString(5, paramOrders.getOrdersState());
			stmt.setInt(6, paramOrders.getOrdersNo());
			
			result = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}

















}

