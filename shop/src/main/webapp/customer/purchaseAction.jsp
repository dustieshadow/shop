<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("----------purchaseAction.jsp__________");


if (session.getAttribute("loginEmp") == null) {
	response.sendRedirect("/shop/emp/loginForm.jsp");
	return;
}

	System.out.println("[param]mail : "+request.getParameter("mail"));
	System.out.println("[param]goods_no : "+request.getParameter("goods_no"));
	System.out.println("[param]total_price : "+request.getParameter("total_price"));
	System.out.println("[param]order_quantity : "+request.getParameter("order_quantity"));
	System.out.println("[param]currentPage : "+request.getParameter("currentPage"));
	System.out.println("[param]rowPerPage : "+request.getParameter("rowPerPage"));
	System.out.println("[param]category : "+request.getParameter("category"));
	
	
	String mail = null;
	int goodsNo = 0;
	int totalPrice = 0;
	int orderQuantity = 0;
	int currentPage = 0;
	int rowPerPage = 0;
	String category = null;
	
	//ArrayList<HashMap<String, Object>> selectCustomerList = CustomerDAO.selectCustomerList();
	
	
	if(request.getParameter("mail")!= null){
		mail = request.getParameter("mail");
		System.out.println(mail);
	}

	if(request.getParameter("goods_no")!= null){
		goodsNo = Integer.parseInt(request.getParameter("goods_no"));
		System.out.println(goodsNo);
	}

	if(request.getParameter("total_price")!= null){
		totalPrice = Integer.parseInt(request.getParameter("total_price"));
		System.out.println(totalPrice);
	}

	if(request.getParameter("order_quantity")!= null){
		orderQuantity = Integer.parseInt(request.getParameter("order_quantity"));
		System.out.println(orderQuantity);
	}
	
	if(request.getParameter("currentPage")!= null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		System.out.println(orderQuantity);
	}

	if(request.getParameter("rowPerPage")!= null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.println(rowPerPage);
	}

	if(request.getParameter("category")!= null){
		category = request.getParameter("category");
		System.out.println(category);
	}

	
	

	int insertOrder = OrderDAO.insertOrder(mail,goodsNo,totalPrice,orderQuantity);
	
	String msg = null;
	if(insertOrder ==1 ){
		System.out.println("결제가 정상적으로 이뤄졌습니다.");
		msg = URLEncoder.encode("결제가 정상적으로 이뤄졌습니다.","UTF-8");
		response.sendRedirect("/shop/emp/goodsList.jsp?msg="+msg+"&currentPage="+currentPage+"&rowPerPage="+rowPerPage+"&category="+category);
	}else{
		System.out.println("결제에 실패하여 주문이 취소되었습니다.");
		msg = URLEncoder.encode("결제에 실패하여 주문이 취소되었습니다.","UTF-8");
		response.sendRedirect("/shop/emp/goodsList.jsp?msg="+msg+"&currentPage="+currentPage+"&rowPerPage="+rowPerPage+"&category="+category);
	}
	
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