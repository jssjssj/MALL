package vo;

public class Page {
	public int page;
	public String text;
	public boolean isActive;
	
	public Page(int page, String text) {
		this.page = page;
		this.text = text;
		this.isActive = false;
	}
	
	public Page(int page, String text, boolean isActive) {
		this.page = page;
		this.text = text;
		this.isActive = isActive;
	}
	
	@Override
	public String toString() {
		return this.text;
	}
}