package util;

import java.sql.ResultSet;
import vo.*;

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
	
	public Notice getNotice(ResultSet rs) {
		Notice notice = new Notice();
		try {			
			 notice.setNoticeNo(rs.getInt("notice_no"));
             notice.setManagerNo(rs.getInt("manager_no"));
             notice.setNoticeTitle(rs.getString("notice_title"));
             notice.setNoticeContent(rs.getString("notice_content"));
             notice.setCreatedate(rs.getString("createdate"));
             notice.setUpdatedate(rs.getString("updatedate"));
             
             Manager manager = new Manager();
             manager.setManagerName(rs.getString("manager_name"));
             notice.setManager(manager);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return notice;
	}
	
	public Manager getManager(ResultSet rs) {
		Manager manager = new Manager();
		try {			
			manager.setManagerNo(rs.getInt("manager_no"));
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerPw(rs.getString("manager_pw"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setCreatedate(rs.getString("createdate"));
			manager.setUpdatedate(rs.getString("updatedate"));
			manager.setActive(rs.getString("Active"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return manager;
	}
	
	public Question getQuetion(ResultSet rs) {
		Question question = new Question();
		try {
			question.setQuestionNo(rs.getInt("question_no"));
			question.setGoodsNo(rs.getInt("goods_no"));
			question.setCustomerNo(rs.getInt("customer_no"));
			question.setQuestionTitle(rs.getString("question_title"));
			question.setQuestionContent(rs.getString("question_content"));
			question.setCreatedate(rs.getString("createdate"));
			question.setUpdatedate(rs.getString("updatedate"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return question;
	}
}
