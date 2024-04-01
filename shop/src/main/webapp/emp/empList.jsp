<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
System.out.println("---------------empList.jsp");	

String loginEmp = (String) (session.getAttribute("loginEmp"));
System.out.println("loginEmp : " + loginEmp);

	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
		}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원목록</title>
</head>
<body>

</body>
</html>