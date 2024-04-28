<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import ="java.util.*" %>
    <%@ page import ="java.net.*" %>
    <%@ page import ="shop.dao.*" %>
    
    <%
    	System.out.println("----------stateDispatchAction.jsp----------");
    
    System.out.println("[param]ordersNo : "+request.getParameter("ordersNo"));
    System.out.println("[param]currentPage : "+request.getParameter("currentPage"));
   
    String ordersNo = null;
    String currentPage = null;
   
    
    if(request.getParameter("ordersNo")!= null){
    	ordersNo = request.getParameter("ordersNo");
    	System.out.println("ordersNo : "+ordersNo);
    }
    
    if(request.getParameter("currentPage")!= null){
    	currentPage = request.getParameter("currentPage");
    	System.out.println("currentPage : "+currentPage);
    }
    
       
    int updateChangeDispatchOrder = 0;
    
    updateChangeDispatchOrder = OrderDAO.updateChangeDispatchOrder(ordersNo);
    
    System.out.println("updateChangeDispatchOrder :" +updateChangeDispatchOrder);
    
    if(updateChangeDispatchOrder ==1){
    	System.out.println("출하지시로 강제상태변경 완료");
    	
    	response.sendRedirect("/shop/customer/orderList.jsp?currentPage="+currentPage);
    }else{
    	System.out.println("출하지시로 강제상태변경 실패");
    	
    	response.sendRedirect("/shop/customer/orderList.jsp");
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>stateDispatchAction</title>
</head>
<body>

</body>
</html>