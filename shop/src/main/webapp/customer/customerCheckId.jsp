<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "shop.dao.*" %>
    <%@ page import="java.net.*" %>
    
    <%
    	System.out.println("----------customer.customerCheckId.jsp----------");
    
    	String memberId = null;
    	String type = null;
    	
    	System.out.println("[param]중복확인 memberID : "+request.getParameter("memberId"));
    
    	

  
    	
    	  	
    	if(request.getParameter("memberId")!=null){
    		memberId = request.getParameter("memberId");
    	}
    	
    	// 인증분기	 : 세션변수 이름 - loginEmp
    	if(session.getAttribute("loginEmp") != null) {
    		System.out.println("loginEmp세션값이 존재합니다.");
    		response.sendRedirect("/shop/emp/empMain.jsp");
    		return;
    	}
    	
    	boolean checkMail = CustomerDAO.checkMail(memberId);
    	String msg = null;
    	String check = null;
    	
    	if(checkMail){
    		check = "1";
    		System.out.println("중복된 아이디. 고객신규가입 불가");
    		msg = URLEncoder.encode("중복된 아이디입니다. 다른 아이디로 입력하세요.","UTF-8");
    		response.sendRedirect("/shop/emp/addMemberForm.jsp?memberId="+memberId+"&msg="+msg+"&check="+check);
    		
    	}else if(!checkMail){
    		check = "2";
    		System.out.println("중복된 아이디가 없음. 고객신규가입 가능");
    		msg = URLEncoder.encode("가입 가능한 아이디입니다.","UTF-8");
    		response.sendRedirect("/shop/emp/addMemberForm.jsp?memberId="+memberId+"&msg="+msg+"&check="+check);
    	}
    	
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkId</title>
</head>
<body>

</body>
</html>