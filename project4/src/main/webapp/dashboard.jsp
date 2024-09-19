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
<title>Dashboard</title>
<link rel="stylesheet" href="dashboard.css">
<link
    href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"
    rel="stylesheet"
/>
</head>
<body>
	<%
	HttpSession session1=request.getSession();
	String user=(String)session1.getAttribute("user");
	String fullname="";
	int noOfUsers=0;
	if(user==null){
		response.sendRedirect("index.jsp");
	}else{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/project4","root","Subham102@");
			String sql="SELECT Fullname FROM register WHERE Username=?";
			PreparedStatement stmt=con.prepareStatement(sql);
			stmt.setString(1, user);
			ResultSet rs=stmt.executeQuery();
			if(rs.next()) {
				fullname=rs.getString(1);
			}	
			stmt.close();
			PreparedStatement stmt1=con.prepareStatement("SELECT COUNT(*) FROM users");
			ResultSet rs1=stmt1.executeQuery();
			if(rs1.next()){
				noOfUsers=rs1.getInt(1);
			}
			stmt1.close();
			con.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
%>
	
	<div class="header">
		<h2>Welcome,<%=fullname %></h2>
		<a href="logout.jsp">Logout</a>
	</div> 
	<div class="container1">
		<a href="adduser.jsp">Add User</a>
		<p> <%=noOfUsers %> users</p>
	</div>
	<div class="main-container">
		<div class="container2" >
			<div class="input-field">
				<label>Enter Fullname to filter</label>
				<input type="text" id='userInput' onkeyup='return filterTable()'>
			</div>
			<table>
				<thead>
					<tr>
						<th>#</th>
						<th>Fullname</th>
						<th>ContactNo</th>
						<th>Role</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody id='table'>
					<%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project4", "root", "Subham102@");
                        String sql = "SELECT * FROM users";
                        PreparedStatement stmt = con.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();
                        boolean hasUsers = false;
                        while (rs.next()) {
                            hasUsers = true;
                    %>
                            <tr>
                                <td><%= rs.getInt(1) %></td>
                                <td><%= rs.getString(2) %></td>
                                <td><%= rs.getString(3) %></td>
                                <td><%= rs.getString(4) %></td>
                                <td>
                                    <a href='edit.jsp?id=<%= rs.getInt(1) %>&fn=<%= rs.getString(2) %>&user=<%= rs.getString(3) %>&role=<%= rs.getString(4) %>' style="padding: 3px 10px; text-decoration: none; color: blue;">
                                        <i class="ri-pencil-fill"></i>
                                    </a>
                                    <a href='delete.jsp?UserId=<%= rs.getInt(1) %>' style="padding: 3px 10px; text-decoration: none; color: blue;">
                                        <i class="ri-delete-bin-fill"></i>
                                    </a>
                                </td>
                            </tr>
                    <%
                        }
                        if (!hasUsers) {
                    %>
                            <tr>
                                <td colspan="5">No Users Available!!</td>
                            </tr>
                    <%
                        }
                        stmt.close();
                        con.close();
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
      %>
					
					
				</tbody>
			</table>
		</div>
	</div>
	<script>
	function filterTable(){
		var userInput = document.getElementById("userInput").value.toLowerCase();
		var table = document.getElementById("table");
		var trs = table.getElementsByTagName("tr");

		for (let i = 0; i < trs.length; i++) {
			var tds = trs[i].getElementsByTagName("td");
			if (tds.length > 0) {
				var fullname = tds[1].textContent.toLowerCase();
				if (fullname.indexOf(userInput) > -1) {
					trs[i].style.display = "";
				} else {
					trs[i].style.display = "none";
				}
			}
		}
	}
</script>
</body>
</html>