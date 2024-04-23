<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import ="shop.dao.*" %>


<%
	//인증분기 세션 변수 이름 loginEmp
	System.out.println("---------------LoginAction2.jsp");

	System.out.println("로그인 타입(사원or고객) : "+request.getParameter("type"));
	System.out.println("loginForm에서 받은 id값 : "+request.getParameter("id"));
	System.out.println("loginForm에서 받은 pw값 : "+request.getParameter("pw"));
	String type = null;
	
	
	if(request.getParameter("type")!= null){
		type = request.getParameter("type");
		System.out.println("type : "+type);
		
		
	}
	
	if(type.equals("employee")){
		if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empMain.jsp");
		return;
		}
	}
	
	String id = null;
	String pw = null;

	String errMsg = null;
	String msg = null;
	
	
	if(request.getParameter("id") != null){
		id = request.getParameter("id");
	}
	
	if(request.getParameter("pw")!=null){
		pw = request.getParameter("pw");
	}
	
	
	
	System.out.println("id : " + id);
	System.out.println("pw : " + pw);
	
	
	if(type.equals("employee")){
		
		HashMap<String, Object> memberLogin = EmpDAO.empLogin(id, pw); 
	
		if(memberLogin!=null){
			System.out.println("사원 로그인에 성공하였습니다.");
			//하나의 세션변수 안에 여러개의 값을 저장하기 위해 HashMap타입을 사용
			
			session.setAttribute("loginEmp",memberLogin);
			
			HashMap<String, Object> m = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
			
			
			System.out.println((String)(m.get("empId"))); //로그인 된 empId
			System.out.println((String)(m.get("empName"))); //로그인 된 empId
			System.out.println((Integer)(m.get("grade"))); //로그인 된 empId
			System.out.println((String)(m.get("empJob"))); //로그인 된 empId
			//msg = URLEncoder.encode((String)(m.get("empName"))+"님 반갑습니다.","UTF-8");
				
			
			response.sendRedirect("/shop/emp/empMain.jsp?type=employee");
	
		}else{
			System.out.println("사원 로그인에 실패하였습니다.");
			errMsg = URLEncoder.encode("로그인에 실패하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/loginForm.jsp?errMsg="+errMsg);
		}
	}else if(type.equals("customer")){
		HashMap<String, Object> memberLogin = CustomerDAO.customerLogin(id,pw); 
		
		if(memberLogin!=null){
			System.out.println("고객 로그인에 성공하였습니다.");
			//하나의 세션변수 안에 여러개의 값을 저장하기 위해 HashMap타입을 사용
			
			session.setAttribute("loginCs",memberLogin);
			
			HashMap<String, Object> m = (HashMap<String,Object>)(session.getAttribute("loginCs"));
			
			
			System.out.println("[세션에서 할당한 HashMap - csMail]"+(String)(m.get("csMail"))); 
			System.out.println("[세션에서 할당한 HashMap - csName]"+(String)(m.get("csName")));
			System.out.println("[세션에서 할당한 HashMap - csGender]"+(String)(m.get("csGender"))); 
			System.out.println("[세션에서 할당한 HashMap - csBirthDate]"+(String)(m.get("csBirthDate"))); 
			System.out.println("[세션에서 할당한 HashMap - csPhone]"+(String)(m.get("csPhone")));
			//msg = URLEncoder.encode((String)(m.get("empName"))+"님 반갑습니다.","UTF-8");
				
			
			response.sendRedirect("/shop/emp/goodsList.jsp?type=customer");
		}else{
			System.out.println("고객 로그인에 실패하였습니다.");
			errMsg = URLEncoder.encode("로그인에 실패하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/loginForm.jsp?errMsg="+errMsg);
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginAction</title>
</head>
<body>

</body>
</html>