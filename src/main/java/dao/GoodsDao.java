package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

import util.Converter;
import util.DBUtil;
import vo.Goods;

public class GoodsDao extends ClassDao {
	Converter converter = null;
	
	public int insert(Map<String, Object> paramMap) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		
		ResultSet rs = null;
		int result = 0;
		int row = 0;
		
		try {
			String sql = """
					INSERT INTO goods (
						goods_title,
						goods_price,
						soldout,
						goods_memo
					) VALUES (
						?,
						?,
						?,
						?
					)
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, (String) paramMap.get("goodsTitle"));
			stmt.setInt(2, (int) paramMap.get("goodsPrice"));
			stmt.setString(3, (String) paramMap.get("soldout"));
			stmt.setString(4, (String) paramMap.get("goodsMemo"));
			row = stmt.executeUpdate();
			if(row > 0) {
				String sql1 = "select LAST_INSERT_ID()";
				stmt1 = conn.prepareStatement(sql1);
				rs = stmt1.executeQuery();
				if(rs.next()) {
					paramMap.put("goodsNo", rs.getInt("LAST_INSERT_ID()"));
				}
				
				
			}
			String sql2 = """
					INSERT INTO goods_img (
						goods_no,
						filename,
						origin_name,
						content_type,
					) VALUES (
						?,
						?,
						?,
						?
					)
					""";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1, (int) paramMap.get("goodsNo"));
			stmt2.setString(2, result);
			stmt2.setString(3, result);
			stmt2.setString(4, result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
			return result;
	}
	
	public int delete(Goods goods) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		
		int result = 0;
		int row= 0;		int row2 = 0;
		try {
			String sql = """
					DELETE FROM goods_img
					 WHERE goods_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goods.getGoodsNo());
			
			row = stmt.executeUpdate();

			String sql2 = """
					DELETE FROM goods
						WHERE goods_no = ?
					""";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1, goods.getGoodsNo());
			
			row = stmt2.executeUpdate();
			
			if(row > 0 && row2 > 0) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt2.close();
			stmt.close();
			conn.close();
		}
			return result;
	}
	
	
	
	
	

	
	

	
	

	
	
	
	
	
}