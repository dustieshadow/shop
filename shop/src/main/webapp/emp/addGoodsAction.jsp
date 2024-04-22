<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.nio.file.*"%>
<%@ page import ="shop.dao.*" %>


<!-- Controller Layer -->
<%
System.out.println("---------------addGoodsAction.jsp---------------");

request.setCharacterEncoding("UTF-8");
// 인증분기  : 세션변수 이름 - loginEmp
if (session.getAttribute("loginEmp") == null) {
	response.sendRedirect("/shop/emp/loginForm.jsp");
	return;
}
%>
<!-- Model Layer -->
<%
HashMap<String, Object> m = new HashMap<>();

//변수할당
m = (HashMap<String, Object>) (session.getAttribute("loginEmp"));

String empId = null;

//해쉬맵 변수 스트링변수에 할당
empId = (String) (m.get("empId"));

System.out.println("[param]category : "+request.getParameter("category"));
System.out.println("[param]goodsTitle : "+request.getParameter("goodsTitle"));
System.out.println("[param]goodsPrice : "+request.getParameter("goodsPrice"));
System.out.println("[param]goodsAmount : "+request.getParameter("goodsAmount"));
System.out.println("[param]goodsContent : "+request.getParameter("goodsContent"));
System.out.println("[param]goodsImg : "+request.getPart("goodsImg"));
System.out.println("[param]goodsNo : "+request.getParameter("goodsNo"));


String category = request.getParameter("category");
String goodsTitle = request.getParameter("goodsTitle");
int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
String goodsContent = request.getParameter("goodsContent");

String filename = null;
Part part = null;

//이미지 파일 받는 코드
part = request.getPart("goodsImg");
String originalName = part.getSubmittedFileName();
// 원본이름에서 확장자만 분리
String exe = null;
int dotIdx = originalName.lastIndexOf(".");

if(dotIdx != -1){
	exe = originalName.substring(dotIdx);
}


UUID uuid = UUID.randomUUID();
filename = uuid.toString().replace("-", "");
filename = filename + exe;
System.out.println(filename);

int row = 0;
if(dotIdx == -1){
	filename = "default.png";
	System.out.println(filename);
}


int addGoods = GoodsDAO.addGoods(category, empId, goodsTitle, filename, goodsContent, goodsPrice, goodsAmount);

System.out.println("category : " + category);
System.out.println("empId : " + empId);
System.out.println("goodsTitle : " + goodsTitle);
System.out.println("filename : " + filename);
System.out.println("goodsPrice : " + goodsPrice);
System.out.println("goodsAmount : " + goodsAmount);
System.out.println("goodsContent : " + goodsContent);

/*
Class.forName("org.mariadb.jdbc.Driver");
String sql = "insert into goods(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date) values(?,?,?,?,?,?,?, now(), now())";
Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
PreparedStatement stmt = conn.prepareStatement(sql);
stmt.setString(1, category);
stmt.setString(2, empId);
stmt.setString(3, goodsTitle);
stmt.setString(4, filename);
stmt.setString(5, goodsContent);
stmt.setInt(6, goodsPrice);
stmt.setInt(7, goodsAmount);

System.out.println("stmt확인 : " + stmt);
*/


//int row = stmt.executeUpdate();


if (addGoods == 1) { // insert 성공하면 파일업로드
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
}

/*
파일 삭제 API
File df = new File(filePath, rs.getString("filename"));
df.delete()
*/

if (addGoods == 1) {
	System.out.println("상품등록에 성공하였습니다.");
	String msg = URLEncoder.encode("상품등록에 성공하였습니다.", "UTF-8");
	response.sendRedirect("/shop/emp/addGoodsForm.jsp?msg=" + msg+"&modify=insert");
	

} else {
	System.out.println("상품등록에 실패하였습니다.");
	String msg = URLEncoder.encode("작성에 실패했습니다. 확인 후 다시 입력하세요.", "UTF-8");
	response.sendRedirect("/shop/emp/addGoodsForm.jsp?msg=" + msg+"&modify=insert");
	return;
}
%>
