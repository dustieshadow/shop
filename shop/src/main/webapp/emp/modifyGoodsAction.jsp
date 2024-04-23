<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("----------modifyGoodsAction.jsp----------");
System.out.println("세션 ID: " + session.getId());
%>
    <% 
    
  //세션 없다면 로그인폼으로 이동
String msg = null;
if (session.getAttribute("loginEmp") == null && session.getAttribute("loginCs") == null) {
	System.out.println("비정상적 접근입니다.");
	msg = URLEncoder.encode("비정상적 접근입니다.","UTF-8");
	response.sendRedirect("/shop/emp/loginForm.jsp?msg="+msg);
		return;
} else if (session.getAttribute("loginEmp") == null && session.getAttribute("loginCs") != null){
	System.out.println("사원만 접근 가능한 페이지입니다.");
	msg = URLEncoder.encode("사원만 접근 가능한 페이지입니다.","UTF-8");
		response.sendRedirect("/shop/emp/goodsList.jsp?msg="+msg);
	return;
}

    	//쿼리1 실행위한 변수 생성
	int goodsNo = 0;
	String category = null;
	String goodsTitle = null;
	String goodsImg = "default";
	int goodsPrice = 0;
	int goodsAmount = 0;
	String goodsContent = null;
	
	
	System.out.println("[param]goodsNo : "+ request.getParameter("goodsNo"));
	System.out.println("[param]category : "+request.getParameter("category"));
	System.out.println("[param]goodsTitle : "+request.getParameter("goodsTitle"));
	System.out.println("[param]goodsImg : "+request.getPart("goodsImg"));
	System.out.println("[param]goodsPrice : "+request.getParameter("goodsPrice"));
	System.out.println("[param]goodsAmount : "+request.getParameter("goodsAmount"));
	System.out.println("[param]goodsContent : "+request.getParameter("goodsContent"));
	
	
	if(request.getParameter("goodsNo")!= null){
		goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	}
	

	if(request.getParameter("category")!= null){
		category = request.getParameter("category");
	}
	

	if(request.getParameter("goodsTitle")!= null){
		goodsTitle = request.getParameter("goodsTitle");
	}

	
	if(request.getParameter("goodsPrice")!= null){
		goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	}
	

	if(request.getParameter("goodsAmount")!= null){
		goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	}
	

	if(request.getParameter("goodsContent")!= null){
		goodsContent = request.getParameter("goodsContent");
	}
	
	String filename = null;
	Part part = null;
	
	part = request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	
	String exe = null;
	int dotIdx = originalName.lastIndexOf(".");
	
	if(dotIdx != -1){
		exe = originalName.substring(dotIdx);
	}
	
	
	System.out.println("goodsNo : "+goodsNo);
	System.out.println("category : "+category);
	System.out.println("goodsTitle : "+goodsTitle);
	System.out.println("goodsPrice : "+goodsPrice);
	System.out.println("goodsAmount : "+goodsAmount);
	System.out.println("goodsContent : "+goodsContent);
	
	    UUID uuid = UUID.randomUUID();
	    filename = uuid.toString().replace("-", "");
	    filename = filename + exe;
	
	    System.out.println("filename : "+filename);
	
	    int row = 0;
	    if(dotIdx == -1){
	    	filename = "default.png";
	    	System.out.println(filename);
	    }
/*
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	
		String sql1 = "update goods set goods_no=?,category=?,goods_title=?,filename=?,goods_price=?,goods_amount=?,goods_content=? where goods_no = ? ";
		
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1,goodsNo);
		stmt1.setString(2,category);
		stmt1.setString(3,goodsTitle);
		stmt1.setString(4,filename);
		stmt1.setInt(5,goodsPrice);
		stmt1.setInt(6,goodsAmount);
		stmt1.setString(7,goodsContent);
		stmt1.setString(8,goodsNo);
		
		System.out.println(stmt1);
		
		
		int row = stmt1.executeUpdate();	
		*/
		
		int modifyGoods = GoodsDAO.modifyGoods(goodsNo, category, goodsTitle, filename, goodsPrice, goodsAmount, goodsContent );
		
		System.out.println("goodsNo : "+goodsNo);
		System.out.println("category : "+category);
		System.out.println("goodsTitle : "+goodsTitle);
		System.out.println("goodsImg : "+goodsImg);
		System.out.println("goodsPrice : "+goodsPrice);
		System.out.println("goodsAmount : "+goodsAmount);
		System.out.println("goodsContent : "+goodsContent);
		
		
		
		
		
		if(modifyGoods==1){
			
			
			// part -> 1)is -> 2)os -> 3)빈파일
			// 1)
	    	InputStream is = part.getInputStream();
	    	// 3)+ 2)
			String filePath = request.getServletContext().getRealPath("upload");
			File f = new File(filePath, filename); // 빈파일
			OutputStream os = Files.newOutputStream(f.toPath()); // os + file
			is.transferTo(os);
			
			os.close();
			is.close();
			
			
			System.out.println("업데이트에 성공하였습니다. 상품정보가 변경되었습니다.");
			msg = URLEncoder.encode("업데이트에 성공하였습니다. 상품정보가 변경되었습니다.","UTF-8");
			response.sendRedirect("/shop/emp/addGoodsForm.jsp?msg="+msg+"&modify=modify");
			
			
		}else{
			System.out.println("업데이트에 실패하였습니다.");
			msg = URLEncoder.encode("업데이트에 실패하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/addGoodsForm.jsp?msg="+msg+"&modify=modify");
			return;
		}
	
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyGoodsAction</title>
</head>
<body>

</body>
</html>