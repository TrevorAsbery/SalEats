package Util;

import java.util.*;

/**
 * The class used to model a business
 */
public class Business {
    
    private String id;
    private String name;
    private String image_url;
    private String url;
    private Integer review_count;
    
    private ArrayList<Category> categories;
    private Double rating;
    
    private Location location;
    private String price;
    private String display_phone;

    
	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getImage_url() {
		return image_url;
	}
	public String getUrl() {
		return url;
	}
	public Integer getReview_count() {
		return review_count;
	}
	public ArrayList<Category> getCategories() {
		return categories;
	}
	public String getStringCategories() {
		String output = "";
		for(Category c: categories) {
			output+=c.getTitle()+ ", ";
		}

		return output;
	}
	public Location getLocation() {
		return location;
	}
	public Double getRating() {
		return rating;
	}
	public String getPrice() {
		if(price==null) {
			return "";
		}
		return price;
	}
	public String getDisplay_phone() {
		return display_phone;
	}
    
	public static void main(String[] args) {
		System.out.println("This shit sucks");
	}    
    
}

