package vo;

public class Page {
	int page;
	String text;
	public Page(int page, String text) {
		this.page = page;
		this.text = text;
	}
	
	@Override
	public String toString() {
		return this.text;
	}
}