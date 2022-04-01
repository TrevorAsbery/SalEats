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
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class LoginDispatcher
 */


@WebServlet("/LoginDispatcher")
public class LoginDispatcher extends HttpServlet {
	
	
	 public class PasswordException extends Exception{
			public PasswordException(String name) {super(name);}
		}
		public class NotEmailException extends Exception{
			public NotEmailException(String email) {super(email);}
		}
		public class EmailDoesNotExistException extends Exception{
			public EmailDoesNotExistException(String email) {super(email);}
		}

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //TODO
    	
    	
    	
    	String email = (String) request.getParameter("email");
    	String Name;
    	String Password = (String) request.getParameter("password");
    	String SQLpswd;
    	String SQLemail;
    	
    	String emailPattern = "^[a-zA-Z0-9_+&*-]+(?:\\."
                + "[a-zA-Z0-9_+&*-]+)*@"
                + "(?:[a-zA-Z0-9-]+\\.)+[a-z"
                + "A-Z]{2,7}$";
    	
    	try {
    		
    		
    	//init your SQL connection
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_data", "root", "root");
	    PreparedStatement prep;
	    
	    
	    String sqlstr = "SELECT * FROM user_details WHERE email= ? ";
	    prep = conn.prepareStatement(sqlstr);
	    prep.setString(1, email);
	    ResultSet rset = prep.executeQuery();
	
	    
	    if(rset.next()) {
	    	Name = rset.getString("name");
	    	SQLpswd = rset.getString("password");
	    	SQLemail = rset.getString("email");
	    	if(!Password.equals(SQLpswd)) {
	    		throw new PasswordException(Password);
	    	}
	    	
	    	
	    	//cookie logic
	    	Name = Name.replace(" ", "+");
	    	Cookie cookie = new Cookie("username", Name);
	    	response.addCookie(cookie);
	    	response.sendRedirect("index.jsp");
	    	
	    	
	    }
	    else {
	    	throw new SQLException();
	    }
    	
    	}
    	catch(SQLException e) {
    		request.setAttribute("error", "Email not found");
        	getServletContext().getRequestDispatcher("/auth.jsp").forward(request, response);
        	System.out.println("Email not found");
    	} 
    	catch(PasswordException e) {
    		request.setAttribute("error", "Incorrect Password");
        	getServletContext().getRequestDispatcher("/auth.jsp").forward(request, response);
        	System.out.println("Incorrect Password");
    	}
    	catch (Exception e) {
			// TODO Auto-generated catch block
    		request.setAttribute("error", "Email not found");
        	getServletContext().getRequestDispatcher("/auth.jsp").forward(request, response);
        	System.out.println("Email not found");
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
        doGet(request, response);
    }
}
