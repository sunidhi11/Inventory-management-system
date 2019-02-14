<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<div id = "head" style = "width:100%;height:120px;">
			
		<center>
			<img src = "images/logo.png" alt="logo" height="100" width="200">
		</center>
	
	</div>
	
	<hr style="background-color:#82c7b2;width:100%;height:20px;">
	<center>
	<fieldset style="width:70%;">
		<legend style="font-size:35px;color:purple">Registration</legend>
		<%
			
			Object obj = request.getAttribute("error");
			if(obj != null)
			{
				String error = (String)obj;
				out.println(error);
			}			
		%>		
		<form action="register" method="post" style="background-color:ghostwhite;">
			<table cellspacing="30px" style="border:1px solid ghostwhite;border-collapse: separate; border-spacing: 20px;font-size:25px;color:#f51c7f;">				
				<!-- <tr><td>Id </td<td> <input type="id" ></td></tr> 
				<tr><td>User id</td> <td><input name="enr_no" autofocus="autofocus"></td></tr>-->				
				<tr><td>Name</td> <td><input name="name" autofocus="autofocus"></td></tr>
				<tr><td>Email </td><td> <input name="email" ></td></tr>
				<tr><td>Contact No</td><td> <input name="contact" ></td></tr>
				<tr><td>Gender</td><td> <input name="gender" type="radio" value="male">Male<input name="gender" type="radio" value="female">Female</td></tr>
				<tr><td>Address </td><td> <input name="address" ></td></tr>
				<tr><td>Password </td><td><input type="password" name="pass"></td></tr>
				 <tr><td><input type="submit" value="Register"></td></tr>
			</table>
		</form>
		
	</fieldset>
	</center>
</body>
</html>