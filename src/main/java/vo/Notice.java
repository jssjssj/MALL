package vo;

import lombok.Data;

@Data
public class Notice {
	private	int noticeNo;
	private	int managerNo;
	private	String noticeTitle;
	private	String noticeContent;
	private	String createdate;
	private	String updatedate;

}
