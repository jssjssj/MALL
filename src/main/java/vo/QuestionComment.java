package vo;

import lombok.Data;

@Data
public class QuestionComment {
	private	int questionCommentNo;
	private	int questionNo;
	private	int managerNo;
	private	String comment;
	private	String createdate;
	private	String updatedate;
	
}
