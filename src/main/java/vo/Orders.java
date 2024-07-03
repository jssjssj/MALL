package vo;

import lombok.Data;

@Data
public class Orders {
	private int ordersNo;
	private int goodsNo;
	private int customerNo;
	private int customerAddrNo;
	private int quantity;
	private int totalPrice;
	private String ordersState;
	private String createdate;
	private String updatedate;

	
}
