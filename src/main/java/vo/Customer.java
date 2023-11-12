package vo;

public class Customer {
	private	int customerNo;
	private	String customerId;
	private	String customerPw;
	private	String createdate;
	private	String updatedate;
	private	String active;
	

	
	CustomerAddr customerAddr; 
    CustomerDetail customerDetail; 
    
	public CustomerAddr getCustomerAddr() {
		return customerAddr;
	}
	public void setCustomerAddr(CustomerAddr customerAddr) {
		this.customerAddr = customerAddr;
	}
	public CustomerDetail getCustomerDetail() {
		return customerDetail;
	}
	public void setCustomerDetail(CustomerDetail customerDetail) {
		this.customerDetail = customerDetail;
	}
	public int getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomerPw() {
		return customerPw;
	}
	public void setCustomerPw(String customerPw) {
		this.customerPw = customerPw;
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
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
		
}
