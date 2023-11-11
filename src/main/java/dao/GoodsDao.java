package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.Converter;
import util.DBUtil;
import vo.Goods;
import vo.GoodsImg;

public class GoodsDao extends ClassDao {

	// 상품과 굿즈 이미지 등록
	public int insertGoods(Goods insertGoods, GoodsImg insertGoodsImg) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		conn.setAutoCommit(false); // 트랜잭션 시작

		try {
			// 상품 등록
			String goodsInsertSQL = "INSERT INTO goods "
					+ "(goods_title, goods_price, soldout, goods_memo, createdate, updatedate)"
					+ " VALUES(?, ?, ?, ?, now(), now())";
			PreparedStatement goodsInsertStmt = conn.prepareStatement(goodsInsertSQL);
			goodsInsertStmt.setString(1, insertGoods.getGoodsTitle());
			goodsInsertStmt.setInt(2, insertGoods.getGoodsPrice());
			goodsInsertStmt.setString(3, insertGoods.getSoldout());
			goodsInsertStmt.setString(4, insertGoods.getGoodsMemo());

			int goodsInsertRow = goodsInsertStmt.executeUpdate();

			// 굿즈 이미지 등록
			if (goodsInsertRow == 1) {
				String goodsImgInsertSQL = "INSERT INTO goods_img "
						+ "(goods_no, filename, origin_name, content_type, createdate, updatedate) "
						+ "VALUES(LAST_INSERT_ID(), ?, ?, ?, now(), now())";
				PreparedStatement goodsImgInsertStmt = conn.prepareStatement(goodsImgInsertSQL);
				goodsImgInsertStmt.setString(1, insertGoodsImg.getFileName());
				goodsImgInsertStmt.setString(2, insertGoodsImg.getOriginName());
				goodsImgInsertStmt.setString(3, insertGoodsImg.getContentType());

				int goodsImgInsertRow = goodsImgInsertStmt.executeUpdate();

				if (goodsImgInsertRow == 1) {
					conn.commit(); // 모든 작업이 성공하면 커밋
				} else {
					conn.rollback(); // 굿즈 이미지 등록에 실패하면 롤백
				}
			} else {
				conn.rollback(); // 상품 등록에 실패하면 롤백
			}

			return goodsInsertRow;

		} catch (Exception e) {
			conn.rollback(); // 예외 발생 시 롤백
			throw e;
		} finally {
			conn.setAutoCommit(true); // 트랜잭션 종료
			conn.close();
		}
	}

	// 상품 정보와 굿즈 이미지 정보 업데이트
	public int updateGoods(Goods updateGoods, GoodsImg updateGoodsImg) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

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
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

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
	public List<Goods> selectGoods() throws Exception {
		Connection conn = db.getConnection();
		List<Goods> result = new ArrayList<>();
		String sql = """
				  		SELECT g.*, gi.filename, gi.origin_name, gi.content_type
				  		FROM goods g
				  		LEFT JOIN goods_img gi ON g.goods_no = gi.goods_no
				""";

		try {
			// 조회 SQL
			ResultSet rs = db.executeQuery(sql);

			List<Goods> goodsList = new ArrayList<>();
			while (rs.next()) {
				Goods goods = converter.getGoods(rs);
				GoodsImg goodsImg = converter.getGoodsImg(rs);
				goods.setGoodsImg(goodsImg);
				goodsList.add(goods);
			}

			result = goodsList;
		} finally {
			conn.close(); // 연결 닫기
		}

		return result;
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
}