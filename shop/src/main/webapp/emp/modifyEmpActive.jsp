<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("---------------modifyEmpActive.jsp");

	//쿼리1 실행위한 변수 생성
	String empId = null;
	String active = null;
	String msg = null;
	
	
	if(request.getParameter("empId")!= null){
		empId = request.getParameter("empId");
	}
	

	if(request.getParameter("active")!= null){
		active = request.getParameter("active");
	}
	
	System.out.println("empId : "+empId);
	System.out.println("active : "+active);
	
	//세션 없다면 로그인폼으로 이동
	if(session.getAttribute("loginEmp")==null){
		response.sendRedirect("/shop/emp/loginForm.jsp");
		return;
	}
	
 /*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1: / ", "", "");
	
	*/
	if(active.equals("OFF")){
		
		
		
		int row = EmpDAO.empActiveToOn(empId);
		
		if(row==1){
			System.out.println("업데이트에 성공하였습니다. OFF에서 ON으로 변경");
			msg = URLEncoder.encode("업데이트에 성공하였습니다. OFF에서 ON으로 변경","UTF-8");
			response.sendRedirect("/shop/emp/empList.jsp?msg="+msg);
			
		}else{
			System.out.println("업데이트에 실패하였습니다.");
			msg = URLEncoder.encode("업데이트에 실패하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/empLoginForm.jsp?msg="+msg);	
		}
	} else{
	
		int row = EmpDAO.empActiveToOff(empId);
		
		if(row==1){
			System.out.println("업데이트에 성공하였습니다. ON에서 OFF로 변경");
			msg = URLEncoder.encode("업데이트에 성공하였습니다. ON에서 OFF로 변경","UTF-8");
			response.sendRedirect("/shop/emp/empList.jsp?msg="+msg);
			
		}else{
			System.out.println("업데이트에 실패하였습니다.");
			msg = URLEncoder.encode("업데이트에 실패하였습니다","UTF-8");
			response.sendRedirect("/shop/emp/empLoginForm.jsp?msg="+msg);	
		}	
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyEmpActive</title>
</head>
<body>

</body>
</html>