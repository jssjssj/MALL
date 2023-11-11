package vo;

public class Page {
	public int page;
	public String text;
	public Page(int page, String text) {
		this.page = page;
		this.text = text;
	}
	
	@Override
	public String toString() {
		return this.text;
	}
}