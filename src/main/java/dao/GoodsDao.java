package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Goods;
import vo.GoodsImg;

public class GoodsDao extends ClassDao {

	// 상품과 굿즈 이미지 등록
public void addGoods(String goodsTitle, int goodsPrice, String goodsMemo, String contentType, String filename, String originName) throws Exception{
		
		Connection conn = db.getConnection();
		conn.setAutoCommit(false);
		String sql1 = """
					INSERT INTO goods(goods_title, goods_price, soldout, goods_memo, createdate, updatedate) 
					VALUES(?, ?, 'N', ?, NOW(), NOW())
					""";
		// 입력시 생성된 AutoIncrement값을 ResultSet 받아오는 옵션 매개값 Statement.RETURN_GENERATED_KEYS
		PreparedStatement stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
		stmt1.setString(1, goodsTitle);
		stmt1.setInt(2, goodsPrice);
		stmt1.setString(3, goodsMemo);
		int row1 = stmt1.executeUpdate();
		
		ResultSet rs = stmt1.getGeneratedKeys();
		int goodsNo = 0;
		if(rs.next()) {
			goodsNo = rs.getInt(1);
		}
		
		if(row1 != 1) {
			conn.rollback();
			return;
		}
		
		String sql2 = """
					INSERT INTO goods_img(goods_no, filename, origin_name, content_type, createdate, updatedate) 
					VALUES(?, ?, ?, ?, NOW(), NOW())
					""";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, goodsNo); // 
		stmt2.setString(2, filename); 
		stmt2.setString(3, originName); 
		stmt2.setString(4, contentType); 
		int row2 = stmt2.executeUpdate();
		
		if(row2 != 1) {
			conn.rollback();
			return;
		}
		
		conn.commit();
		
