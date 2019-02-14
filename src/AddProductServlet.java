

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.RequestDispatcher;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.io.InputStream;
import java.sql.SQLException;


/**
 * Servlet implementation class AddProductServlet
 */
@MultipartConfig(maxFileSize = 16177216)
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String dbUser = "system";
	private String dbPassword = "root";
	private String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
	Connection con = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println(">>>>"+request.getParameter("brand"));	
		InputStream inputStream = null;
		boolean go = true;
		try{
			
			String brand = request.getParameter("brand");
			String field = request.getParameter("field");
			String name = request.getParameter("name");
			
			String price1 = request.getParameter("price");
			Long price = Long.parseLong(price1);
			Part filePart = request.getPart("image");	
			
			if(brand==null || field==null || name==null ||price==null ||filePart==null)
			{
				go = false;
			}else{
				
				System.out.println(filePart.getName());
				System.out.println(filePart.getSize());
				
				inputStream = filePart.getInputStream();
				Class.forName("oracle.jdbc.driver.OracleDriver");
				con = DriverManager.getConnection(dbURL,dbUser,dbPassword);
				
				String sql = "select * from counters where id=1";
				Long count = null;
				stmt = con.createStatement();	
				rs = stmt.executeQuery(sql);
				System.out.println(rs);
				if(rs.next()){					
					
					String user_count = rs.getString("user_count");
					String item_count = rs.getString("item_count");
					String order_count = rs.getString("order_count");
		            String id =  rs.getString("id");
					System.out.println(user_count+" "+item_count+" "+order_count+" "+id);
					if(item_count!=null){
						count = Long.parseLong(item_count);
						count++;
						System.out.println(count);
					}else{						
						go = false;						
					}
				}
				else{
					System.out.println("***");
				}
				sql = "insert into items"+
                      "(item_id,brand,category,model_name,price,image)"+
                      "values (?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "i_"+count);
				pstmt.setString(2, brand);
				pstmt.setString(3, field);
				pstmt.setString(4, name);
				pstmt.setLong(5, price);				
				if(inputStream!=null){
					pstmt.setBlob(6, inputStream);
				}else{
					go = false;
				}
				pstmt.executeUpdate();
				if(count!=null){
				sql = "update counters set item_count = "+count+" where id = 1";
				stmt.executeUpdate(sql);
				}
			}
			String message = null;
			if(go == false){			
				message = "addition unsuccessfull";
				request.setAttribute("message", message);
			}else{
				message = "addition successfull";
				request.setAttribute("message", message);
			}
			RequestDispatcher rd = request.getRequestDispatcher("dash");
			rd.forward(request,response);
		}catch(SQLException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
		finally{
			try{
				if(con!=null){
					con.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		
	}

}
