<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	System.out.println("---------------empLogout.jsp");

	String sessionId = session.getId();
	System.out.println("session.getId() : " + session.getId());
	//세션 종료
	session.invalidate();
	response.sendRedirect("/shop/emp/loginForm.jsp");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>empLogout</title>
</head>
<body>

</body>
</html>