<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("---------addMemberAction.jsp----------");

	System.out.println("회원가입 타입 : "+request.getParameter("type"));
	
	String type=null;
	String errMsg = null;
	String memberId = null;
	
	System.out.println("[param]memberId : " + memberId);
	
	
	if(request.getParameter("type")!=null){
		type = request.getParameter("type");
		System.out.println("type : "+ type);
	}
	
	if(session.getAttribute("loginEmp") != null) {
	response.sendRedirect("/shop/emp/empMain.jsp");
	return;
	}
	
	if(session.getAttribute("loginCs") != null) {
		response.sendRedirect("/shop/customer/shopMain.jsp");
		return;
		}
	
	if(type.equals("customer")){
		
		
		String memberPw = null;
		String memberName = null;
		String memberBirthDate = null;
		String memberGender = null;
		String memberPhone = null;
		
		memberId = request.getParameter("memberId");
		memberPw = request.getParameter("memberPw");
		memberName = request.getParameter("memberName");
		memberBirthDate = request.getParameter("memberBirthDate");
		memberGender = request.getParameter("memberGender");
		memberPhone = request.getParameter("memberPhone");
		
		System.out.println("memberId : "+memberId);
		System.out.println("memberPw : "+memberPw);
		System.out.println("memberName : "+memberName);
		System.out.println("memberBirthDate : "+memberBirthDate);
		System.out.println("memberGender : "+memberGender);
		System.out.println("memberPhone : "+memberPhone);
		
		int customerInsert = CustomerDAO.insertMember(memberId, memberPw, memberName, memberBirthDate, memberGender, memberPhone);
		
		if(customerInsert== 1){
			System.out.println("신규 고객 가입에 성공하였습니다");
			errMsg = URLEncoder.encode("신규 가입에 성공하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/loginForm.jsp?errMsg="+errMsg);
			return;
		}else{
			System.out.println("신규 고객 가입에 실패하였습니다.");
			errMsg = URLEncoder.encode("회원가입에 실패하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/loginForm.jsp?errMsg="+errMsg);
			return;
		}
	
		
	}else if(type.equals("employee")){
		

		String empId = null;
		String empPw = null;
		String empName = null;
		String empJob = null;
		String hireDate = null;

		
		empId = request.getParameter("empId");
		empPw = request.getParameter("empPw");
		empName = request.getParameter("empName");
		empJob = request.getParameter("empJob");
		hireDate = request.getParameter("hireDate");
		
		
		System.out.println("empId : "+empId);
		System.out.println("empPw : "+empPw);
		System.out.println("empName : "+empName);
		System.out.println("empJob : "+empJob);
		System.out.println("hireDate : "+hireDate);

		/*
		int empInsert = EmpDAO.insertMember(memberId, memberPw, memberName, memberBirthDate, memberGender, memberPhone);
		
		if(customerInsert== 1){
			System.out.println("신규 고객 가입에 성공하였습니다");
			errMsg = URLEncoder.encode("신규 가입에 성공하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/loginForm.jsp?errMsg="+errMsg);
			return;
		}else{
			System.out.println("신규 고객 가입에 실패하였습니다.");
			errMsg = URLEncoder.encode("회원가입에 실패하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/loginForm.jsp?errMsg="+errMsg);
			return;
		}
		
		*/
	}
	
		
	%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addMemberAction</title>
</head>
<body>

</body>
</html>