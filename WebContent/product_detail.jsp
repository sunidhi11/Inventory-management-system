<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sis.Item"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Base64"%>

<%@ include file="header.jsp"%>

<hr style="background-color:#82c7b2;width:100%;height:20px;">
<center>

<%
//TODO Auto-generated method stub
Connection con = null;
Statement stmt = null;

ArrayList<Item> arr = new ArrayList<Item>();
try{
				
		String field = request.getParameter("itemId");								
		response.setContentType("text/html");
					
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String user = "system";
		String pass = "root";
		con = DriverManager.getConnection(url,user,pass);
		
		stmt  = con.createStatement();
		String sql ="select * from items where item_id='"+field+"'"; 
		ResultSet rs = stmt.executeQuery(sql);
		
		String itemId=null;
		String brand=null;
		String category=null;    
		String modelName=null;
		Long price =null;
		String image=null;
								
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
			
		}		
			  
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

%>

<div id="product" style="width:60%;">
	
	<%
		for(Item item:arr){
	%>
	<div style="width:50%;height:100%;float:left;">
		<img alt="" src="data:image/jpg;base64,<%=item.getImage()%>" height="500" width="300">
	</div>
	
	<div style="width:50%;height:100%;float:left;font-size:30px;">
		<p>
		 Brand : <%=item.getBrand()%><br><br>
		 Category : <%=item.getCategory()%><br><br>
		 Model : <%=item.getModelName()%><br><br>
		 Price : <%=item.getPrice()%><br><br>
		 <form >
		 	<input type="hidden" name="itemId" value="<%=item.getItemId()%>">
		 	<input type="submit" value="Buy Now" style="background: #0066A2;color: white;border-style:outset;border-color: #0066A2;border: 1px solid #eee;height: 50px;width: 100px;font: bold 15px arial, sans-serif;box-shadow: 5px 5px 5px #eee;text-shadow:none;">
		 </form>
		</p>
	</div>
	<%} %>	
</div>
</center>