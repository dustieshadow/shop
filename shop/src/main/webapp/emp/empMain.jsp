<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import= "java.net.*" %>

<%
	System.out.println("---------------empMain.jsp");
	System.out.println("사원 기본 화면페이지입니다.");

	// 인증분기	 : 세션변수 이름 - loginEmp
	if (session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	//세션 변수 loginEmp값 받을 HashMap 변수 m 생성
	HashMap<String,Object> m = new HashMap<>();
	
	//변수할당
	m = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	
	String empName = null;
	//해쉬맵 변수 스트링변수에 할당
	empName = (String)(m.get("empName"));
	
	System.out.println(session.getAttribute("loginEmp"));
	System.out.println("empName : "+empName);

%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<%=empName%>님 반갑습니다.
	

</body>
</html>