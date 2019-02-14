import sis.Item;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class QueryUserServlet
 */
public class QueryProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection con = null;
		Statement stmt = null;
		
		ArrayList<Item> arr = new ArrayList<Item>();
		try{
						
			String field = request.getParameter("category");			
			String low = request.getParameter("low");
			String high = request.getParameter("high");
			
			response.setContentType("text/html");
						
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String user = "system";
			String pass = "root";
			con = DriverManager.getConnection(url,user,pass);
			
			stmt  = con.createStatement();
			String sql ="select * from items where CATEGORY = '"+field+"' and PRICE between '"+low+"' and '"+high+"'";
			ResultSet rs = stmt.executeQuery(sql);
			
			String itemId=null;
			String brand=null;
			String category=null;    
			String modelName=null;
			Long price =null;
			String image=null;
			
			boolean go = false;
			Item item=null;
			while(rs.next()){	
				
				item = new Item();
				itemId = rs.getString(1);
				item.setItemId(itemId);
				brand = rs.getString(2);
				item.setBrand(brand);
				category = rs.getString(3);
				item.setCategory(category);
				modelName = rs.getString(4);
				item.setModelName(modelName);
				price = Long.parseLong(rs.getString(5));
				item.setPrice(price);
				
				Blob blob = rs.getBlob("image");
				InputStream inputStream = blob.getBinaryStream();
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int bytesRead = -1;
				 
				while ((bytesRead = inputStream.read(buffer)) != -1) {
				    outputStream.write(buffer, 0, bytesRead);
				}
				 
				byte[] imageBytes = outputStream.toByteArray();
				 
				image = Base64.getEncoder().encodeToString(imageBytes);
				 
				inputStream.close();
				outputStream.close();
				
				//image = rs.getString("image");
				item.setImage(image);
				arr.add(item);
				go=true;
			}
			
			if(go==false){
				RequestDispatcher rd = request.getRequestDispatcher("dash");  
				String error = new String("<h2 style='color:red;'>Invalid Details !! Please fill the form again .</h2>");
				request.setAttribute("message", error);
			    rd.forward(request, response);
			}
			
		      request.setAttribute("userArray",arr);
		      
		      RequestDispatcher rd=request.getRequestDispatcher("showItem.jsp");  			  
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
