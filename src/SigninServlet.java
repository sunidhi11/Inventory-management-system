

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SigninServlet
 */
public class SigninServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SigninServlet() {
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
		
		try{
						
			String email = request.getParameter("email");			
			String password = request.getParameter("pass");
			System.out.println(email+" "+password);
			response.setContentType("text/html");
						
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String user = "system";
			String pass = "root";
			con = DriverManager.getConnection(url,user,pass);
			
			stmt  = con.createStatement();
			String sql ="select * from shop_user where email='"+email.trim()+"'";
			ResultSet rs = stmt.executeQuery(sql);
			
			String name=null;
			boolean go = false;
			if(rs.next()){				
				String passw = rs.getString(6);
				name = rs.getString(1);								
				if(passw.trim().equals(password.trim()))
				{
					go=true;
				}
			}
			if(go==false){
				RequestDispatcher rd=request.getRequestDispatcher("signin");  
				 String error = new String("<h2 style='color:red;'>Invalid Details !! Please fill the form again .</h2>");
				 request.setAttribute("goodNews", error);
			       rd.forward(request, response);
			}
			  HttpSession session=request.getSession();  
		      session.setAttribute("name",name);
		      
		      //RequestDispatcher rd=request.getRequestDispatcher("index");  
			  String error = new String("<p style='color:red;font-size:20px;'>Welcome !! "+name+" .<form action=\"signout\" method=\"post\"> <input style=\"width=100px;\"type=\"submit\" value=\"Signout\" ></form>");
		      session.setAttribute("goodNews", error);
		      response.sendRedirect("index");
			  //rd.forward(request, response);
			  
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
