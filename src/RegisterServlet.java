

import java.io.IOException;
import java.lang.Exception;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.SQLException;


/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
			long contact = 0;
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String contat = request.getParameter("contact");
			if(!contat.trim().isEmpty())
			{
				contact = Long.parseLong(contat);
			}			
			String gender = request.getParameter("gender");
			String address = request.getParameter("address");
			String password = request.getParameter("pass");
			
			response.setContentType("text/html");
			//System.out.println(""+name+"','"+email+"',"+contact+",'"+gender+"','"+address+"','"+password+"");
			if(name.trim().isEmpty() || email.trim().isEmpty() || !email.contains("@") || gender.trim().isEmpty() || address.trim().isEmpty() || password.trim().isEmpty()){
				 RequestDispatcher rd=request.getRequestDispatcher("reg");  
				 String error = new String("<h2 style='color:red;'>Invalid Details !! Please fill the form again .</h2>");
				 request.setAttribute("error", error);
			       rd.forward(request, response);
			}
			//System.out.println("ayush singh");
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String user = "system";
			String pass = "root";
			con = DriverManager.getConnection(url,user,pass);
			
			stmt  = con.createStatement();
			String sql ="insert into shop_user"
					+ "(user_name,email,contact,gender,address,password)"
					+ "values "
					+ "('"+name+"','"+email+"',"+contact+",'"+gender+"','"+address+"','"+password+"')";
			stmt.executeUpdate(sql);
			
			String goodNews = new String("<h2 style='color:red;'>Congratulation !! you are successfully registered<br>"
					+ "Please Login to continue.....</h2>");
			RequestDispatcher rd=request.getRequestDispatcher("signin");  			
			 request.setAttribute("goodNews", goodNews);
		       rd.forward(request, response);
			
		}
		catch(Exception e){
			e.printStackTrace();
			RequestDispatcher rd=request.getRequestDispatcher("reg");  
			 String error = new String("<h2 style='color:red;'>Invalid Details !! Please fill the form again .</h2>");
			 request.setAttribute("error", error);
		       rd.forward(request, response);
		}
		finally{
			try{
			if(con!=null){
				con.close();
			}}
			catch(SQLException e){
				e.printStackTrace();
			}
		}
	}

}
