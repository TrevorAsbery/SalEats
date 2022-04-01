<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Details</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
            rel="stylesheet">
    <script src="https://kit.fontawesome.com/3204349982.js"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="index.css">
</head>
<%
    //TODO perform search

    //TODO check if logged in
%>

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
        			%><div class= "hello" style="margin-left: 20px; margin-top:5px; font-size: 14px"> Hi <%=name%>!</div> <%
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
    
         <form class="example" action="SearchDispatcher" method = "GET">
     
     <div class="searchcontainer">
       <div class="searchoptions">
       <select name="options" id="options">
       		<option value="category">Category</option>
       		<option value="restaurant_name">Restaurant Name</option>
       </select>
       </div>
       
  
       <!-- SEARCH -->
       
               <div class="searchbar">
                    <!-- Load icon library -->
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                    
                    <!-- The form -->
                   
                      <input type="text" placeholder="Search..." name="search" required>
                      <button type="submit"><i class="fa fa-search"></i></button>
  
                </div>
                
 
                
                <!-- radio buttons -->
                <div class="radiobuttons">
                    
                      <input type="radio" id="price" name="button" value="price" checked="checked">
                      <label for="price">Price</label><br>
                      <input type="radio" id="rating" name="button" value="rating">
                      <label for="rating">Rating</label><br>  
                      <input type="radio" id="reviewcount" name="button" value="reviewcount">
                      <label for="reviewcount">Review count</label><br><br>
                </div>
          </div>      
   </form>
    
    	  
		   <c:set var="image" value="${param.image}" scope="session" />
		   <c:set var="name" value="${param.name}" scope="session" />
		   <c:set var="address" value="${param.address}" scope="session" />
		   <c:set var="phone" value="${param.phone}" scope="session" />
		   <c:set var="price" value="${param.price}" scope="session" />
		   <c:set var="url" value="${param.url}" scope="session" />
		   <c:set var="rating" value="${param.rating}" scope="session" />
		   <c:set var="category" value="${param.category}" scope="session" />
	  

   
   <div>
   <h1 style = "margin-left: 100px"><c:out value="${sessionScope.name}"/></h1>
   	<div class="container">
   	
   		
   		
   		<div class="images">
   			<img style="height: 500px; width: 500px; border-radius:20px; margin-left: 100px"src='<c:url value = "${sessionScope.image}"/>'> <br>
   		</div>
   		
   		<div class = "details" style="font-size:20px">
   			
   			Address: <c:out value="${sessionScope.address}"/> <br><br>
   			<c:out value= "${sessionScope.phone}"/> <br><br>
   			Categories: <c:out value= "${sessionScope.category}"/> <br><br>
   			Price: <c:out value= "${sessionScope.price}"/> <br><br>
   			Rating: <c:out value= "${sessionScope.rating}"/> <br><br>
   		
   		</div>
   		
   		
   	
   	
   	
   	</div>
   
   
   </div>
   
  
   

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    







</body>
</html>