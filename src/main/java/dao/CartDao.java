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
	public List<Cart> selectCart(int customerId) throws Exception {
		Connection conn = db.getConnection();
		List<Cart> result = new ArrayList<>();
		// sql
		String sql = """
					SELECT a.cart_no ,  b.goods_title , b.goods_price ,a.quantity , b.soldout ,
				 c.filename , a.quantity* b.goods_price AS 소계  FROM cart a 
				 INNER JOIN goods b ON a.goods_no = b.goods_no 
				 INNER JOIN goods_img c ON b.goods_no = c.goods_no
				 INNER JOIN customer d ON a.customer_no = d.customer_no
				 WHERE d.customer_id = ?
					""";
		try {
			ResultSet rs =  db.executeQuery(sql);
			List<Cart> cartList = new ArrayList<>();
            while (rs.next()) {
            	Cart cart = new Cart();
      			Goods goods = new Goods();
      			GoodsImg goodsImg = new GoodsImg();
      			Customer customer = new Customer();
      			cart.setCustomer(customer);
      			cart.setGoods(goods);
      			cart.setGoodsImg(goodsImg);
      			cart.setCartNo(rs.getInt("cart_no"));
      			cart.getGoods().setGoodsTitle(rs.getString("goods_title"));
      			cart.getGoods().setGoodsPrice(rs.getInt("goods_price"));
      			cart.setQuantity(rs.getInt("quentity"));
      			cart.setMidPrice(rs.getInt("소계"));
      			cartList.add(cart);
            }
            	result = cartList;
		}	finally {
			conn.close();
		}	
           return result;     
            
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





















