<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Util.*" %>

    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Home</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="index.css">
        <script src="https://kit.fontawesome.com/3204349982.js" crossorigin="anonymous"></script>
        <%//TODO iterate the cookie and check if user registered %>
        
        <%
        
   
        ArrayList<Business> businesses = new ArrayList<Business>();
        
        String searchType = (String) request.getParameter("options");
        if(searchType==null){
        	searchType = "";
        }
        String keyWord = (String) request.getParameter("search");
        if(keyWord==null){
        	keyWord = "";
        }
        String sortBy = (String) request.getParameter("button");
        if(sortBy==null){
        	sortBy = "";
        }
 
        %>
    </head>

    <body>
    
  <nav class="navbar">
      <div class="navbar__container">
      <div class="container">
        <a href="index.jsp" id="navbar__logo">SalEats!</a>
        
    
        <div class="cookies">
        
        <% Cookie cookies[] = request.getCookies(); 
        boolean loggedIn = false;
        if(cookies != null){
        	for(Cookie c: cookies){
        		if(c.getName().contentEquals("username")){
        			String name = c.getValue();
        			name = name.replace("+", " ");
        			loggedIn = true;
        			%><div class= "hello" style="margin-left: 20px; margin-top:5px;  font-size: 14px"> Hi <%=name%>!</div> <%
        		}
        	}
        }  
       %>
       
       </div>
       </div> 
        

        
        <ul class="navbar__menu">
          <li class="navbar__item">
            <a href="index.jsp" class="navbar__links">Home</a>
          </li>
          <li class="navbar__item">
       	<%if(!loggedIn){%>
       	<a href="auth.jsp" class="navbar__links">Login/Register</a>
       	<%} else{ %>
       	<a href="LogoutDispatcher" class="navbar__links">Logout</a>
       	<%} %>
          </li>
         </ul>
        
         
      </div>
      
         
    </nav>

    <hr>
      
      <div class="main">
        <div class="main__container">
            <div class="main__img--container">
                <img src="banner.jpeg" alt="" class="main__img">
            </div>
       </div>
       
       
	
       
       
     <form class="example" action="SearchDispatcher" method = "GET">
     
     <div class="searchcontainer">
       <div class="searchoptions">
       <select name="options" id="options" value=<%=searchType%>>
       		<option value="category">Category</option>
       		<option value="restaurantname">Restaurant Name</option>
       </select>
       </div>
       
  
       <!-- SEARCH -->
       
               <div class="searchbar">
                    <!-- Load icon library -->
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                    
                    <!-- The form -->
                   
                      <input type="text" placeholder="Search..." name="search" required value= <%=keyWord%>>
                      <button type="submit"><i class="fa fa-search"></i></button>
  
                </div>
                
 
                
                <!-- radio buttons -->
                <div class="radiobuttons" value= <%=sortBy%>>
                      <input type="radio" id="price" name="button" value="price" checked="checked">
                      <label for="price">Price</label><br>
                      <input type="radio" id="rating" name="button" value="rating" >
                      <label for="rating">Rating</label><br>  
                      <input type="radio" id="reviewcount" name="button" value="reviewcount" >
                      <label for="reviewcount">Review count</label><br><br>
                </div>
          </div>      
   </form>
   	</div>
   	
    
    </body>

    </html>