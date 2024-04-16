<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	System.out.println("----------checkId.jsp----------");
    
    	String memberId = null;
    	
    	System.out.println(request.getParameter("중복확인 위해 받은 memberId값"+memberId));
    	
    	if(request.getParameter("memberId")!=null){
    		memberId = request.getParameter("memberId");
    	}
    	
    	// 인증분기	 : 세션변수 이름 - loginEmp
    	if(session.getAttribute("loginEmp") == null) {
    		response.sendRedirect("/shop/emp/loginForm.jsp");
    		return;
    	}
    %>
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