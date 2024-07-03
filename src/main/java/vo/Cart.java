package vo;

import lombok.Data;

@Data
public class Cart {
	private	int cartNo;
	private	int goodsNo;
	private	int customerNo;
	private	int quantity;
	private	String createdate;
	private	String updatedate;
	
}
