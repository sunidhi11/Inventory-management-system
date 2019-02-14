<%@include file="admin_header.jsp"%>

<hr style="background-color:#92d2a7;width:100%;height:40px;">
<div id="content" style="width:100%;">

	<div id="users">
		<!-- <hr style="background-color:#82c7b2;width:100%;height:20px;"> -->
		<h1 style="background-color:ghostwhite;color:#bc4fbb;padding-left:65px;">Query Users</h1>
		<center>
		<%
			Object obj = request.getAttribute("message");
			if(obj!=null){
				String message = (String)obj;
				out.print(message);
			}				
		%>
		<fieldset style="width:70%;margin-bottom:20px;">
			<legend style="font-size:35px;color:purple">Users</legend>
			
			<form action="userservlet" method="post" style="background-color:ghostwhite;">
				<table cellspacing="30px" style="border:1px solid ghostwhite;border-collapse: separate; border-spacing: 20px;font-size:25px;color:#f51c7f;">				
					<!-- <tr><td>Id </td<td> <input type="id" ></td></tr> -->	
					<tr><td>Query based on</td> <td> <select name="field" style="font-size:15px;color:orchid;">
						  <option value="user_name">User Name</option>			
						  <option value="email">Email</option>
						  <option value="contact">Contact</option>
						  <option value="gender">Gender</option>
						  <option value="address">Address</option>							  
						</select>
					</td></tr>			
					<tr><td>Enter query value</td><td> <input name="value" ></td></tr>				
					
					 <tr><td><input type="submit" value="Query"></td></tr>
				</table>
			</form>
			
		</fieldset>
		</center>
	</div>
	<hr style="background-color:#82c7b2;width:100%;height:20px;">
	<div id="prod">
		<h1 style="background-color:ghostwhite;color:#bc4fbb;padding-left:65px;">Query Product</h1>
		<center>
		<fieldset style="width:70%;margin-bottom:20px;">
			<legend style="font-size:35px;color:purple">Products</legend>
			
			<form action="queryproduct" method="post" style="background-color:ghostwhite;">
				<table cellspacing="30px" style="border:1px solid ghostwhite;border-collapse: separate; border-spacing: 20px;font-size:25px;color:#f51c7f;">				
					
					<tr><td>Select Category</td><td> <select name="category" style="font-size:15px;color:orchid;">
						  <option value="mobile">Mobile</option>			
						  <option value="glasses">Sun Glasses</option>
						  <option value="watch">Watch</option>
						  <option value="shoes">Shoes</option>
						  <option value="ear">Earphones</option>							  
						</select>
					</td></tr>			
					<tr><td>Price Range</td><td> <!-- <select name="price" style="font-size:15px;color:orchid;"> -->
						  <input name="low" placeholder="Low" value="0">	-		
						  <input name="high" placeholder="High" value="100000">						  							 
						<!-- </select>  -->
					</td></tr>											
					 <tr><td><input type="submit" value="Query"></td></tr>
				</table>
			</form>
			
		</fieldset>
		</center>
	</div>
	<hr style="background-color:#82c7b2;width:100%;height:20px;">
	<div id="add">
		<h1 style="background-color:ghostwhite;color:#bc4fbb;padding-left:65px;">Add Product</h1>
		<center>
		<fieldset style="width:70%;margin-bottom:20px;">
			<legend style="font-size:35px;color:purple">Add</legend>
			
			<form action="addproduct" method="post"  enctype="multipart/form-data" style="background-color:ghostwhite;">
				<table cellspacing="30px" style="border:1px solid ghostwhite;border-collapse: separate; border-spacing: 20px;font-size:25px;color:#f51c7f;">				
						
					<tr><td>Brand</td><td> <input name="brand" ></td></tr>										
					<tr><td>Category</td><td> <select name="field" style="font-size:15px;color:orchid;">
						  <option value="mobile">Mobile</option>			
						  <option value="glasses">Sun Glasses</option>
						  <option value="watch">Watch</option>
						  <option value="shoes">Shoes</option>
						  <option value="ear">Earphones</option>							  
						</select>
					</td></tr>			
					<tr><td>Model Name</td><td> <input type="text" name="name" ></td></tr>
					<tr><td>Price</td><td> <input name="price" ></td></tr>												
					<tr><td>Product Image</td><td> <input name="image" type="file"> </td></tr>
					 <tr><td><input type="submit" value="Add"></td></tr>
				</table>
			</form>
			
		</fieldset>
		</center>
	</div>
	<hr style="background-color:#82c7b2;width:100%;height:20px;">
	<div id="mod">
		<h1 style="background-color:ghostwhite;color:#bc4fbb;padding-left:65px;">Modify Product</h1>
		<center>
		<fieldset style="width:70%;margin-bottom:20px;">
			<legend style="font-size:35px;color:purple">Modify</legend>
			
			<form action="sign" method="post" style="background-color:ghostwhite;">
				<table cellspacing="30px" style="border:1px solid ghostwhite;border-collapse: separate; border-spacing: 20px;font-size:25px;color:#f51c7f;">				
					<!-- <tr><td>Id </td<td> <input type="id" ></td></tr> -->	
					<!-- <tr><td>Change What ?</td><td> <select name="field" style="font-size:15px;color:orchid;">
						  <option value="mobile">Mobile</option>			
						  <option value="glasses">Sun Glasses</option>
						  <option value="watch">Watch</option>
						  <option value="shoes">Shoes</option>
						  <option value="ear">Earphones</option>							  
						</select>
					</td></tr>	 -->	
					<tr><td>Product Id</td><td> <input name="id" ></td></tr>
					<tr><td>Field to Change</td><td> <select name="place" style="font-size:15px;color:orchid;">
						  <option value="quantity">Quantity</option>			
						  <option value="price">Price</option>						  							 
						</select>
					</td></tr>		
					<tr><td>Modified value</td><td> <input name="value" ></td></tr>				
					
					 <tr><td><input type="submit" value="Modify"></td></tr>
				</table>
			</form>
			
		</fieldset>
		</center>
	</div>
	<hr style="background-color:#82c7b2;width:100%;height:20px;">
	<div id="del">
		<h1 style="background-color:ghostwhite;color:#bc4fbb;padding-left:65px;">Delete Products</h1>
		<center>
		<fieldset style="width:70%;margin-bottom:20px;">
			<legend style="font-size:35px;color:purple">Delete</legend>
			
			<form action="sign" method="post" style="background-color:ghostwhite;">
				<table cellspacing="30px" style="border:1px solid ghostwhite;border-collapse: separate; border-spacing: 20px;font-size:25px;color:#f51c7f;">				
					<!-- <tr><td>Id </td<td> <input type="id" ></td></tr> -->	
					<tr><td>Product Id</td><td> <input name="id" ></td></tr>													
					 <tr><td><input type="submit" value="Delete"></td></tr>
				</table>
			</form>
			
		</fieldset>
		</center>
	</div>

</div> 

<%@include file="admin_footer.jsp"%>