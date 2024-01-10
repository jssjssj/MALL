package vo;

import org.apache.tomcat.util.http.fileupload.MultipartStream;

public class GoodsForm {
	private String goodsTitle;
	private int goodsPrice;
	private String soldout;
	private String goodsMemo;
	private MultipartStream goodsImg;
	
	
	public String getGoodsTitle() {
		return goodsTitle;
	}
	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}
	public int getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(int goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public String getSoldout() {
		return soldout;
	}
	public void setSoldout(String soldout) {
		this.soldout = soldout;
	}
	public String getGoodsMemo() {
		return goodsMemo;
	}
	public void setGoodsMemo(String goodsMemo) {
		this.goodsMemo = goodsMemo;
	}
	public MultipartStream getGoodsImg() {
		return goodsImg;
	}
	public void setGoodsImg(MultipartStream goodsImg) {
		this.goodsImg = goodsImg;
	}
	
	
}
