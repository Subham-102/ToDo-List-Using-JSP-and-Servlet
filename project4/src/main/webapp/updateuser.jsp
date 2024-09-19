
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
<title>Udpate</title>


</head>
<body>
<%
	String fullname=request.getParameter("fullname");
	String contactno=request.getParameter("contactno");
	String role=request.getParameter("role");
	String userId=request.getParameter("userId");
	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/project4","root","Subham102@");
			String sql="UPDATE users SET Fullname=?,ContactNo=?,Role=? WHERE userId=?";
			PreparedStatement stmt=con.prepareStatement(sql);
			stmt.setString(1, fullname);
			stmt.setString(2, contactno);
			stmt.setString(3, role);
			stmt.setString(4, userId);
			
			stmt.executeUpdate();
			stmt.close();
			con.close();
			
			response.sendRedirect("dashboard.jsp");
		}catch(Exception ex) {
			ex.printStackTrace();
		}
%>

</body>
</html>
