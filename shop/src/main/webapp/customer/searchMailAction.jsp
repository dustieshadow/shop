<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import ="java.util.*" %>
    <%@ page import ="java.net.*" %>
    <%@ page import ="shop.dao.*" %>
    
    <%
    	System.out.println("----------searchMailAction.jsp----------");
    
    System.out.println("[param]searchMail : "+request.getParameter("searchMail"));
    
   
    
    
    String searchMail = null;

   
    
    if(request.getParameter("searchMail")!= null){
    	searchMail = request.getParameter("mail");
    	System.out.println("searchMail : "+searchMail);
    }
    
   
    ArrayList<HashMap<String, Object>> selectSearchMail = OrderDAO.selectSearchMail(searchMail);
    
    
   
    System.out.println("selectSearchMail :" +selectSearchMail);
    
    if(selectSearchMail != null){
    	System.out.println("메일 주문리스트 조회 성공");
    	
    	response.sendRedirect("/shop/customer/orderList.jsp?");
    }else{
    	System.out.println("메일 주문리스트 조회 실패");
    	
    	response.sendRedirect("/shop/customer/orderList.jsp");
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>searchIdAction</title>
</head>
<body>

</body>
</html>