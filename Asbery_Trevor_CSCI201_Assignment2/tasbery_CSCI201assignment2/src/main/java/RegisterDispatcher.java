import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Serial;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.regex.Pattern;

/**
 * Servlet implementation class RegisterDispatcher
 */
@WebServlet("/RegisterDispatcher")
public class RegisterDispatcher extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    private static final String url = "jdbc:mysql://localhost:3306/PA4Users";

    /**
     * Default constructor.
     */
    public RegisterDispatcher() {
    }
    
    public class PasswordException extends Exception{
		public PasswordException(String name) {super(name);}
	}
	public class NotEmailException extends Exception{
		public NotEmailException(String email) {super(email);}
	}
	public class NameException extends Exception{
		public NameException(String email) {super(email);}
	}
	public class EmailExistsException extends Exception{
		public EmailExistsException(String email) {super(email);}
	}
	

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //TODO
    	
    	
    	
    	
    	
    	String email = (String) request.getParameter("email");
    	String Name = (String) request.getParameter("name");
    	String Password = (String) request.getParameter("password");
    	String ConfirmPassword = (String) request.getParameter("confirm_password");
    	
    	
    	System.out.println(email + " " + Name + " "+ Password+ " "+ ConfirmPassword);
    	
    	String emailPattern = "^[a-zA-Z0-9_+&*-]+(?:\\."
                + "[a-zA-Z0-9_+&*-]+)*@"
                + "(?:[a-zA-Z0-9-]+\\.)+[a-z"
                + "A-Z]{2,7}$";
    	

        try {
        	
        	//init your SQL connection
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data", "root", "root");
	        PreparedStatement prep;
	
	    	if(!Password.equals(ConfirmPassword)) {
	    		throw new PasswordException(Password);
	    	}
	    	else if(!Name.matches("^[ A-Za-z]+$")) {
	    		throw new NameException(Name);
	    	}
	    	else if(!email.matches(emailPattern)) {
	    		throw new NotEmailException(email);
	    	}
	    	
   
		  prep = conn.prepareStatement("SET SQL_SAFE_UPDATES=0;");
		  prep.execute();
	        
	        
	      prep = conn.prepareStatement("INSERT INTO user_details(email, name, password) VALUES(?,?,?)");
     	  prep.setString(1, email);
     	  prep.setString(2, Name);
     	  prep.setString(3, Password);
     	  prep.executeUpdate();
     	  
     	//cookie logic
	    Name = Name.replace(" ", "+");
	    Cookie cookie = new Cookie("username", Name);
	    response.addCookie(cookie);
	    response.sendRedirect("index.jsp");
    
		}
        catch (PasswordException e) {
        	request.setAttribute("error", "Passwords don't match");
        	getServletContext().getRequestDispatcher("/auth.jsp").forward(request, response);
        	System.out.println("Passwords don't match");
		}
        catch(NotEmailException e) {
        	request.setAttribute("error", "Invalid Email");
        	getServletContext().getRequestDispatcher("/auth.jsp").forward(request, response);
        	System.out.println("Thats not an email");
        }
        catch(SQLException e) {
        	request.setAttribute("error", "Email already exists");
        	getServletContext().getRequestDispatcher("/auth.jsp").forward(request, response);
        	System.out.println("Email already in database");
        }
        catch(NameException e) {
        	request.setAttribute("error", "Name is invalid");
        	getServletContext().getRequestDispatcher("/auth.jsp").forward(request, response);
        	System.out.println("Email already in database");
        }
        catch(Exception e) {
        	response.sendRedirect("auth.jsp");
        	e.printStackTrace();
        }

    	
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
