package Util;
public class Location{
	
	
	private String address1;
	private String address2;
	private String address3;
	private String city;
	private String zip_code;
	private String country;
	private String state;
	
	
	public Location(String address1, String address2, String address3, String city, String zip_code, String country, String state) {
		this.address1 = address1;
		this.address2 = address2;
		this.address3 = address3;
		this.city = city;
		this.zip_code = zip_code;
		this.country = country;
		this.state = state;
	}
	
	public String get_display_address() {
		
		String addy = "";
		if(this.address1!=null && this.address1 != "") {addy+=(address1 + " ");}
		if(this.address2!=null && this.address2 != "") {addy+=(address2+ " ");}
		if(this.address3!=null && this.address3 != "") {addy+=(address3 + " ");}

		return addy + ", " + city + ", " + state + ", " + zip_code + ", "+ country; 
	}
	
	
	
	
	
	
	
}