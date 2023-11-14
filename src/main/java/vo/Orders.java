package vo;



public class Orders {
	private int orderNo;
	private int goodsNo;
	private int customerNo;
	private int customerAddrNo;
	private int quantity;
	private int totalPrice;
	private String ordersState;
	private String createdate;
	private String updatedate;
	private int endPrice;
	
	
	
	CustomerAddr customerAddr; 
	Goods goods;
	Customer customer;
	CustomerDetail customerDetail;
	
	public int getEndPrice() {
		return endPrice;
	}
	public void setEndPrice(int endPrice) {
		this.endPrice = endPrice;
	}
	
	public CustomerDetail getCustomerDetail() {
		return customerDetail;
	}
	public void setCustomerDetail(CustomerDetail customerDetail) {
		this.customerDetail = customerDetail;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getOrdersState() {
		return ordersState;
	}
	public void setOrdersState(String ordersState) {
		this.ordersState = ordersState;
	}
	public CustomerAddr getCustomerAddr() {
		return customerAddr;
	}
	public void setCustomerAddr(CustomerAddr customerAddr) {
		this.customerAddr = customerAddr;
	}
	public Goods getGoods() {
		return goods;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public int getCustomerAddrNo() {
		return customerAddrNo;
	}
	public void setCustomerAddrNo(int customerAddrNo) {
		this.customerAddrNo = customerAddrNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getOrderState() {
		return ordersState;
	}
	public void setOrderState(String ordersState) {
		this.ordersState = ordersState;
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
	
	
}
