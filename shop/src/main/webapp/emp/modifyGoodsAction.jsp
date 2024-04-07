<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>

<%
	System.out.println("----------modifyGoodsAction.jsp----------");
%>
    <% 
    	//쿼리1 실행위한 변수 생성
	String goodsNo = null;
	String category = null;
	String goodsTitle = null;
	String goodsImage = null;
	int goodsPrice = 0;
	int goodsAmount = 0;
	String goodsContent = null;
	
	
	
	
	
	if(request.getParameter("goodsNo")!= null){
		goodsNo = request.getParameter("goodsNo");
	}
	

	if(request.getParameter("category")!= null){
		category = request.getParameter("category");
	}
	

	if(request.getParameter("goodsTitle")!= null){
		goodsTitle = request.getParameter("goodsTitle");
	}
	

	if(request.getParameter("goodsImage")!= null){
		goodsImage = request.getParameter("goodsImage");
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
	
	
	System.out.println("goodsNo : "+goodsNo);
	System.out.println("category : "+category);
	System.out.println("goodsTitle : "+goodsTitle);
	System.out.println("goodsImage : "+goodsImage);
	System.out.println("goodsPrice : "+goodsPrice);
	System.out.println("goodsAmount : "+goodsAmount);
	System.out.println("goodsContent : "+goodsContent);
	
	
	
	//세션 없다면 로그인폼으로 이동
	if(session.getAttribute("loginEmp")==null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	
		 Part part = request.getPart("goodsImg");
	    String originalName = part.getSubmittedFileName();
	    // 원본이름에서 확장자만 분리
	    int dotIdx = originalName.lastIndexOf(".");
	    String ext = originalName.substring(dotIdx); // .png
	    
	    UUID uuid = UUID.randomUUID();
	    String filename = uuid.toString().replace("-", "");
	    filename = filename + ext;
	
	    System.out.println("filename : "+filename);
	

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
		String msg = null;
		
		if(row==1){
			
			
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
			response.sendRedirect("/shop/emp/addGoodsForm.jsp?msg="+msg);
			
			
		}else{
			System.out.println("업데이트에 실패하였습니다.");
			msg = URLEncoder.encode("업데이트에 실패하였습니다.","UTF-8");
			response.sendRedirect("/shop/emp/addGoodsForm.jsp?msg="+msg);	
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