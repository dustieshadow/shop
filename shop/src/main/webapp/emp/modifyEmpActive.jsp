<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>

<%
	System.out.println("---------------modifyEmpActive.jsp");

	String empId = null;
	String active = null;
	
	
	if(request.getParameter("empId")!= null){
		empId = request.getParameter("empId");
	}
	

	if(request.getParameter("active")!= null){
		active = request.getParameter("active");
	}
	
	System.out.println("empId : "+empId);
	System.out.println("active : "+active);
	
	
	if(session.getAttribute("loginEmp")==null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	
	if(active.equals("OFF")){
		
		String sql1 = "update emp set active = 'ON' WHERE emp_id =? and active = 'OFF' ";
		
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1,empId);
		
		int row = stmt1.executeUpdate();
		
		if(row==1){
			System.out.println("업데이트에 성공하였습니다. OFF에서 ON으로 변경");
			response.sendRedirect("/shop/emp/empList.jsp");
			
		}else{
			System.out.println("업데이트에 실패하였습니다.");
			response.sendRedirect("/shop/emp/empLoginForm.jsp");
			
		}


	} else{
		String sql1 = "update emp set active = 'OFF' WHERE emp_id =? and active = 'ON' ";
		
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1,empId);
		
		int row = stmt1.executeUpdate();
		
		if(row==1){
			System.out.println("업데이트에 성공하였습니다. ON에서 OFF로 변경");
			response.sendRedirect("/shop/emp/empList.jsp");
			
		}else{
			System.out.println("업데이트에 실패하였습니다.");
			response.sendRedirect("/shop/emp/empLoginForm.jsp");
			
		}

		
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

</body>
</html>