<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "shop.dao.*" %>
<%@ page import="java.net.*" %>

<%
System.out.println("---------------addGoodsForm.jsp");
System.out.println("---상품 신규 등록 페이지입니다---");

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


System.out.println("세션 ID: " + session.getId());

System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
System.out.println("[param]currentPage : " + request.getParameter("currentPage"));
System.out.println("[param]modify : " + request.getParameter("modify"));
System.out.println("[param]goodsNo : " + request.getParameter("goodsNo"));
System.out.println("[param]msg : " + request.getParameter("msg"));
System.out.println("[param]deleteGoodsNo : " + request.getParameter("deleteGoodsNo"));

String modify = null;
String goodsNo = null;
String deleteGoodsNo = null;

if(request.getParameter("modify")!=null){
	modify = request.getParameter("modify");
	System.out.println("modify : "+modify);
}


if(request.getParameter("goodsNo")!=null){
	goodsNo = request.getParameter("goodsNo");
	System.out.println("goodsNo : "+ goodsNo);
}

if(request.getParameter("deleteGoodsNo")!=null){
	deleteGoodsNo = request.getParameter("deleteGoodsNo");
	System.out.println("deleteGoodsNo : "+ deleteGoodsNo);
}


if(request.getParameter("msg")!=null){
	msg = request.getParameter("msg");
	System.out.println("msg : "+ msg);
}





//controller layer
//String s = "SELECT * FROM category";

//페이징 관련 변수



String category = request.getParameter("category");
System.out.println("category : " + category);

//전체행수 검색 변수설정 -------------------------
int totalRow = 0;			//조회쿼리 전체행수
int rowPerPage = 10; 		//페이지당 행수
int totalPage = 1;			//전체 페이지수

int currentPage = 1;		//현재 페이지수
int limitStartPage = 0;		//limit쿼리 시작행

int startRow = (currentPage-1)*rowPerPage;


System.out.println("totalRow : " + totalRow);
System.out.println("rowPerPage : " + rowPerPage);
System.out.println("totalRow % rowPerPage : " + totalRow % rowPerPage);
System.out.println("totalPage : " + totalPage);
//현재 페이지 값이 넘어왔을 때 커런트 페이지 값을 넘겨받는다
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	System.out.println("currentPage : " + currentPage);
}
//로우퍼 페이지 값이 넘어왔을때 로우퍼 페이지 값을 넘겨받는다
if (request.getParameter("rowPerPage") != null) {
	rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	System.out.println("rowPerPage : " + rowPerPage);
}
//limit쿼리 시작행수는 현재 페이지에 1을 뺀 수에서 로우퍼페이지를 곱을 한 값이다
limitStartPage = (currentPage - 1) * rowPerPage;
System.out.println("limitStartPage : " + limitStartPage);

/*
	null이면
	select * from goods
	null이 아니면
	select * from goods where category=?
	
	오늘 날짜와 재고입고 날짜 비교하여 이틀 이내 상품이면 신규재고 이미지 추가
	
*/

//model layer
/*
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null;
PreparedStatement stmt1 = null;
ResultSet rs1 = null;
//쿼리1 - 테이블에 뿌릴 데이터 조회
String sql1 = "select category, goods_no, emp_id, goods_title, goods_price, goods_amount, goods_content, update_date, create_date from goods limit ?,?";
conn = DriverManager.getConnection("");
stmt1 = conn.prepareStatement(sql1);
stmt1.setInt(1,limitStartPage);
stmt1.setInt(2,rowPerPage);
rs1 = stmt1.executeQuery();
*/
//ArrayList<HashMap<String, Object>> selectGoodsList = GoodsDAO.selectGoodsList(limitStartPage, rowPerPage);
ArrayList<HashMap<String, Object>> selectGoodsOrderByList = GoodsDAO.selectGoodsOrderByList(limitStartPage, rowPerPage);
/*
while (rs1.next()) {
	HashMap<String, Object> m = new HashMap<String, Object>();
	m.put("category", rs1.getString("category"));
	m.put("goods_no", rs1.getInt("goods_no"));
	m.put("emp_id", rs1.getString("emp_id"));
	m.put("goods_title", rs1.getString("goods_title"));
	m.put("goods_price", rs1.getInt("goods_Price"));
	m.put("goods_amount", rs1.getInt("goods_amount"));
	m.put("update_date", rs1.getString("update_date"));
	m.put("create_date", rs1.getString("create_date"));
	m.put("goods_content", rs1.getString("goods_content"));
	
	goodsList.add(m);

}
*/

