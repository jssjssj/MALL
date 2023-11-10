package vo;

public class Notice {
	private	int noticeNo;
	private	int managerNo;
	private	String noticeTitle;
	private	String noticeContent;
	private	String createdate;
	private	String updatedate;
	private Manager manager; // 작성 매니저 이름을 불러오기 위해 추가.
	
	
	
	public Manager getManager() {
	    if (manager == null) {
	        manager = new Manager();
	        // 여기에서 manager 객체의 필드들을 초기화
	    }
	    return manager;
	} 
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public int getManagerNo() {
		return managerNo;
	}
	public void setManagerNo(int managerNo) {
		this.managerNo = managerNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
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
