package vo;

public class Review {
	private	int reviewNo;
	private	int ordersNo;
	private	String reviewContent;
	private	String createdate;
	private	String updatdate;
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getOrdersNo() {
		return ordersNo;
	}
	public void setOrdersNo(int ordersNo) {
		this.ordersNo = ordersNo;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatdate() {
		return updatdate;
	}
	public void setUpdatdate(String updatdate) {
		this.updatdate = updatdate;
	}
	
}
