<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit</title>
<link rel='stylesheet' href='updateuser.css'>
</head>
<body>
	<div class="header">
		<a href="dashboard.jsp">Back</a>
	</div>
	<form action='updateuser.jsp' method='post' id='userForm'>
		<div class="title">
			<h2>Update user</h2>
		</div>
		<div class='form-field'>
		<label>UserId</label>
		<input type='number' name='userId' readonly>
		</div>
		<div class="form-field">
			<label>Fullname</label>
			<input type="text" name='fullname'>
		</div>
		<div class="form-field">
			<label>Contact No</label>
			<input type="number" name='contactno'>
		</div>
		<div class="form-field">
			<label>Role</label>
			<select name='role'>
				<option selected value="">SELECT ROLE</option>
				<option value="Admin">Admin</option>
				<option value="Client">Client</option>
				<option value="Manager">Manager</option>
			</select>
			
			<div class="button-field">
				<input type='submit' value="UpdateUser">
			</div>
			
		</div>
		
	</form>
<script>
	const params=new URLSearchParams(window.location.search);
	var userId=params.get('id');
	var fullName=params.get('fn');
	var contactno=params.get('user');
	var role=params.get('role');
	
	document.getElementById("userForm").userId.value=userId;
	document.getElementById("userForm").fullname.value=fullName;
	document.getElementById("userForm").contactno.value=contactno;
	document.getElementById("userForm").role.value=role;
</script>
</body>
</html>