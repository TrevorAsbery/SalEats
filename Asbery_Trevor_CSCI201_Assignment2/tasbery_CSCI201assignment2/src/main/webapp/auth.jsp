<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@page import="java.util.ArrayList" %>
<%@page import="Util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta content="301645777112-2rlc9gth0f5d4reimjcm9bf0kj7ahec0.apps.googleusercontent.com"
          name="google-signin-client_id">
    <title>Login / Register</title>
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin href="https://fonts.gstatic.com" rel="preconnect">
    <link
            href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
            rel="stylesheet">
    <script crossorigin="anonymous"
            src="https://kit.fontawesome.com/3204349982.js"></script>
    <script async defer src="https://apis.google.com/js/platform.js"></script>
    <link href="index.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto"
          rel="stylesheet" type="text/css">
    <script src="https://apis.google.com/js/api:client.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <meta name="google-signin-client_id" content="218737894090-euae3pc9vtfem9b6aqm5atmabhsa85ak.apps.googleusercontent.com">
    
    


</head>
<body>

        <script>
        	function onSignIn(googleUser){
        		var profile = googleUser.getBasicProfile();
        		var auth2 = gapi.auth2.getAuthInstance();
        		auth2.disconnect();
        		document.cookie = "username=" + profile.getName().split(" ").join("+");
        		window.location = "GoogleDispatcher";
        	}

        </script>


<c:set var = "mes" value = "${requestScope.error}"/>
<c:if test="${mes != null && mes !=''}">
<div id= "errormes" style="background: #FF7F7F;">
<h2  style= "height: 40px; color: #2a2a2a; padding: 40px 40px; font-size: 14px; text-align: center; vertical-align: middle;" >
	${mes}
</h2>
</div>
</c:if>




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
   
   <div class="authenication">
   
   <div class="Login_container">
   
   <div class = "Login">
   
   		<h1>Login</h1>
   
       <form action="LoginDispatcher" method = "GET">
      
        <label for="email">Email</label>
        
		<input type = "text" name = "email" style= "height: 20px; width: 100%;"  required /> <br /><br />
		
		<label for="password">Password</label>
		
        <input type = "password" name = "password" style= "height: 20px; width: 100%;" required /> <br /><br />
        
        <script src="https://kit.fontawesome.com/yourcode.js" crossorigin="anonymous"></script>
        <button type= "submit" id="signin" class = "button1" style= "border: none;height: 30px; width: 100%; background: #D21404;color: white"><i class="fas fa-sign-in-alt"></i> Sign In</button><br /> 
        
        <div class="g-signin2" data-onsuccess="onSignIn" data-theme= "dark" data-width="475%">
        	<button type= "submit" id="google" class = "button2" ><i class="fab fa-google"></i> Sign In With Google</button>
        </div>
     	</form>
   
   </div>
   
   <div class = "Register">
   		
   		<h1>Register</h1>
   
        <form action="RegisterDispatcher" method = "GET" >
      
        <label for="email">Email</label>
        
		<input type = "text" name = "email" style= "height: 20px; width: 100%;" required /> <br /><br />
		
		<label for="name">Name</label>
		
        <input type = "text" name = "name" style= "height: 20px; width: 100%;" required /> <br /><br />
		
		<label for="password">Password</label>
		
        <input type = "password" name = "password" style= "height: 20px; width: 100%;" required /> <br /><br />
        
       	<label for="confirm_password">Confirm Password</label>
		
        <input type = "password" name = "confirm_password" style= "height: 20px; width: 100%;" required /> <br /><br />
       
        <input type = "checkbox" name = "terms" value = "terms" required>
        <label for="terms">I have read the terms and conditions of SalEats!</label>
        
        <br><br />
       
      	<script src="https://kit.fontawesome.com/yourcode.js" crossorigin="anonymous"></script>
        <button type= "submit" id="createaccount" class = "button1" style= "border: none;height: 30px; width: 100%;background: #D21404; color: white"><i class="fas fa-user-plus"></i> Create Account</button>

        
     	</form>
   
   </div>
   
   </div>
   
   </div>
   
</body>
</html>