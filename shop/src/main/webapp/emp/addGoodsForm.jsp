<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
<%
	System.out.println("---------------addGoodsForm.jsp");
	System.out.println("---상품 신규 등록 페이지입니다---");
	
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Model Layer -->
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	//카테고리 테이블에서 카테고리 항목을 조회
	String sql1 = "select category from category";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();

	ArrayList<String> categoryList =
			new ArrayList<String>();
	//조회가 된다면 카테고리 칼럼값을 categoryList 리스트에 추가
	while(rs1.next()) {
		categoryList.add(rs1.getString("category"));
	}
	// 디버깅
	System.out.println("categoryList(ArrayList<String>) : "+ categoryList);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
		<body>
			<!-- 메인메뉴 -->
			<div>
				<!-- include기술 접목(앵커태그로 직접 주소넣는 방식이 아니라 empMenu페이지를 불러오는 방식 -->
				<jsp:include page="/emp/empMenu.jsp"></jsp:include>
			</div>
			
			<h1>상품등록</h1>  <!-- multipart 폼 데이타는 반드시 포스트방식만 가능 -->
			<form method="post" action="/shop/emp/addGoodsAction.jsp" enctype="multipart/form-data">
				<div>
					category :
					<select name="category">
						<option value="">선택</option>
						<%	//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
							for(String c : categoryList) {
						%>
								<option value="<%=c%>"><%=c%></option>
						<%		
							}
						%>
					</select>
				</div>
				<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
				<div>
					goodsTitle :
					<input type="text" name="goodsTitle">
				</div>
				
				<div>
					goodsImage :
					<input type="file" name="goodsImg">
				</div>
				
				<div>
					goodsPrice :
					<input type="number" name="goodsPrice">
				</div>
				<div>
					goodsAmount :
					<input type="number" name="goodsAmount">
				</div>
				<div>
					goodsContent :
					<textarea rows="5" cols="50" name="goodsContent"></textarea>
				</div>
				<div>
					<button type="submit">상품등록</button>
				</div>
			</form>
		</body>
</html>