//쿼리2 - 전체 행수 조회용 쿼리
/*
String sql2 = "select category, count(*) cnt from goods group by category";

PreparedStatement stmt2 = null;
ResultSet rs2 = null;

stmt2 = conn.prepareStatement(sql2);
rs2 = stmt2.executeQuery();


ArrayList<HashMap<String, Object>> categoryCount = new ArrayList<HashMap<String, Object>>();

while (rs2.next()) {
	
	System.out.println("DB값 category : "+rs2.getString("category"));
	System.out.println("DB값 cnt: "+rs2.getInt("cnt"));
	
	
	HashMap<String, Object> m2 = new HashMap<String, Object>();
	m2.put("category", rs2.getString("category"));
	m2.put("cnt", rs2.getInt("cnt"));

	categoryCount.add(m2);
}

rs2.beforeFirst();
*/
ArrayList<HashMap<String, Object>> selectCountGroupByCategory = GoodsDAO.selectGroupByCategory();
ArrayList<HashMap<String, Object>> selectGoodsNoList = GoodsDAO.selectGoodsNoList(goodsNo);
ArrayList<HashMap<String, Object>> deleteGoodsNoList = GoodsDAO.deleteGoodsNoList(deleteGoodsNo);

//디버깅 ArrayList는 문자열 디버깅 가능-주소가 아닌 값이 나오기 때문에
//System.out.println("selectGoodsList(리스트에 추가된 칼럼명 목록) : "+selectGoodsList);
System.out.println("selectGoodsOrderByList(리스트에 추가된 칼럼명 목록) : "+selectGoodsOrderByList);
System.out.println("selectCountGroupByCategory(리스트에 추가된 카테고리 그룹별 행수 : "+selectCountGroupByCategory);
System.out.println("selectGoodsNoList(검색에 필요한 굿즈리스트 : "+selectGoodsNoList);
System.out.println("deleteGoodsNoList(삭제 검색에 필요한 굿즈리스트 : "+deleteGoodsNoList);


//쿼리3 - 전체 행수 조회용 쿼리
/*
String sql3 = "select count(*) cnt from goods";

PreparedStatement stmt3 = null;
ResultSet rs3 = null;

stmt3 = conn.prepareStatement(sql3);
rs3 = stmt3.executeQuery();


if(rs3.next()){
	System.out.println("쿼리3이 정상실행되었습니다.");
}
	
	
rs3.beforeFirst();

if(rs3.next()){
	totalRow = rs3.getInt("cnt");
}

*/

int selectCountGoods = GoodsDAO.selectCountGoods();

	//if(selectCountGoods==1){
		totalRow = selectCountGoods;
//	}
//페이징 목록 코드


//전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
if (totalRow % rowPerPage != 0) {
	totalPage = totalRow / rowPerPage + 1;
//전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
} else {
	totalPage = totalRow / rowPerPage;
}

//세션 변수 loginEmp값 받을 HashMap 변수 m 생성
HashMap<String,Object> m = new HashMap<>();

//변수할당
m = (HashMap<String,Object>)(session.getAttribute("loginEmp"));

String empName = null;
String empJob = null;
int grade = 0;
String admin = null;
//해쉬맵 변수 스트링변수에 할당
empName = (String)(m.get("empName"));
empJob = (String)(m.get("empJob"));
grade = (int)(m.get("grade"));

if(grade==1){
	admin = "Administrator";
}

System.out.println(session.getAttribute("loginEmp"));
System.out.println("empName : "+empName);
System.out.println("empJob : "+empJob);
System.out.println("grade : "+grade);

System.out.println("totalRow : " + totalRow);
System.out.println("rowPerPage : " + rowPerPage);
System.out.println("totalPage : " + totalPage);

%>



<!-- --------------------------- -->

<!-- Controller Layer -->

