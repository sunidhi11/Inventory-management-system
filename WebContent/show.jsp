<%@page import="java.util.ArrayList"%>
<%@page import="sis.User" %>
<%@include file="admin_header.jsp"%>
<hr style="background-color:#92d2a7;width:100%;height:40px;">

<%
    
	java.util.ArrayList< User > arr = (java.util.ArrayList< User >) request.getAttribute("userArray");
%>

	<center>
	<table style="border:3px solid black;magin-bottom:20px;" cellspacing="8" cellpadding="10">
		<tr >
			<th style="border:3px solid lightpink;color:red;font-size:30px;">User_Id</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">User_Name</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Email</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Gender</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Contact</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Address</th>
		</tr>
<%		
			for(User user : arr){
%>
		<tr >
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=user.getUserId() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=user.getUserName() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=user.getEmail() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=user.getGender() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=user.getContact() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=user.getAddress() %></td>
		</tr>
	
<%
	}
%>
	</table>
	</center>

<%@include file="admin_footer.jsp"%> 