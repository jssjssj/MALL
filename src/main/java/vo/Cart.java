package vo;

public class Cart {
	private	int cartNo;
	private	int goodsNo;
	private	int customerNo;
	private	int quantity;
	private	String createdate;
	private	String updatedate;
	private int endPrice;
	private int midPrice;
	
	
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public int getEndPrice() {
		return endPrice;
	}
	public void setEndPrice(int endPrice) {
		this.endPrice = endPrice;
	}
	public int getMidPrice() {
		return midPrice;
	}
	public void setMidPrice(int midPrice) {
		this.midPrice = midPrice;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public GoodsImg getGoodsImg() {
		return goodsImg;
	}
	public void setGoodsImg(GoodsImg goodsImg) {
		this.goodsImg = goodsImg;
	}
	Customer customer;
	Goods goods;
	GoodsImg goodsImg;
	
	
	
	
}
