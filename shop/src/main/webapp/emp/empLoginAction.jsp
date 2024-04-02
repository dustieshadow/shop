<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>


<%
	//인증분기 세션 변수 이름 loginEmp
	System.out.println("---------------empLoginAction.jsp");

String loginEmp = (String) (session.getAttribute("loginEmp"));
System.out.println("loginMember : " + loginEmp);

	if(session.getAttribute("loginEmp") != null) {
	response.sendRedirect("/shop/emp/empList.jsp");
	return;
	}
	
	String empId = null;
	String empPw = null;
	
	if(request.getParameter("empId") != null){
		empId = request.getParameter("empId");
	}
	
	if(request.getParameter("empPw")!=null){
		empPw = request.getParameter("empPw");
	}
	
	System.out.println("empId : " + empId);
	System.out.println("empPw : " + empPw);
	
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	String sql1 = "select emp_id empId from emp where active = 'ON' and emp_id = ? and emp_pw = password(?)";
	
				
	
	//select emp_id from emp where active = 'ON' and emp_id = ? and emp_pw = password(?); --값이 있으면 로그인 성공(empList.jsp), 값이 없으면 실패(loginForm.jsp)
								
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");
	stmt1 = conn.prepareStatement(sql1);
	
	stmt1.setString(1,empId);
	stmt1.setString(2,empPw);
	
	rs1 = stmt1.executeQuery();
	
	if(rs1.next()){
		System.out.println("로그인에 성공하였습니다.");
		session.setAttribute("loginEmp",rs1.getString("empId"));
		response.sendRedirect("/shop/emp/empList.jsp");
		
	}else{
		System.out.println("로그인에 실패하였습니다.");
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
	}
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>empLoginAction</title>
</head>
<body>

</body>
</html>