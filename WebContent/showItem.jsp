<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sis.Item" %>
<%@include file="admin_header.jsp"%>
<hr style="background-color:#92d2a7;width:100%;height:40px;">

<%
    
	java.util.ArrayList< Item > arr = (java.util.ArrayList< Item >) request.getAttribute("userArray");
%>

	<center>
	<table style="border:3px solid black;magin-bottom:20px;" cellspacing="8" cellpadding="10">
		<tr >
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Item_Id</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Brand</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Category</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Model_Name</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Price</th>
			<th style="border:3px solid lightpink;color:red;font-size:30px;">Image</th>
		</tr>
<%		
			for(Item item : arr){
%>
		<tr >
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=item.getItemId() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=item.getBrand() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=item.getCategory() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=item.getModelName() %></td>
			<td style="border:3px solid lightpink;color:green;font-size:20px;"><%=item.getPrice() %></td>
			<td style="border:3px solid lightpink;"><img src="data:image/jpg;base64,<%=item.getImage()%>" width="240" height="300"/></td>
		</tr>
	
<%
	}
%>
	</table>
	</center>

<%@include file="admin_footer.jsp"%> 