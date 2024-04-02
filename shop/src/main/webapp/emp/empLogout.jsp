<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	System.out.println("---------------empLogout.jsp");

	String sessionId = session.getId();
	System.out.println("session.getId() : " + session.getId());
	session.invalidate();
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
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