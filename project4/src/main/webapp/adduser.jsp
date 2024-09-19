<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add User</title>
<link rel="stylesheet" href="adduser.css">
</head>
<body>
	<%
		String fullname=request.getParameter("fullname");
		String contactno=request.getParameter("contactno");
		String role=request.getParameter("role");
		
		if(fullname!=null || contactno!=null || role!=null){
			try{
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/project4","root","Subham102@");
				String sql="INSERT INTO users(Fullname,ContactNo,Role) VALUES(?,?,?)";
				PreparedStatement stmt=con.prepareStatement(sql);
				stmt.setString(1,fullname);
				stmt.setString(2,contactno);
				stmt.setString(3,role);
				
				stmt.executeUpdate();
				stmt.close();
				con.close();
				response.sendRedirect("dashboard.jsp");
				
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
	%>
	<div class="back">
		<a href="dashboard.jsp">Back</a>
	</div>
	<form action="adduser.jsp" method="post" id='userForm' onsubmit="return validateForm()">
		<div class="title">
			<h2>User Form</h2>
		</div>
		<div class="form-field">
			<label>Fullname</label>
			<input type="text" name="fullname">
		</div>	
		<div class="form-field">
			<label>Contact</label>
			<input type="number" name="contactno">
		</div>	
		<div class="form-field">
			<label>Role</label>
			<select name="role">
				<option selected value="">SELECT ROLE</option>
				<option value="Admin">Admin</option>
				<option value="Client">Client</option>
				<option value="Manager">Manager</option>
			</select>
		</div>
		<div class="button-field">
			<input type="Submit" value="Add User">
			
		</div>	
	</form>
	<script>
		function validateForm(){
			var fullname=document.getElementById("userForm").fullname.value;
			var contactno=document.getElementById("userForm").contactno.value;
			var role=document.getElementById("userForm").role.value;
			if(fullname === '' || contactno === '' || role === ''){
				alert("All fields required");
				return false;
			}
			if(contactno.length!=10){
				alert("Invalid contact number!!")
				return false
			}
			return true;
		}
	</script>
</body>
</html>