package Util;

/**
 * The class used to model a business
 */
public class Category {
    
	
	private String alias;
	private String title;
	
	public Category(String alias, String title) {
		this.alias = alias;
		this.title = title;
	}
	
	public String getAlias() {
		return alias;
	}
	public String getTitle() {
		return title;
	}

}