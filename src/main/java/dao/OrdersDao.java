package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.Converter;
import util.DBUtil;
import vo.Customer;
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
					UPDATE orders SET
						orders_private='Y'
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
						orders_state = ?,
						updatedate = NOW()
					WHERE orders_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramOrders.getOrdersState());
			stmt.setInt(2, paramOrders.getOrdersNo());
			
			result = stmt.executeUpdate();
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}

	public List<Map<String, Object>> select(Customer paramCustomer) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<Map<String, Object>> orderList = null;
		try {
			String sql = """
					SELECT
						o.orders_no ordersNo,
						g.goods_title goodsTitle,
						ca.address address,
						g.goods_price goodsPrice,
						o.quantity quantity,
						o.orders_state ordersState,
						o.createdate createdate,
						o.updatedate updatedate,
						o.total_price totalPrice
				FROM orders o
				INNER JOIN goods g
				ON o.goods_no = g.goods_no
				INNER JOIN customer_addr ca
				ON o.customer_addr_no = ca.customer_addr_no
				WHERE ca.customer_no = ?
				AND o.orders_private = 'N'
				ORDER BY o.orders_state ASC
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCustomer.getCustomerNo());
			rs = stmt.executeQuery();
			orderList = new ArrayList<>();

			while(rs.next()) {
				Map<String, Object> paramMap = new HashMap();
				paramMap.put("ordersNo", rs.getInt("ordersNo"));
				paramMap.put("goodsTitle", rs.getString("goodsTitle"));
				paramMap.put("address", rs.getString("address"));
				paramMap.put("goodsPrice", rs.getInt("goodsPrice"));
				paramMap.put("quantity", rs.getInt("quantity"));
				paramMap.put("ordersState", rs.getString("ordersState"));
				paramMap.put("createdate", rs.getString("createdate"));
				paramMap.put("updatedate", rs.getString("updatedate"));
				paramMap.put("totalPrice", rs.getInt("totalPrice"));
				orderList.add(paramMap);

			}	rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return orderList;
	}

// 매니저용 배송완료되지 않은 주문기록 정렬
	public List<Orders> totalOrder() throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<Orders> list = null;

		try {
			String sql = """
					SELECT
						*
					FROM orders
					WHERE orders_state != '배송완료'
					""";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			list = new ArrayList<>();
			converter  = new Converter();
			Orders orders = new Orders();
			while(rs.next()) {
				orders = converter.getOrders(rs);
				list.add(orders);

			}	rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return list;
	}














}

