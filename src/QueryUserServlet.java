import sis.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class QueryUserServlet
 */
public class QueryUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QueryUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection con = null;
		Statement stmt = null;
		
		ArrayList<User> arr = new ArrayList<User>();
		try{
						
			String field = request.getParameter("field");			
			String value = request.getParameter("value");
			
			response.setContentType("text/html");
						
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String user = "system";
			String pass = "root";
			con = DriverManager.getConnection(url,user,pass);
			
			stmt  = con.createStatement();
			String sql ="select * from users where "+field+"='"+value.toLowerCase().trim()+"'";
			ResultSet rs = stmt.executeQuery(sql);
			
			String userId=null;
			String userName=null;
			String email=null;    
			String contact=null;
			String gender=null;
			String address=null;
			boolean go = false;
			User user1=null;
			while(rs.next()){	
				System.out.println("*");
				user1 = new User();
				userId = rs.getString(1);
				user1.setUserId(userId);
				userName = rs.getString(2);
				user1.setUserName(userName);
				email = rs.getString(3);
				user1.setEmail(email);
				contact = rs.getString(4);
				user1.setContact(Long.parseLong(contact));
				gender = rs.getString(5);
				user1.setGender(gender);
				address = rs.getString(6);										
				user1.setAddress(address);
				arr.add(user1);
				go=true;
			}
			if(go==false){
				RequestDispatcher rd=request.getRequestDispatcher("dash");  
				 String error = new String("<h2 style='color:red;'>Invalid Details !! Please fill the form again .</h2>");
				 request.setAttribute("goodNews", error);
			       rd.forward(request, response);
			}
			System.out.println(field+" "+contact);
		      request.setAttribute("userArray",arr);
		      
		      RequestDispatcher rd=request.getRequestDispatcher("show.jsp");  			  
			  rd.forward(request, response);
			  
		}catch(Exception e){
			
			e.printStackTrace();
			/*RequestDispatcher rd=request.getRequestDispatcher("signin");  
			 String error = new String("<h2 style='color:red;'>Invalid Details !! Please fill the form again .</h2>");
			 request.setAttribute("error", error);
		       rd.forward(request, response);*/
		       
		}finally{
			try{
			if(con!=null){
				con.close();
			}
			}
			catch(SQLException e){
				e.printStackTrace();
			}
		}
	}

}
