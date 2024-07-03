package vo;

import lombok.Data;

@Data
public class Review {
	private	int reviewNo;
	private	int ordersNo;
	private	String reviewContent;
	private	String createdate;
	private	String updatedate;
	
}
