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
		<legend style="font-size:35px;color:purple">Sign In</legend>
		<%
			
			Object obj = request.getAttribute("goodNews");
			if(obj != null)
			{
				String goodNews = (String)obj;
				out.println(goodNews);
			}			
		%>
		<form action="sign" method="post" style="background-color:ghostwhite;">
			<table cellspacing="30px" style="border:1px solid ghostwhite;border-collapse: separate; border-spacing: 20px;font-size:25px;color:#f51c7f;">				
				<!-- <tr><td>Id </td<td> <input type="id" ></td></tr> -->				
				<tr><td>Email </td><td> <input name="email" autofocus="autofocus"></td></tr>				
				<tr><td>Password </td><td><input type="password" name="pass"></td></tr>
				 <tr><td><input type="submit" value="Login"></td></tr>
			</table>
		</form>
		
	</fieldset>
	</center>
</body>
</html>