<% /*
	Class.forName("org.mariadb.jdbc.Driver");
	
	PreparedStatement stmt4 = null;
	ResultSet rs4 = null;
	
	//카테고리 테이블에서 카테고리 항목을 조회
	String sql4 = "select category from category";
	stmt4 = conn.prepareStatement(sql4);
	rs4 = stmt4.executeQuery();

	ArrayList<String> categoryList =
			new ArrayList<String>();
	//조회가 된다면 카테고리 칼럼값을 categoryList 리스트에 추가
	while(rs4.next()) {
		categoryList.add(rs4.getString("category"));
	}
	*/
	
	ArrayList<String> categoryList = GoodsDAO.categoryList();
	// 디버깅
	System.out.println("categoryList(ArrayList<String>) : "+ categoryList);
	

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Gowun+Batang:wght@400;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<title>empMain</title>
	<style>
	.banner{
		width: 100%;
		background-color: #b5c9e8;
		height : 123px;
		border-top: 1px solid rgba(61, 81, 112, 0.1);
        border-bottom: 1px solid rgba(61, 81, 112, 0.1);
        color: #262b33;
        font-weight: bold;
        padding-top: 25px;
        padding-left: 23px;
        padding-bottom: 0px;
		
	}
	* {
  font-family: "Gowun Batang", serif;
  font-weight: 1000;
  font-style: normal;
}


  .nav-link, .nav-link:hover {
        color: #4a5461;
        text-decoration: none; 
        width: 130px;
        text-align: center;
        display: flex;
   		align-items: center;
   		justify-content: flex-start;
   		font-size: 15px;
    }
    
    .material-symbols-outlined {
    vertical-align: middle;
    vertical-align: -5px;
}

	.homepluss {  
	  float: right;
	}


	.homepluss a,
	.homepluss a:visited,
	.homepluss a:hover,
	.homepluss a:active {
    font-family: "Black Han Sans", sans-serif;
    font-weight: 400;
    font-style: normal;
    font-size: 38px;
    color: #262b33; 
    text-decoration: none;
}
    .nav-link:hover {
    background-color: #ebf3ff;
    height: 40px;
   
}




	</style>
	<title>addGoodsForm</title>
