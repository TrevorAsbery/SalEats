<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
            rel="stylesheet">
    <link rel="stylesheet" href="index.css">
    
    <script src="https://kit.fontawesome.com/3204349982.js"
            crossorigin="anonymous"></script>

    <%
        //TODO perform search
        
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
        //TODO check if logged in
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
   
   <br><br><br>
   
   <h1 style = "margin-left: 50px"> Results for <%=keyWord%> in <%=searchType.replace("_", " ")%></h1>
   
   
   <c:set var = "data" value = "${requestScope.restaurants}"/>
   
   <c:forEach items= "${data}" var="restaurants">
   
   
	   <c:url value="details.jsp" var="myURL">
		   <c:param name="image" value="${restaurants.getImage_url()}" />
		   <c:param name="name" value="${restaurants.getName()}" />
		   <c:param name="address" value="${restaurants.getLocation().get_display_address()}" />
		   <c:param name="phone" value="${restaurants.getDisplay_phone()}" />
		   <c:param name="price" value="${restaurants.getPrice()}" />
		   <c:param name="url" value="${restaurants.getUrl()}" />
		   <c:param name="rating" value="${restaurants.getRating()}" />
		   <c:param name="category" value="${restaurants.getStringCategories()}" />
	   </c:url>
   

    <hr style="width:90%">
   
   <div>
   	<div class="container">

   		<div class="images">
   			<img style="height: 300px; width: 300px; border-radius:20px; margin-left: 100px"src='<c:url value = "${restaurants.image_url}"/>'> <br>
   		</div>
   		
   		<div class = "details" style="font-size:20px">
   			<a href="${myURL}" style="font-size:25px">${restaurants.name}</a> <br><br>
   			Price: <c:out value="${restaurants.price}"/> <br><br>
   			Review Count: <c:out value= "${restaurants.review_count}"/> <br><br>
   			Rating: <c:forEach begin = "1" end = "${restaurants.rating}" varStatus = "loop">

				<span class="fa fa-star checked"></span>

			</c:forEach>
			
			<c:choose>
			<c:when test="${restaurants.rating eq 4.5 || restaurants.rating eq 3.5|| restaurants.rating eq 2.5|| restaurants.rating eq 1.5}">
			<span class="fa fa-star-half-o"></span>
			</c:when>
			<c:otherwise>
			</c:otherwise>
			</c:choose>

   			<br><br>
   			<a href = "<c:url value="${restaurants.url}"/>" target="_blank">Yelp Link</a>
   		
   		</div>
   		
   		
   		
   	
   	
   	</div>
   
   
   </div>
   
  
   
   </c:forEach>









</body>
</html>