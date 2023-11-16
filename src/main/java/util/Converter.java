package util;

import java.sql.ResultSet;
import java.util.Map;

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
	
	public Question getQuestion(ResultSet rs) {
		Question question = new Question();
		try {
			question.setQuestionNo(rs.getInt("question_no"));
			question.setGoodsNo(rs.getInt("goods_no"));
			question.setCustomerNo(rs.getInt("customer_no"));
			question.setQuestionTitle(rs.getString("question_title"));
			question.setQuestionContent(rs.getString("question_content"));
			question.setCreatedate(rs.getString("createdate"));
			question.setUpdatedate(rs.getString("updatedate"));
			Customer customer = new Customer();
			customer.setCustomerNo(rs.getInt("customer_no"));;
			customer.setCustomerId(rs.getString("customer_id"));
			customer.setCustomerPw(rs.getString("customer_pw"));
			customer.setCreatedate(rs.getString("createdate"));
			customer.setUpdatedate(rs.getString("updatedate"));
			customer.setActive(rs.getString("active"));
			CustomerDetail customerDetail = new CustomerDetail();
			customerDetail.setCustomerNo(rs.getInt("customer_no"));
			customerDetail.setCustomerName(rs.getString("customer_name"));
			customerDetail.setCustomerPhone(rs.getString("customer_phone"));
			customerDetail.setCreatedate(rs.getString("createdate"));
			customerDetail.setUpdatedate("updatedate");
			Goods goods = new Goods();
			goods.setGoodsNo(rs.getInt("goods_no"));
			goods.setGoodsTitle(rs.getString("goods_title"));
			goods.setGoodsPrice(rs.getInt("goods_price"));
			goods.setSoldout(rs.getString("soldout"));
			goods.setGoodsMemo(rs.getString("goods_memo"));
			goods.setCreatedate(rs.getString("createdate"));
			goods.setUpdatedate(rs.getString("updatedate"));
			QuestionComment questionComment = new QuestionComment();
			questionComment.setQuestionCommentNo(rs.getInt("question_comment_no"));
			questionComment.setQuestionNo(rs.getInt("question_no"));
			questionComment.setManagerNo(rs.getInt("manager_no"));
			questionComment.setComment(rs.getString("comment"));
			questionComment.setCreatedate(rs.getString("createdate"));
			questionComment.setUpdatedate(rs.getString("updatedate"));
			
			
			question.setCustomerDetail(customerDetail);
			question.setGoods(goods); 
			question.setCustomer(customer);
			question.setQuestionComment(questionComment);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return question;
	}
	
    public Manager createManagerFromMap(Map<String, Object> managerData) {
        Manager manager = new Manager();
        manager.setManagerNo((Integer) managerData.get("managerNo"));
        manager.setManagerId((String) managerData.get("managerId"));
        manager.setManagerPw((String) managerData.get("managerPw"));
        manager.setManagerName((String) managerData.get("managerName"));
        manager.setCreatedate((String) managerData.get("createdate"));
        manager.setUpdatedate((String) managerData.get("updatedate"));
        manager.setActive((String) managerData.get("active"));
        return manager;
    }
    
    public Cart getCart(ResultSet rs) {
    	Cart cart = new Cart();
    	try {
    		cart.setCartNo(rs.getInt("cart_no"));
    		cart.setGoodsNo(rs.getInt("goods_no"));
    		cart.setCustomerNo(rs.getInt("customer_no"));
    		cart.setQuantity(rs.getInt("quantity"));
    		cart.setCreatedate(rs.getString("createdate"));
    		cart.setUpdatedate(rs.getString("updatedate"));
            Customer customer = new Customer();
            customer.setCustomerNo(rs.getInt("customer_no"));
            Goods goods = new Goods();  
            goods.setGoodsNo(rs.getInt("goods_no"));
            goods.setGoodsTitle(rs.getString("goods_title"));
            goods.setSoldout(rs.getString("soldout"));
            goods.setGoodsPrice(rs.getInt("goods_price"));
            GoodsImg goodsImg = new GoodsImg();
            goodsImg.setFileName(rs.getString("filename"));
            cart.setGoodsImg(goodsImg);
            cart.setGoods(goods); 
            cart.setCustomer(customer);
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
     	return cart;
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
}
