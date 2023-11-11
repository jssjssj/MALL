package util;

import java.sql.ResultSet;

import vo.Goods;
import vo.GoodsImg;

public class Converter {
	public Goods getGoods(ResultSet rs) {
		Goods goods = new Goods();
		try {			
			goods.setGoodsNo(rs.getInt("goods_no"));
			goods.setGoodsTitle(rs.getString("goods_title"));
			goods.setGoodsPrice(rs.getInt("goods_price"));
			goods.setSoldout(rs.getString("soldout"));
			goods.setGoodsMemo(rs.getString("goods_memo"));
			goods.setCreatedate(rs.getString("createdate"));
			goods.setUpdatedate(rs.getString("updatedate"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return goods;
	}

	public GoodsImg getGoodsImg(ResultSet rs) {
		GoodsImg goodsImg = new GoodsImg();
		try {
            goodsImg.setFileName(rs.getString("filename"));
            goodsImg.setOriginName(rs.getString("origin_name"));
            goodsImg.setContentType(rs.getString("content_type"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return goodsImg;
	}
}
