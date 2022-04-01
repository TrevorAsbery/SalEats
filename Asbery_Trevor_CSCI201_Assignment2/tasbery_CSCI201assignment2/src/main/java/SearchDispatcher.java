import javax.servlet.ServletConfig;
import Util.*;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

/**
 * Servlet implementation class SearchDispatcher
 */
@WebServlet("/SearchDispatcher")
public class SearchDispatcher extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;
    /**
     * Default constructor.
     */
    public SearchDispatcher() {
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext servletContext = getServletContext();
        // TODO get json file as stream, Initialize FakeYelpAPI by calling its initalize
        // method
        

        RestaurantDataParser.Init(Constant.FileName);
       
 
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	
    	String searchType = (String) request.getParameter("options");
    	String keyWord = (String) request.getParameter("search");
    	String sortBy = (String) request.getParameter("button");
    	
    	ArrayList<Business> arr = RestaurantDataParser.getBusinesses(keyWord, sortBy, searchType);
    	
    	request.setAttribute("restaurants", arr);
    	
    	getServletContext().getRequestDispatcher("/search.jsp").forward(request, response);
    	
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }
    
    
    
    
    
    
}