<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.net.*" %>
    <%@ page import="java.util.*" %>
    <%@ page import="shop.dao.*" %>
    
    <%
    System.out.println("----------deleteGoodsAction.jsp----------");
    
    String deleteGoodsNo = null;
    
    System.out.println("[param]deleteGoodsNo : " + request.getParameter("deleteGoodsNo"));

    if(request.getParameter("deleteGoodsNo")!=null){
    	deleteGoodsNo = request.getParameter("deleteGoodsNo");
    	System.out.println("deleteGoodsNo : "+ deleteGoodsNo);
    }
    
   int deleteGoodsList = GoodsDAO.deleteGoodsList(deleteGoodsNo);
   System.out.println("deleteGoodsList(삭제 쿼리 : "+deleteGoodsList);
	String msg = null;
   	if(deleteGoodsList == 1){
	msg = URLEncoder.encode("상품항목 삭제에 성공하였습니다.","UTF-8");
	System.out.println("상품항목 삭제에 성공하였습니다.");
	response.sendRedirect("/shop/emp/addGoodsForm.jsp?msg="+msg+"&modify=delete");
			
}else{
	msg = URLEncoder.encode("상품항목 삭제에 실패하였습니다.","UTF-8");
	System.out.println("상품항목 삭제에 실패하였습니다.");
	response.sendRedirect("/shop/emp/addGoodsForm.jsp?msg="+msg+"&modify=delete");
}
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteGoodsAction</title>
</head>
<body>

</body>
</html>