</head>
		<body>
			
			<div class="container-fluid banner">
		        <div style="margin-bottom: 13px;">
		            <div>
		                <span class="material-symbols-outlined" style="margin-right: 3px;">face</span>
		                <span style="margin-right: 5px; color: #000000;"><%=empName%> / <%=empJob %></span>
		                <span style="margin-right: 30px;"> 
		                    <% if(admin!=null){ %>
		                        &lt;<%=admin %>&gt;
		                    <% } %>
		                </span>
		                <span style="margin-right: 1px; font-style: italic; font-size: 25px; color: #204675;">
		                    <%=empName%>님 반갑습니다. 오늘도 좋은 하루 되십시오. &#x1F338;
		                </span>
		                <span>
		                    <a href="/shop/emp/empLogout.jsp" class="btn" style="font-weight: bold;">로그아웃
		                        <span class="material-symbols-outlined">logout</span>
		                    </a> 
		                </span>
		            </div>
		            <div class="homepluss">
		                <a href="">HomePluss Inc.</a>
		            </div>
		        </div>
		        <div>
		            <ul class="nav nav-tabs" role="tablist" style="border-color: transparent;">
		                <li class="nav-item">
		                    <a class="nav-link" href="/shop/emp/empMain.jsp">
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">monitoring</span>
		                        <span>Chart</span>
		                    </a>
		                </li>
		
		                <li class="nav-item">
		                    <a class="nav-link" href="/shop/emp/goodsList.jsp">
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">inventory</span>
		                        <span>Catalog</span>
		                    </a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link active" href="/shop/emp/addGoodsForm.jsp"> 
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">qr_code_scanner</span>
		                        <span>Stock</span>
		                    </a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link" href="/shop/customer/orderList.jsp"> 
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">quick_reorder</span>
		                        <span>Order</span>
		                    </a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link" href=""> 
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">support_agent</span>
		                        <span>Customer</span>
		                    </a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link" href="">
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">account_circle</span>
		                        <span>Schedule</span>
		                    </a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link" href="/shop/emp/empList.jsp">
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">badge</span>
		                        <span>Employee</span>
		                    </a>
		                </li>
		            </ul>
		        </div>
		    </div>
		    
		    <div class="row">
		    <div class="col-4" style="background-color: #EBF7FF; height: 1000px; width: 450px" >
			
				<a href="/shop/emp/addGoodsForm.jsp?modify=modify" class="btn" style="margin-top: 20px; margin-bottom: 20px; color: #5D5D5D;" >
					<span class="material-symbols-outlined">edit_square</span>
					<span>수정</span></a>
				<a href="/shop/emp/addGoodsForm.jsp?modify=insert" class="btn" style="margin-top: 20px; margin-bottom: 20px; color: #5D5D5D;">
					<span class="material-symbols-outlined">note_stack_add</span>
					<span>추가</span></a>
				<a href="/shop/emp/addGoodsForm.jsp?modify=delete" class="btn" style="margin-top: 20px; margin-bottom: 20px; color: #5D5D5D;">
					<span class="material-symbols-outlined">delete</span>
					<span>삭제</span></a>
				
			
		
		
		
			
			  <!-- multipart 폼 데이타는 반드시 포스트방식만 가능 -->
			
			
			
				
	<%
				if((modify == null || modify.equals("modify")) && (goodsNo == null && deleteGoodsNo ==null)){
					
					
					
				
				
			
	%>
				<form method="post" action="/shop/emp/addGoodsForm.jsp">
				<h2 style="margin-left: 10px; margin-bottom: 30px;"><span class="material-symbols-outlined" style="margin-right: 10px;">edit_square</span>상품정보 변경</h2>
				
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품코드</span>
  					<input type="number" class="form-control" name="goodsNo" required>
  					
  					<button type="submit" value="" style="margin-left: 0px;"><span class="material-symbols-outlined">check</span></button>
				</div>
				
				
				</form>
				<form method="post" action="/shop/emp/modifyGoodsAction.jsp" enctype="multipart/form-data" >
					<div style="color: #5D5D5D;  margin-bottom: 10px;">
						<button type="button" class="btn btn-light border">카테고리</button>
						<select name="category" required>
							<option value="">선택</option>
	<%						//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
							for(String c : categoryList) {
	%>
								<option value="<%=c%>"><%=c%></option>
	<%		
							}
	%>
					</select>

				</div>

				<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
	
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품명</span>
  					<input type="text" class="form-control" name="goodsTitle" required>

				</div>

				<div style="color: #5D5D5D; margin-bottom: 10px;">
					<button type="button" class="btn btn-light border">이미지</button>
					<input type="file" name="goodsImg">
				</div>
				
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품가</span>
  					<input type="number" class="form-control" name="goodsPrice" required>

				</div>
				
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">보유재고</span>
  					<input type="number" class="form-control" name="goodsAmount" required>

				</div>
				
				
				
				<div style="color: #5D5D5D;">
					<span class="input-group-text" style="width: 90px;">제품상세</span>
					<textarea rows="5" cols="50" name="goodsContent"></textarea>
				</div>
				<div>
					<button type="submit">상품 수정</button>
				</div>
			
			
	<%
					}	else if(goodsNo != null && deleteGoodsNo == null){
					
				
			
	%>
					<form method="post" action="/shop/emp/addGoodsForm.jsp">
					<h2 style="margin-left: 10px; margin-bottom: 30px;"><span class="material-symbols-outlined" style="margin-right: 10px;">edit_square</span>상품정보 변경</h2>
				
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품코드</span>
  					<input type="number" class="form-control" name="goodsNo" value="<%=goodsNo %>" required>
  					
  					<button type="submit" value="" style="margin-left: 0px;"><span class="material-symbols-outlined">check</span></button>
				</div>
				</form>
				<form method="post" action="/shop/emp/modifyGoodsAction.jsp" enctype="multipart/form-data" >
			
				<%	
				for(HashMap<String, Object> a : selectGoodsNoList) {
					int targetGoodsNo = (Integer)(a.get("goods_no"));
					if(targetGoodsNo == Integer.parseInt(goodsNo)){
						
					
				%>	
				
				<div style="color: #5D5D5D;  margin-bottom: 10px;">
						<button type="button" class="btn btn-light border">카테고리</button>
						<select name="category" required>
							<option value="<%=(String)(a.get("category"))%>"><%=(String)(a.get("category"))%></option>
	<%						//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
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
				
					<input type="hidden" name="goodsNo" value="<%=(Integer)(a.get("goods_no")) %>">
				</div>
				
	
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품명</span>
  					<input type="text" class="form-control" name="goodsTitle" value="<%=(String)(a.get("goods_title")) %>" required>

				</div>
				
		
				<div style="color: #5D5D5D; margin-bottom: 10px;">
					<button type="button" class="btn btn-light border" value="<%=(String)(a.get("filename")) %>">이미지</button>
					<input type="file" name="goodsImg">
				</div>
	
					<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품가</span>
  					<input type="number" class="form-control" name="goodsPrice" value="<%=(Integer)(a.get("goods_price")) %>" required>

				</div>
				
	
					<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">보유재고</span>
  					<input type="number" class="form-control" name="goodsAmount" value="<%=(Integer)(a.get("goods_amount")) %>" required>

				</div>

				
					<div style="color: #5D5D5D;">
					<span class="input-group-text" style="width: 90px;">제품상세</span>
					<textarea rows="5" cols="50" name="goodsContent"><%=(String)(a.get("goods_content")) %></textarea>
				</div>
				
				
				
				<div>
					<button type="submit">상품 수정</button>
				</div>
			

		
			<%}}
				
					}else if(modify.equals("delete") && deleteGoodsNo == null) {
		

		%>
					<form method="post" action="/shop/emp/addGoodsForm.jsp">
					<h2 style="margin-left: 10px; margin-bottom: 30px;"><span class="material-symbols-outlined" style="margin-right: 10px;">delete</span>상품 삭제</h2>
					
					<div class="input-group" style="margin-bottom: 10px;">
	  					<span class="input-group-text">상품코드</span>
	  					<input type="number" class="form-control" name="deleteGoodsNo" value ="<%=deleteGoodsNo%>">
	  					
	  					<button type="submit" style="margin-left: 0px;"><span class="material-symbols-outlined">check</span></button>
					</div>
						<input type="hidden" class="form-control" name="modify" value ="delete">
					</form>
					
					<form method="post" action="/shop/emp/deleteGoodsAction.jsp" enctype="multipart/form-data" >
						<div style="color: #5D5D5D;  margin-bottom: 10px;">
							<button type="button" class="btn btn-light border">카테고리</button>
							<select name="category" disabled>
								<option value="">선택</option>
		<%						//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
								for(String c : categoryList) {
		%>
									<option value="<%=c%>"><%=c%></option>
		<%		
								}
		%>
						</select>

					</div>

					<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
		
					<div class="input-group" style="margin-bottom: 10px;">
	  					<span class="input-group-text">상품명</span>
	  					<input type="text" class="form-control" name="goodsTitle" disabled>

					</div>

					<div style="color: #5D5D5D; margin-bottom: 10px;">
						<button type="button" class="btn btn-light border">이미지</button>
						<input type="file" name="goodsImg" disabled>
					</div>
					
					<div class="input-group" style="margin-bottom: 10px;">
	  					<span class="input-group-text">상품가</span>
	  					<input type="number" class="form-control" name="goodsPrice" disabled>

					</div>
					
					<div class="input-group" style="margin-bottom: 10px;">
	  					<span class="input-group-text">보유재고</span>
	  					<input type="number" class="form-control" name="goodsAmount" disabled>

					</div>
					
					
					
					<div style="color: #5D5D5D;">
						<span class="input-group-text" style="width: 90px;">제품상세</span>
						<textarea rows="5" cols="50" name="goodsContent" disabled></textarea>
					</div>
					<div>
						<button type="submit">상품 삭제</button>
					</div>
	
	<!-- ----------------------------- -->
	
	<%}  else if(deleteGoodsNo != null && goodsNo== null  ){
		
		
		
%>
		<form method="post" action="/shop/emp/addGoodsForm.jsp">
		<h2 style="margin-left: 10px; margin-bottom: 30px;"><span class="material-symbols-outlined" style="margin-right: 10px;">delete</span>상품 삭제</h2>
	
	<div class="input-group" style="margin-bottom: 10px;;>
			<span class="input-group-text">상품코드</span>
			<input type="number" class="form-control" name="deleteGoodsNo" value="<%=deleteGoodsNo %>">
			<input type="hidden" class="form-control" name="modify" value ="delete">
			<button type="submit" value="" style="margin-left: 0px;"><span class="material-symbols-outlined">check</span></button>
	</div>
	</form>
	<form method="post" action="/shop/emp/deleteGoodsAction.jsp">

	<%	
	for(HashMap<String, Object> a : deleteGoodsNoList) {
		int targetGoodsNo = (Integer)(a.get("goods_no"));
		if(targetGoodsNo == Integer.parseInt(deleteGoodsNo)){
			
		
	%>	
	
	<div style="color: #5D5D5D;  margin-bottom: 10px;">
			<button type="button" class="btn btn-light border">카테고리</button>
			<select name="category" disabled >
				<option value="<%=(String)(a.get("category"))%>"><%=(String)(a.get("category"))%></option>
<%						//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
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
	
		<input type="hidden" name="deleteGoodsNo" value="<%=(Integer)(a.get("goods_no")) %>">
		
	</div>
	

	<div class="input-group" style="margin-bottom: 10px;">
			<span class="input-group-text">상품명</span>
			<input type="text" class="form-control" name="goodsTitle" disabled value="<%=(String)(a.get("goods_title")) %>">

	</div>
	

	<div style="color: #5D5D5D; margin-bottom: 10px;">
		<button type="button" class="btn btn-light border" disabled value="<%=(String)(a.get("filename")) %>">이미지</button>
		<input type="file" name="goodsImg">
	</div>

		<div class="input-group" style="margin-bottom: 10px;">
			<span class="input-group-text">상품가</span>
			<input type="number" class="form-control" name="goodsPrice" disabled value="<%=(Integer)(a.get("goods_price")) %>">

	</div>
	

		<div class="input-group" style="margin-bottom: 10px;">
			<span class="input-group-text">보유재고</span>
			<input type="number" class="form-control" name="goodsAmount" disabled value="<%=(Integer)(a.get("goods_amount")) %>">

	</div>

	
		<div style="color: #5D5D5D;">
		<span class="input-group-text" style="width: 90px;">제품상세</span>
		<textarea rows="5" cols="50" name="goodsContent" disabled ><%=(String)(a.get("goods_content")) %></textarea>
	</div>
	
	
	
	<div>
		<button type="submit">상품 삭제</button>
	</div>
	
	<%}}} 
					
		
					
					else if(modify.equals("insert")) {
				%>
				
				<h2 style="margin-left: 10px; margin-bottom: 30px;"><span class="material-symbols-outlined" style="margin-right: 10px;">note_stack_add</span>상품 추가</h2>
		
				
			<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품코드</span>
  					<input type="number" class="form-control" name="goodsNo" disabled>
  					
  					<button type="submit" value="" disabled><span class="material-symbols-outlined">check</span></button>
				</div>
				
	<!-- enctype="multipart/form-data" 0   문제원인 multipart에러 form에서 multipart제거하면 정상적으로 param값 전송됨  -->
												
				<form method="post" action="/shop/emp/addGoodsAction.jsp" enctype="multipart/form-data" >
					<div style="color: #5D5D5D;  margin-bottom: 10px;">
						<button type="button" class="btn btn-light border">카테고리</button>
						<select name="category" required>
							<option value="">선택</option>
	<%						//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
							for(String c : categoryList) {
	%>
								<option value="<%=c%>"><%=c%></option>
	<%		
							}
	%>
					</select>

				</div>

				<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
	
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품명</span>
  					<input type="text" class="form-control" name="goodsTitle" required>

				</div>

				<div style="color: #5D5D5D; margin-bottom: 10px;">
					<button type="button" class="btn btn-light border">이미지</button>
					<input type="file" name="goodsImg">
				</div>
				
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">상품가</span>
  					<input type="number" class="form-control" name="goodsPrice" required>

				</div>
				
				<div class="input-group" style="margin-bottom: 10px;">
  					<span class="input-group-text">보유재고</span>
  					<input type="number" class="form-control" name="goodsAmount" required>

				</div>
				
				
				
				<div style="color: #5D5D5D;">
					<span class="input-group-text" style="width: 90px;">제품상세</span>
					<textarea rows="5" cols="50" name="goodsContent"></textarea>
				</div>
				<div>
					<button type="submit">신규 추가</button>
				</div>
		
			
		
				<%}%>
	
	

			</form>
				
			<%if(msg!=null){
				%><%=msg %><% 
			}%>
			
			</div>
			<div class="col">
			

			<!-- <div>
				<a href="/shop/emp/goodsList.jsp">전체</a>
	<%
				for (HashMap m2 : selectCountGroupByCategory) {
	%>
				<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m2.get("category"))%>">
	<%=				(String)(m2.get("category"))%>(<%=(Integer)(m2.get("cnt"))%>)
				</a>	
	<%
				}
	%>
			</div> -->
			<h1 style="margin-top: 10px;">상품 목록</h1>
			
			<!-- 페이징 버튼 -->	
					<div>
						<form method="get" action="/shop/emp/addGoodsForm.jsp">
							
							
								<span></span><select name="rowPerPage">
	<%
									if (rowPerPage == 10) {
	%>
										<option value="10" selected="selected">10</option>
										<option value="20">20</option>
										<option value="30">30</option>
										<option value="50">50</option>
	<%
									} else if (rowPerPage == 20) {
	%>
										<option value="10">10</option>
										<option value="20" selected="selected">20</option>
										<option value="30">30</option>
										<option value="50">50</option>
	<%
									} else if (rowPerPage == 30) {
	%>
										<option value="10">10</option>
										<option value="20">20</option>
										<option value="30" selected="selected">30</option>
										<option value="50">50</option>
	<%
									} else if (rowPerPage == 50) {
	%>
										<option value="10">10</option>
										<option value="20">20</option>
										<option value="30">30</option>
										<option value="50" selected="selected">50</option>
	<%
									}
	%>
								</select>
								<button type="submit">목록갯수변경</button>
					

						
						</form>
						</div>
			<div class="container mt-3">
				<table class="table table-hover">
					<thead class="table-primary" >
						<tr>
							<th>상품코드</th>
							<th>카테고리</th>
							<th>사원ID</th>
							<th>상품명</th>
							<th>단가(원)</th>
							<th>보유재고 수량</th>
							<th>상품변동일자</th>
							<th>최초입고날짜</th>
						</tr>
					</thead>
					<tbody>
	<%					//rs.getString이 아닌 HashMap으로 값을 뿌림
						for(HashMap<String, Object> m3 : selectGoodsOrderByList) {
	%>
							<tr>
								<td><%=(Integer)(m3.get("goods_no"))%></td>
								<td><%=(String)(m3.get("category"))%></td>
								<td><%=(String)(m3.get("emp_id"))%></td>
								<td><%=(String)(m3.get("goods_title"))%></td>
								<td><%=(String)(m3.get("goods_price"))%></td>
								<td><%=(Integer)(m3.get("goods_amount"))%></td>
								<td><%=(String)(m3.get("update_date"))%></td>
								<td><%=(String)(m3.get("create_date"))%></td>
							</tr>
					</tbody>
	<%		
						}
	%>
				</table>
				
				<nav class="nav a_textColor1" aria-label="Page navigation" style="margin-top: 15px; height:30px;">
						<ul class="justify-content-center">
							
				<%		
						
								//현재 페이지가 1 이상일때
								if (currentPage > 1) {
				%>
									<li class="floatLeft a_textColor2"  >
										<span class="a_marginRight"><a class="page-link"
										href="/shop/emp/addGoodsForm.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a></span></li>
									<li class="floatLeft a_textColor2">
										<span class="a_marginRight"><a class="page-link"
										href="/shop/emp/addGoodsForm.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>">이전페이지</a></span>
									</li>
				<%				//현재 페이지가 1보다 작을때
								} else {
				%>
									<li class="page-item floatLeft" style="color: gray;">
										<span class="a_marginRight disabled"><a class="page-link" style="color: gray;"
										href="/shop/emp/addGoodsForm.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a></span>
									</li>
									<li class="page-item floatLeft" style="color: gray;">
									<span class="a_marginRight disabled"><a class="page-link" style="color: gray;"
										href="/shop/emp/addGoodsForm.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>">이전페이지</a></span>
									</li>
				<%
								}
										
								//현재 페이지가 최종페이지가 작을 때
								if (currentPage < totalPage) {
				%>
									<li class="floatLeft">
										<span class="a_marginRight"><a class="page-link"
										href="/shop/emp/addGoodsForm.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>">다음페이지</a></span>
									</li>
									<li class="floatLeft">
										<span class="a_marginRight"><a class="page-link"
										href="/shop/emp/addGoodsForm.jsp?currentPage=<%=totalPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a></span></li>
				<%				//현재 페이지가 최종페이지보다 같거나 클 때
								} else {
				%>
									<li class="page-item floatLeft" style="color: gray;">
										<span class="a_marginRight disabled"><a class="page-link" style="color: gray;"
										href="/shop/emp/addGoodsForm.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>">다음페이지</a></span></li>
									<li class="page-item floatLeft" style="color: gray;">
										<span class="a_marginRight disabled"><a class="page-link" style="color: gray;"
										href="/shop/emp/addGoodsForm.jsp?currentPage=<%=totalPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a></span></li>
				<%
								}
								
						
							
				%>
				</ul>
				</nav>
			
			
			
			
			</div>
		
			</div>
			</div>
		</body>
</html>
