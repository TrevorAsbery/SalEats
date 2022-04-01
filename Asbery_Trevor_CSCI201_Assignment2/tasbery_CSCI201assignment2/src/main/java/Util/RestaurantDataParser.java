package Util;


import com.google.gson.*;
import com.google.gson.reflect.TypeToken;

import java.io.*;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.*;


/**
 * A class that pretends to be the Yelp API
 */
public class RestaurantDataParser {
    private static Boolean ready = false;
    public static List<Business> bizList= new ArrayList<Business>();
    public static BizArray helper;
    public static HashMap<String, Business> idMap = new HashMap<String, Business>();

    /**
     * Initializes the DB with json data
     *
     * @param responseString the Yelp json string
     */
    public static void Init(String responseString) {
        if (ready) {
            return;
        }
    
        
        //initialize a gson
        Gson gson = new Gson();
       
        //and fill up a business list from the json
       
		
		try {
			
			Type businesses = new TypeToken<List<Business>>(){}.getType();
	        
	        InputStream inputStream = RestaurantDataParser.class.getClassLoader().getResourceAsStream("/restaurant_data.json");
	        String text = new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
			helper = gson.fromJson(text, BizArray.class);
			bizList = helper.businesses;
			
			//fill idMap
			for(Business b: bizList) {
				idMap.put(b.getId(), b);
			}
			
		   //init your SQL connection
           Class.forName("com.mysql.cj.jdbc.Driver");
           Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_data", "root", "root");
           PreparedStatement prep;
           
           //for error checks
           prep = conn.prepareStatement("SET SQL_SAFE_UPDATES=0;");
           prep.execute();
           prep = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0;");
           prep.execute();
           
           //refresh the data for different uses
           prep = conn.prepareStatement("TRUNCATE TABLE Restaurant;");
           prep.execute();
           prep = conn.prepareStatement("TRUNCATE TABLE Restaurant_details;");
           prep.execute();
           prep = conn.prepareStatement("TRUNCATE TABLE Category;");
           prep.execute();
           prep = conn.prepareStatement("TRUNCATE TABLE Rating_details;");
           prep.execute();
           
           prep = conn.prepareStatement("Alter Table Category AUTO_INCREMENT=1;");
           prep = conn.prepareStatement("Alter Table Restaurant_details AUTO_INCREMENT=1;");
           prep = conn.prepareStatement("Alter Table Rating_details AUTO_INCREMENT=1;");
           
           //add all of the businesses to the table
           int counter = 1;
         
           for(Business b: bizList) {
        	   //inserts all rating details
        	   prep = conn.prepareStatement("INSERT INTO Rating_details(review_count, rating) VALUES(?,?)");
        	   prep.setInt(1, b.getReview_count());
        	   prep.setDouble(2, b.getRating());
        	   prep.execute();
        	   
        	   //all categories per business
        	   for(Category c: b.getCategories()){
        	
//        		   prep = conn.prepareStatement("INSERT INTO Category(category_name, restaurant_id) VALUES(?,?)");
//            	   prep.setString(1, c.getAlias());
//            	   prep.setString(2, b.getId());
//            	   prep.execute();
            	   
	        	   prep = conn.prepareStatement("INSERT INTO Category(category_name, restaurant_id) VALUES(?,?)");
	        	   prep.setString(1, c.getTitle());
	        	   prep.setString(2, b.getId());
	        	   prep.execute();
        	   
        	   }
        	   
        	   //restaurant_details
        	   prep = conn.prepareStatement("INSERT INTO Restaurant_details(image_url, address, phone_no, estimated_price, yelp_url) VALUES(?, ?, ?, ?, ?)");
        	   prep.setString(1, b.getImage_url());
        	   prep.setString(2, b.getLocation().get_display_address());
        	   prep.setString(3, b.getDisplay_phone());
        	   prep.setString(4, b.getPrice());
        	   prep.setString(5, b.getUrl());
        	   prep.execute();
 
        	   //restaurant
        	   prep = conn.prepareStatement("INSERT INTO Restaurant(restaurant_id, restaurant_name, details_id, rating_id) VALUES(?, ?, ?, ?)");
        	   prep.setString(1, b.getId());
        	   prep.setString(2, b.getName());
        	   prep.setInt(3, counter);
        	   prep.setInt(4, counter);
        	   prep.execute();
        	 
        	   counter++;
        	   
           }
        	   
     
            
        } catch (Exception e) {
        	
        	
        	
            e.printStackTrace();
            
            
            
        }
        ready = true;
        //TODO get businessHelper array from json
        //TODO iterate the businessHelper array and insert every business into the DB
    }

    public static Business getBusiness(String id) {
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
       return idMap.get(id);
    }

    /**
     * @param keyWord    the search keyword
     * @param sort       the sort option (price, review count, rating)
     * @param searchType search in category or name
     * @return the list of business matching the criteria
     */
    public static ArrayList<Business> getBusinesses(String keyWord, String sort, String searchType) {
        
        try {
        	ArrayList<Business> businesses = new ArrayList<Business>();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant_data", "root", "root");
 
       
        //TODO get list of business based on the param
        //searchType
        PreparedStatement prep;
        String SQLStr = "";
        //search type
        if(searchType.equals("category")) {
        	SQLStr = "SELECT r.restaurant_id, c.category_name, rd.rating, rd.review_count, d.estimated_price \n";
        	SQLStr+= "FROM Restaurant r, Category c, Restaurant_details d, Rating_details rd \n";
        	SQLStr+= "WHERE c.category_name LIKE '%" + keyWord + "%' \n";
        	SQLStr+= "AND r.rating_id = rd.rating_id \n";
        	SQLStr+= "AND c.restaurant_id = r.restaurant_id \n";
        	SQLStr+= "AND r.details_id = d.details_id \n";
        	SQLStr+="Order By ";
        }
        
        //restaurant name
        else{
        	SQLStr = "SELECT r.restaurant_id, r.restaurant_name, rd.rating, rd.review_count, d.estimated_price \n";
        	SQLStr+= "FROM Restaurant r, Category c, Restaurant_details d, Rating_details rd \n";
        	SQLStr+= "WHERE r.restaurant_name LIKE '%" + keyWord + "%' \n";
        	SQLStr+= "AND r.rating_id = rd.rating_id \n";
        	SQLStr+= "AND c.restaurant_id = r.restaurant_id \n";
        	SQLStr+= "AND r.details_id = d.details_id \n";
        	SQLStr+="Order By ";
        	
        }
        
        //sort
        switch(sort) {
        case "price": 
        	SQLStr+="d.estimated_price ASC";
        	break;
        
        case "rating": 
        	SQLStr+="rd.rating DESC";
        	break;
        	
        case "reviewcount": 
        	SQLStr+="rd.review_count DESC";
        	break;
        }
        
        prep = conn.prepareStatement(SQLStr);
        
        ResultSet rset = prep.executeQuery();
        
        while(rset.next()) {
        	
        	
        	if(idMap.containsKey(rset.getString("restaurant_id")) && !businesses.contains(getBusiness(rset.getString("restaurant_id")))) {
        		businesses.add(getBusiness(rset.getString("restaurant_id")));
        	}
        	
        	
        }

        
        return businesses;
        
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
		return null;

    }
    
    //main for testing purposes
    public static void main(String[] args) {
    	RestaurantDataParser.Init("\restaurant_data.json");
    	ArrayList<Business> arr = getBusinesses("W", "price", "restaurant_name");
    	
    	System.out.println();
    	for(Business b: arr) {
    		System.out.println(b.getName());
    	}
    	
    }
}
