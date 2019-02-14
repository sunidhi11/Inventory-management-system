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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="style_index.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Insert title here</title>
</head>
<body>

	<div id = "main">
		
		<div id = "header" style = "width:100%;height:120px;">
			
			<div id = "left" style = "width:20%;height:120px;float:left;">
			
				<center>
					<img src = "images/logo.png" alt="logo" height="100" width="200">
				</center>
			
			</div>
			
			<div id = "center" style = "width:56%;height:100px;padding-top:20px;float:left;">
							
				<center>
					<form action="">
						<input type="text" placeholder="What are you searching for ?? " style="width:600px;font-size:30px;">
						<button style="width:110px;font-size:30px;"><a href="" style="text-decoration:none;">Search</a></button>
					</form>
				</center>
			
			</div>
			
			<div id = "right" style = "width:24%;height:100px;padding-top:20px;font-size:25px;float:left;">

				<%				
					Object obj = session.getAttribute("goodNews");
					if(obj != null)
					{
						String goodNews = (String)obj;
						out.print(goodNews);
						System.out.println(goodNews);
					}else{
						out.print("&nbsp&nbsp&nbsp&nbsp<a href=\"signin.jsp\"> Sign in </a>&nbsp<a href=\"register.jsp\"> Register </a>");
					}
				%>

<!-- 			&nbsp&nbsp&nbsp&nbsp<a href="signin.jsp"> Sign in </a>&nbsp
				<a href="register.jsp"> Register </a> -->
			
			</div>
			
		</div>
		<div id="navigation" style="width:100%;">
			<ul>
			  <li><a class="active" href="#home">Home</a></li>
			  <li><a href="#news">Offers & Deals</a></li>
			  <li><a href="#contact">Contact</a></li>
			  <li><a href="#about">About</a></li>
			  <li><a href="#about">Sort</a></li>
			</ul>
		</div>
		
		<div id="content"style = "margin-top:5px;">
			
			<%
					// TODO Auto-generated method stub
					Connection con = null;
					Statement stmt = null;
					
					ArrayList<Item> arr = new ArrayList<Item>();
					try{
									
						String field = request.getParameter("category");								
						response.setContentType("text/html");
									
						Class.forName("oracle.jdbc.driver.OracleDriver");
						String url = "jdbc:oracle:thin:@localhost:1521:XE";
						String user = "system";
						String pass = "root";
						con = DriverManager.getConnection(url,user,pass);
						
						stmt  = con.createStatement();
						String sql ="select * from items"; 
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
			<%
				for(Item item : arr){
			%>
				<div class ="product"style = "width:33%;height:350px;float:left;">
				
					<div style = "width:60%;height:350px;float:left;">
						<img alt="" src="data:image/jpg;base64,<%=item.getImage()%>" height="300" width="200">
					</div>
					 <div style = "width:40%;height:350px;float:left;padding-top:30px;font-size:18px;">
						<p>
						 Brand : <%=item.getBrand()%><br><br>
						 Category : <%=item.getCategory()%><br><br>
						 Model : <%=item.getModelName()%><br><br>
						 Price : <%=item.getPrice()%><br><br>
						 <form action="product_detail.jsp" method="post">
						 	<input type="hidden" name="itemId" value="<%=item.getItemId()%>">
						 	<input type="submit" value="Buy Now" style="background: #0066A2;color: white;border-style:outset;border-color: #0066A2;border: 1px solid #eee;height: 50px;width: 100px;font: bold 15px arial, sans-serif;box-shadow: 5px 5px 5px #eee;text-shadow:none;">
						 </form>						 									 
						</p>
					</div>
					
				</div>
			<%
				}
			%>
			
		<div id="footer" style="background-color:black;height:270px;float:left;width:100%;">
		<h1 style="color:Red;padding-left:20px;padding-top:10px;"><b>About Site</b></h1>	
		<!-- <div id="About_site" style="width:100%;height:150px;">-->
			
			<div id="bottom_left" style="width:45%;font-size:22px;height:68%;margin-left:20px;float:left;">
				<center>
					<div style="width:90%;height:163px;background-color:#e3e3e6;color:white;">ayush</div>
				</center>
			</div>
			
			<div id="bottom_center" style="width:25%;font-size:22px;margin-left:20px;margin-top:10px;float:left;">
				<form action="feedback" method="post">						
						<table cellspacing="25px" style="border:1px solid ghostwhite;border-collapse: separate; border-spacing: 20px;font-size:18px;color:white;">											
							<tr><td>Email </td><td> <input name="email" autofocus="autofocus"></td></tr>				
							<tr><td>Feedback </td><td><input  name="feedback"></td></tr>
							 <tr><td><input type="submit" value="Submit"></td></tr>
						</table>
					</form>
			</div>
			
			<div id="bottom_right" style="width:25%;color:ghostwhite;font-size:22px;margin-left:20px;margin-top:10px;float:left;">
				
					<center>
					<img src="images/ayush_77.jpg" alt="" style="border-radius:50%;" height="95" width="85">
					<h3>Ayush Singh</h3>					
					
					 </center>
				
			</div>
									
		</div>				
	
	</div>
	
</div>

</body>

</html>