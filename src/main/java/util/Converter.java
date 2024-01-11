package util;

import java.sql.ResultSet;
import java.util.Map;

import vo.*;

public class Converter {	
	 public Cart getCart(ResultSet rs) {
	    	Cart param = new Cart();
	    	try {
	    		param.setCartNo(rs.getInt("cart_no"));
	    		param.setGoodsNo(rs.getInt("goods_no"));
	    		param.setCustomerNo(rs.getInt("customer_no"));
	    		param.setQuantity(rs.getInt("quantity"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));	            
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public Customer getCustomer(ResultSet rs) {
		 Customer param = new Customer();
	    	try {
	    		param.setCustomerNo(rs.getInt("customer_no"));
	    		param.setCustomerId(rs.getString("customer_id"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    		param.setActive(rs.getString("active"));
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public CustomerAddr getCustomerAddr(ResultSet rs) {
		 CustomerAddr param = new CustomerAddr();
	    	try {
	    		param.setCustomerAddrNo(rs.getInt("customer_addr_no"));
	    		param.setCustomerNo(rs.getInt("customer_no"));
	    		param.setAddress(rs.getString("address"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    		
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public CustomerDetail getCustomerDetail(ResultSet rs) {
		 CustomerDetail param = new CustomerDetail();
	    	try {
	    		param.setCustomerNo(rs.getInt("customer_no"));
	    		param.setCustomerName(rs.getString("customer_name"));
	    		param.setCustomerPhone(rs.getString("customer_phone"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    		
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public CustomerPwHistory getCustomerPwHistory(ResultSet rs) {
		 CustomerPwHistory param = new CustomerPwHistory();
	    	try {
	    		param.setCustomerPwHistoryNo(rs.getInt("customer_pw_history_no"));
	    		param.setCustomerNo(rs.getInt("customer_no"));
	    		param.setCustomerPw(rs.getString("customer_pw"));
	    		param.setCreatedate(rs.getString("createdate"));    		
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public Goods getGoods(ResultSet rs) {
		 Goods param = new Goods();
	    	try {
	    		param.setGoodsNo(rs.getInt("goods_no"));
	    		param.setGoodsTitle(rs.getString("goods_title"));
	    		param.setGoodsPrice(rs.getInt("goods_price"));
	    		param.setSoldout(rs.getString("soldout"));
	    		param.setGoodsMemo(rs.getString("goods_memo"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 	
	 public GoodsImg getGoodsImg(ResultSet rs) {
		 GoodsImg param = new GoodsImg();
	    	try {
	    		param.setGoodsNo(rs.getInt("goods_no"));
	    		param.setFileName(rs.getString("filename"));
	    		param.setOriginName(rs.getString("origin_name"));
	    		param.setFileType(rs.getString("content_type"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public Manager Manager(ResultSet rs) {
		 Manager param = new Manager();
	    	try {
	    		param.setManagerNo(rs.getInt("manager_no"));
	    		param.setManagerId(rs.getString("manager_id"));
	    		param.setManagerName(rs.getString("manager_name"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    		param.setActive(rs.getString("active"));
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public ManagerPwHistory getManagerPwHistory(ResultSet rs) {
		 ManagerPwHistory param = new ManagerPwHistory();
	    	try {
	    		param.setManagerPwHistoryNo(rs.getInt("manager_pw_history_no"));
	    		param.setManagerNo(rs.getInt("manager_no"));
	    		param.setManagerPw(rs.getString("manager_pw"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public Notice getNotice(ResultSet rs) {
		 Notice param = new Notice();
	    	try {
	    		param.setNoticeNo(rs.getInt("notice_no"));
	    		param.setManagerNo(rs.getInt("manager_no"));
	    		param.setNoticeTitle(rs.getString("notice_title"));
	    		param.setNoticeContent(rs.getString("notice_content"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public Orders getOrders(ResultSet rs) {
		 Orders param = new Orders();
	    	try {
	    		param.setOrdersNo(rs.getInt("orders_no"));
	    		param.setGoodsNo(rs.getInt("goods_no"));
	    		param.setCustomerNo(rs.getInt("customer_no"));
	    		param.setCustomerAddrNo(rs.getInt("customer_addr_no"));
	    		param.setQuantity(rs.getInt("quantity"));
	    		param.setTotalPrice(rs.getInt("total_price"));
	    		param.setOrdersState(rs.getString("orders_state"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));	    		
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public Question getQuestion(ResultSet rs) {
		 Question param = new Question();
	    	try {
	    		param.setQuestionNo(rs.getInt("question_no"));
	    		param.setGoodsNo(rs.getInt("goods_no"));
	    		param.setCustomerNo(rs.getInt("customer_no"));
	    		param.setQuestionTitle(rs.getString("question_title"));
	    		param.setQuestionContent(rs.getString("question_content"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public QuestionComment QuestionComment(ResultSet rs) {
		 QuestionComment param = new QuestionComment();
	    	try {
	    		param.setQuestionCommentNo(rs.getInt("question_comment_no"));
	    		param.setQuestionNo(rs.getInt("question_no"));
	    		param.setManagerNo(rs.getInt("manager_no"));
	    		param.setComment(rs.getString("comment"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
	 
	 public Review getReview(ResultSet rs) {
		 Review param = new Review();
	    	try {
	    		param.setReviewNo(rs.getInt("goods_no"));
	    		param.setOrdersNo(rs.getInt("goods_no"));
	    		param.setReviewContent(rs.getString("goods_memo"));
	    		param.setCreatedate(rs.getString("createdate"));
	    		param.setUpdatedate(rs.getString("updatedate"));
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	     	return param;
	    }
}
