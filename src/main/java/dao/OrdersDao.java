package dao;

import java.sql.Connection;

import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.*;

public class OrdersDao extends ClassDao {
	public List<Orders> select(String customerId) throws Exception {
		Orders orders = null;
		Goods goods = null;
		CustomerDetail customerDetail = null;
		CustomerAddr customerAddr = null;
	    DBUtil dbUtil = new DBUtil();
	    ResultSet rs = null;
	    Connection conn = dbUtil.getConnection();
	    PreparedStatement stmt = null;
		String sql = """
        			SELECT o.orders_no 주문번호 , g.goods_title 상품명, o.quantity 주문수량  , o.total_price 상품소계 , 
					o.orders_state 배송여부 , cd.customer_name 주문자명 , ca.address 배송주소
					FROM orders o
					INNER JOIN customer c
					ON o.customer_no = c.customer_no
					INNER JOIN goods g
					ON g.goods_no = o.goods_no
					INNER JOIN customer_detail cd
					ON c.customer_no = cd.customer_no
					INNER JOIN customer_addr ca
					ON c.customer_no = ca.customer_no
					WHERE c.customer_id = ?
    		""";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		
		rs= stmt.executeQuery();
		List<Orders> ordersList = new ArrayList<>();
			while(rs.next()) {
				orders = new Orders();
				customerDetail = new CustomerDetail();
				customerAddr = new CustomerAddr();
				goods = new Goods();				
				
				orders.setOrdersNo(rs.getInt("주문번호"));
				orders.setOrdersState(rs.getString("배송여부"));
				orders.setTotalPrice(rs.getInt("상품소계"));
				orders.setQuantity(rs.getInt("주문수량"));
				
				customerAddr.setAddress(rs.getString("배송주소"));
				customerDetail.setCustomerName(rs.getString("주문자명"));
				goods.setGoodsTitle(rs.getString("상품명"));
				
				orders.setCustomerAddr(customerAddr);
				orders.setCustomerDetail(customerDetail);
				orders.setGoods(goods);
				ordersList.add(orders);
				
			} 
			return ordersList;
	}
	
	
	public int deleteOrder(int ordersNo) throws Exception {
		 DBUtil dbUtil = new DBUtil();
		 Customer customer = null;
		 int row = 0;
		 Connection conn = dbUtil.getConnection();
		 
			 customer = new Customer();
			 String sql = """
			 		DELETE FROM orders
			 		WHERE orders_no=?
			 		""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,ordersNo);
		row = stmt.executeUpdate();
		if(row>0) { //주문 취소 + 주문 정보 삭제
			return row;
		} else { // 주문 취소실패ㅠ 
			return row;
		}
		
		 }
	
	public int insertOrder(Orders paramOrders) throws Exception {
		int row=0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql="""
				INSERT INTO orders (
					goods_no,
					customer_no,
					customer_addr_no,
					quantity,
					total_price,
					orders_state,
					createdate,
					updatedate
				) VALUES (
					?,
					?,
					?,
					?,
					?,
					'주문완료',
					NOW(),
					NOW()
				)
				""";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,paramOrders.getGoodsNo());
		stmt.setInt(2,paramOrders.getCustomerNo());
		stmt.setInt(3,paramOrders.getCustomerAddrNo());
		stmt.setInt(4,paramOrders.getQuantity());
		stmt.setInt(5,paramOrders.getTotalPrice());
		row = stmt.executeUpdate();
		return row;
	}
		
}

	

















