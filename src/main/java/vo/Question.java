package vo;

import lombok.Data;

@Data
public class Question {
	private	int questionNo;
	private	int goodsNo;
	private	int customerNo;
	private	String questionTitle;
	private	String questionContent;
	private	String createdate;
	private	String updatedate;
	
}
