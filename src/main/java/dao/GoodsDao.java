package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBUtil;
import vo.Goods;
import vo.GoodsImg;

	public class GoodsDao {
		// 굿즈 등록 수정 삭제 시 이미지 조회를 위해 public GoodsImg  goodsimg= new GoodsImg(); 사용
		public GoodsImg  goodsimg= new GoodsImg(); 
	    // 상품 추가
	    public int insertGoods(Goods insertGoods) throws Exception {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();

	        // 입력(insert) SQL
	        String sql = "INSERT INTO goods"
			        		+ "(goods_title, goods_price, soldout, goods_memo, createdate, updatedate) "
			        		+ "VALUES(?, ?, ?, ?, now(), now())";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, insertGoods.getGoodsTitle());
	        stmt.setInt(2, insertGoods.getGoodsPrice());
	        stmt.setString(3, insertGoods.getSoldout());
	        stmt.setString(4, insertGoods.getGoodsMemo());

	        int row = stmt.executeUpdate();

	        if (row == 1) {
	            System.out.println("상품 생성 성공");
	        } else {
	            System.out.println("상품 생성 실패");
	        }

	        return row;
	    }

	    // 상품 정보 업데이트
	    public int updateGoods(Goods updateGoods) throws Exception {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();

	        // 업데이트 SQL
	        String sql = "UPDATE goods SET goods_title=?, "
			        		+ "goods_price=?, soldout=?, goods_memo=?, updatedate=now() "
			        		+ "WHERE goods_no=?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, updateGoods.getGoodsTitle());
	        stmt.setInt(2, updateGoods.getGoodsPrice());
	        stmt.setString(3, updateGoods.getSoldout());
	        stmt.setString(4, updateGoods.getGoodsMemo());
	        stmt.setInt(5, updateGoods.getGoodsNo());

	        int row = stmt.executeUpdate();

	        if (row == 1) {
	            System.out.println("상품 업데이트 성공");
	        } else {
	            System.out.println("상품 업데이트 실패");
	        }

	        return row;
	    }

	    // 상품 정보 삭제
	    public int deleteGoods(int goodsNo) throws Exception {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();

	        // 삭제 SQL
	        String sql = "DELETE FROM goods WHERE goods_no=?";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setInt(1, goodsNo);

	        int row = stmt.executeUpdate();

	        if (row == 1) {
	            System.out.println("상품 삭제 성공");
	        } else {
	            System.out.println("상품 삭제 실패");
	        }

	        return row;
	    }

	    // 상품 정보 조회
	    public List<Goods> selectGoods() throws Exception {
	        DBUtil dbUtil = new DBUtil();
	        Connection conn = dbUtil.getConnection();

	        // 조회 SQL
	        String sql = "SELECT * FROM goods";
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        ResultSet rs = stmt.executeQuery();

	        List<Goods> goodsList = new ArrayList<>();

	        while (rs.next()) {
	            Goods goods = new Goods();
	            goods.setGoodsNo(rs.getInt("goods_no"));
	            goods.setGoodsTitle(rs.getString("goods_title"));
	            goods.setGoodsPrice(rs.getInt("goods_price"));
	            goods.setSoldout(rs.getString("soldout"));
	            goods.setGoodsMemo(rs.getString("goods_memo"));
	            goods.setCreatedate(rs.getString("createdate"));
	            goods.setUpdatedate(rs.getString("updatedate"));
	            goodsList.add(goods);
	        }

	        return goodsList;
	    }
	}