		stmt1.close();
		rs.close();
		stmt2.close();
		conn.close();

	}

	// 상품 정보와 굿즈 이미지 정보 업데이트
	public int updateGoods(Goods updateGoods, GoodsImg updateGoodsImg) throws Exception {
		Connection conn = db.getConnection();

		conn.setAutoCommit(false); // 트랜잭션 시작

		try {
			// 상품 업데이트
			String goodsUpdateSQL = "UPDATE goods SET goods_title=?, goods_price=?, soldout=?, goods_memo=?, updatedate=now()"
					+ " WHERE goods_no=?";
			PreparedStatement goodsUpdateStmt = conn.prepareStatement(goodsUpdateSQL);
			goodsUpdateStmt.setString(1, updateGoods.getGoodsTitle());
			goodsUpdateStmt.setInt(2, updateGoods.getGoodsPrice());
			goodsUpdateStmt.setString(3, updateGoods.getSoldout());
			goodsUpdateStmt.setString(4, updateGoods.getGoodsMemo());
			goodsUpdateStmt.setInt(5, updateGoods.getGoodsNo());

			int goodsUpdateRow = goodsUpdateStmt.executeUpdate();

			// 굿즈 이미지 업데이트
			String goodsImgUpdateSQL = "UPDATE goods_img SET filename=?, origin_name=?, content_type=?, updatedate=now()"
					+ " WHERE goods_no=?";
			PreparedStatement goodsImgUpdateStmt = conn.prepareStatement(goodsImgUpdateSQL);
			goodsImgUpdateStmt.setString(1, updateGoodsImg.getFileName());
			goodsImgUpdateStmt.setString(2, updateGoodsImg.getOriginName());
			goodsImgUpdateStmt.setString(3, updateGoodsImg.getContentType());
			goodsImgUpdateStmt.setInt(4, updateGoods.getGoodsNo()); // 상품 번호를 사용하여 굿즈 이미지 업데이트

			int goodsImgUpdateRow = goodsImgUpdateStmt.executeUpdate();

			if (goodsUpdateRow == 1 && goodsImgUpdateRow == 1) {
				conn.commit(); // 모든 작업이 성공하면 커밋
			} else {
				conn.rollback(); // 업데이트 작업 중 실패하면 롤백
			}

			return goodsUpdateRow;

		} catch (Exception e) {
			conn.rollback(); // 예외 발생 시 롤백
			throw e;
		} finally {
			conn.setAutoCommit(true); // 트랜잭션 종료
		}
	}

	// 상품 정보와 굿즈 이미지 정보 삭제
	public int deleteGoods(int goodsNo) throws Exception {
		Connection conn = db.getConnection();

		conn.setAutoCommit(false); // 트랜잭션 시작

		try {
			// 굿즈 이미지 삭제
			String goodsImgDeleteSQL = "DELETE FROM goods_img WHERE goods_no=?";
			PreparedStatement goodsImgDeleteStmt = conn.prepareStatement(goodsImgDeleteSQL);
			goodsImgDeleteStmt.setInt(1, goodsNo);

			int goodsImgDeleteRow = goodsImgDeleteStmt.executeUpdate();

			// 상품 삭제
			String goodsDeleteSQL = "DELETE FROM goods WHERE goods_no=?";
			PreparedStatement goodsDeleteStmt = conn.prepareStatement(goodsDeleteSQL);
			goodsDeleteStmt.setInt(1, goodsNo);

			int goodsDeleteRow = goodsDeleteStmt.executeUpdate();

			if (goodsDeleteRow == 1 && goodsImgDeleteRow == 1) {
				conn.commit(); // 모든 작업이 성공하면 커밋
			} else {
				conn.rollback(); // 삭제 작업 중 실패하면 롤백
			}

			return goodsDeleteRow;

		} catch (Exception e) {
			conn.rollback(); // 예외 발생 시 롤백
			throw e;
		} finally {
			conn.setAutoCommit(true); // 트랜잭션 종료
		}
	}

	// 상품 정보와 굿즈 이미지 정보 조회
	public List<Goods> selectGoods(int page, int perPage) throws Exception {
		List<Goods> result = new ArrayList<>();
		String sql = """
				  		SELECT g.*, gi.filename, gi.origin_name, gi.content_type
				  		FROM goods g
				  		LEFT JOIN goods_img gi ON g.goods_no = gi.goods_no
				  		LIMIT ?, ?
				""";

		try {
			// 조회 SQL
			ResultSet rs = db.executeQuery(sql, (page - 1) * perPage, perPage);

			List<Goods> goodsList = new ArrayList<>();
			while (rs.next()) {
				Goods goods = converter.getGoods(rs);
				GoodsImg goodsImg = converter.getGoodsImg(rs);
				goods.setGoodsImg(goodsImg);
				goodsList.add(goods);
			}

			result = goodsList;
		} catch (Exception e) {}

		return result;
	}
	public Goods selectGoodsNo(String goodsTitle) throws Exception {
		Goods  goods=null;
		Connection conn = db.getConnection();
		String sql0 = """
				SELECT goods_no FROM goods
				WHERE goods_title=?
				""";
		PreparedStatement stmt0 = conn.prepareStatement(sql0);
		stmt0.setString(1, goodsTitle);
		
		ResultSet rs0 = stmt0.executeQuery();
		if(rs0.next()) {
		goods = new Goods();
		goods.setGoodsNo(rs0.getInt("goods_no"));
			}
		
		return goods;
	}

	/**
	 * 페이징을 위한 게시글 총 개수를 카운팅하는 함수
	 * @param page
	 * @param perPage
	 * @return
	 * @throws Exception
	 */
	public int getAllGoodsCount() throws Exception {
		int cnt = 0;
		String sql = "SELECT COUNT(*) as cnt FROM goods";
		ResultSet rs = db.executeQuery(sql);
		if (rs.next()) cnt = rs.getInt(1);
		return cnt;
	}
	
	public Goods selectGoodsOne(int goodsNo) throws Exception {
		Connection conn = db.getConnection();
		PreparedStatement stmt0 = null;	
		ResultSet rs0 = null;	
		Goods goods = null;
		
	try {
		String sql0 = """
		  		SELECT * FROM goods
		  		WHERE goods_no = ?
		""";
		stmt0 = conn.prepareStatement(sql0);
		stmt0.setInt(1, goodsNo);
		rs0 = stmt0.executeQuery();
				
		if(rs0.next()) {			
			 goods = converter.getGoods(rs0);
		}
		
	} catch (Exception e) {
		conn.rollback(); // 예외 발생 시 롤백
		throw e;
	} finally {	
		rs0.close();		
		stmt0.close();
		conn.close();
		
	}
		return goods;
	}
	
	public GoodsImg selectGoodsOneImg(int goodsNo) throws Exception {
		Connection conn = db.getConnection();
		PreparedStatement stmt0 = null;	
		ResultSet rs0 = null;	
		GoodsImg goods = null;
		
	try {
		String sql0 = """
		  		SELECT * FROM goods_img
		  		WHERE goods_no = ?
		""";
		stmt0 = conn.prepareStatement(sql0);
		stmt0.setInt(1, goodsNo);
		rs0 = stmt0.executeQuery();
				
		if(rs0.next()) {			
			 goods = converter.getGoodsImg(rs0);
		}
		
	} catch (Exception e) {
		conn.rollback(); // 예외 발생 시 롤백
		throw e;
	} finally {	
		rs0.close();		
		stmt0.close();
		conn.close();
		
	}
		return goods;
	}
}