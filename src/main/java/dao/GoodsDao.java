package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
		PreparedStatement stmt2 = null;
		
		ResultSet rs = null;
		int result = 0;
		int row = 0;
		int row2 = 0;
		try {
			 String sql = """
		                INSERT INTO goods (
		                    goods_title,
		                    goods_price,
		                    goods_memo
		                ) VALUES (
		                    ?,
		                    ?,
		                    ?
		                )
		                """;
		        stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		        stmt.setString(1, (String) paramMap.get("goodsTitle"));
		        stmt.setInt(2, (int) paramMap.get("goodsPrice"));
		        stmt.setString(3, (String) paramMap.get("goodsMemo"));
		        row = stmt.executeUpdate();
		        if (row > 0) {
		            // 생성된 goods_no 가져오기
		            rs = stmt.getGeneratedKeys();
		            if (rs.next()) {
		                paramMap.put("goodsNo", rs.getInt(1));
		            }

		            // goods_img 테이블에 파일 정보 삽입
		            String sql2 = """
		                    INSERT INTO goods_img (
		                        goods_no,
		                        origin_name,
		                        file_name,
		                        file_size,
		                        file_type
		                    ) VALUES (
		                        ?,
		                        ?,
		                        ?,
		                        ?,
		                        ?
		                    )
		                    """;
		            stmt2 = conn.prepareStatement(sql2);
		            stmt2.setInt(1, (int) paramMap.get("goodsNo"));
		            stmt2.setString(2, (String) paramMap.get("originName"));
		            stmt2.setString(3, (String) paramMap.get("fileName"));
		            stmt2.setInt(4, (int) paramMap.get("fileSize"));
		            stmt2.setString(5, (String) paramMap.get("fileType"));
		            row2 = stmt2.executeUpdate();
		        }
		        if (row > 0 && row2 >0 ) {
		        	result = 1;
		        }
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
	
	public int update(Map<String, Object> paramMap) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		
		int result = 0;
		int row = 0;
		int row2 = 0;
		try {
			String sql = """
				UPDATE goods SET
					goods_title = ?,
					goods_price = ?,
					soldout = ?,
					goods_memo = ?,
					updatedate = NOW()
				WHERE goods_no = ?
						""";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, (String) paramMap.get("goodsTitle"));
			stmt.setInt(2, (int) paramMap.get("goodsPrice"));
			stmt.setString(3, (String) paramMap.get("soldout"));
			stmt.setString(4, (String) paramMap.get("goods_memo"));
			stmt.setInt(6, (int) paramMap.get("goods_no"));
			
			row = stmt.executeUpdate();
			
			String sql2 = """
					UPDATE goods_img SET						
						origin_name = ?,
						updatedate = NOW()
					WHERE goods_no = ?
							""";
			stmt2 = conn.prepareStatement(sql2);
			stmt.setString(1, (String) paramMap.get("originName"));
			stmt2.setInt(2, (int) paramMap.get("goodsNo"));
			
			row2 = stmt2.executeUpdate();
			if(row > 0 && row2 > 0) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return result;
	}
		
	
	// goods 상세
	public Map<String, Object> select(int goodsNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		Map<String, Object> resultMap = null;
		try {
			String sql = """
				SELECT
						g.goods_no,
						g.goods_title,
						g.goods_price,
						g.soldout,
						g.goods_memo,
						g.createdate,
						g.updatedate,
						
						gi.origin_name originName
					FROM goods g
					INNER JOIN goods_img gi
					ON g.goods_no = gi.goods_no
					WHERE g.goods_no = ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				resultMap = new HashMap<>();
				resultMap.put("goodsNo", rs.getInt("goods_no"));
				resultMap.put("goodsTitle", rs.getString("goods_title"));
				resultMap.put("goodsPrice", rs.getInt("goods_price"));
				resultMap.put("soldout", rs.getString("soldout"));
				resultMap.put("goodsMemo", rs.getString("goods_memo"));
				resultMap.put("createdate", rs.getString("createdate"));
				resultMap.put("updatedate", rs.getString("updatedate"));
				resultMap.put("originName", rs.getString("originName"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			stmt.close();
			conn.close();
			
		}	
			return resultMap;
	}
	
	// 전체 상품리스트 - 상품보기 페이지
	public List<Map<String, Object>> goodsList(Map<String, Integer> paramMap) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		List<Map<String, Object>> resultList = null;
		try {
			String sql = """
					SELECT
						g.goods_no,
						g.goods_title,
						g.goods_price,
						
						gi.origin_name originName
					FROM goods g
					INNER JOIN goods_img gi
					ON g.goods_no = gi.goods_no
					ORDER BY g.createdate DESC
					LIMIT ?, ?
					""";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramMap.get("beginRow"));
			stmt.setInt(2, paramMap.get("rowPerPage"));
			
			rs = stmt.executeQuery();
			resultList = new ArrayList<>();
			while(rs.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("goodsNo", rs.getInt("goods_no"));
				map.put("goodsTitle", rs.getString("goods_title"));
				map.put("goodsPrice", rs.getInt("goods_price"));
				map.put("originName", rs.getString("originName"));
				resultList.add(map);				
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt.close();
			conn.close();
		}
			return resultList;
	}
	
	
	// 페이징 위한 전체 상품리스트 출력
	public int countOfGoods() throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt = null;
		
		ResultSet rs = null;
		int result = 0;
		try {
			String sql = """
					SELECT 
						COUNT(*) count
					FROM goods
					""";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("count");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
			return result;
	}
	

	// 전체 상품리스트 - 상품보기 페이지
		public List<Goods> goodsAll() throws Exception {
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			PreparedStatement stmt = null;
			
			ResultSet rs = null;
			List<Goods> resultList = null;
			try {
				String sql = """
						SELECT
							goods_no,
							goods_title
						FROM goods
						ORDER BY createdate DESC
						""";
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery();
				resultList = new ArrayList<>();
				while(rs.next()) {
					Goods goods = new Goods();
					goods.setGoodsNo(rs.getInt("goods_no"));
					goods.setGoodsTitle(rs.getString("goods_title"));
					resultList.add(goods);
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				stmt.close();
				conn.close();
			}
				return resultList;
		}
	

	
	
	
	
	
}