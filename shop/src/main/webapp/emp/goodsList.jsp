<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="shop.dao.*" %>
<%@ page import= "java.text.*" %>

<%
System.out.println("---------------goodList.jsp");
System.out.println("세션 ID: " + session.getId());
System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
System.out.println("[param]currentPage : " + request.getParameter("currentPage"));
System.out.println("[param]view : "+ request.getParameter("view"));
System.out.println("[param]category : "+request.getParameter("category"));
System.out.println("[param]order : "+request.getParameter("order"));
System.out.println("[param]goods_no : "+request.getParameter("goods_no"));
System.out.println("[param]type : "+request.getParameter("type"));
System.out.println("[param]msg : "+request.getParameter("msg"));

String type = null;
String category = null;
int order = 0;
int goods_no = 0;
String errMsg = null;
String msg = null;
String encodedCategory = null;
String filename = null;

NumberFormat format = NumberFormat.getNumberInstance(Locale.US);


// 인증분기	 : 세션변수 이름 - loginEmp
if (session.getAttribute("loginEmp") == null) {
	if(session.getAttribute("loginCs") == null){
	System.out.println("세션값이 존재하지 않습니다.");
	errMsg = URLEncoder.encode("비정상적 접근입니다.","UTF-8");
	response.sendRedirect("/shop/emp/loginForm.jsp?errMsg="+errMsg);
	return;
	}else if(session.getAttribute("loginCs") != null){
		type = "customer";
	}
}


if(type==null){
	type = "employee";
}

System.out.println("type : " + type);

//controller layer
//String s = "SELECT * FROM category";

//페이징 관련 변수


if(request.getParameter("category")!=null){
	category = request.getParameter("category");
	encodedCategory = URLEncoder.encode(category, "UTF-8");
}




if(request.getParameter("goods_no")!=null){
	goods_no = Integer.parseInt(request.getParameter("goods_no"));
}

if(request.getParameter("msg")!=null){
	msg = request.getParameter("msg");
}


if(request.getParameter("order")!=null){

	if(request.getParameter("order").equals("")){
		//response.sendRedirect("/shop/emp/goodsList.jsp?currentPage="+request.getParameter("currentPage")+"&rowPerPage="+ request.getParameter("rowPerPage"));
		order = 0;
	}else if(request.getParameter("order")!=null){
		order = Integer.parseInt(request.getParameter("order"));
	}
}



System.out.println("category : " + category);
System.out.println("order : " + order);

//전체행수 검색 변수설정 -------------------------
int totalRow = 0;			//조회쿼리 전체행수
int rowPerPage = 6; 		//페이지당 행수
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
conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1: /", "", "");
//쿼리1 - 테이블에 뿌릴 데이터 조회

if(request.getParameter("category")!= null){
	
String sql1 = "select category, goods_no, emp_id, goods_title, goods_price, goods_amount, filename, update_date, create_date from goods where category =? limit ?,?";

stmt1 = conn.prepareStatement(sql1);
stmt1.setString(1,category);
stmt1.setInt(2,limitStartPage);
stmt1.setInt(3,rowPerPage);

}else{
	String sql1 = "select category, goods_no, emp_id, goods_title, goods_price, goods_amount, filename, update_date, create_date from goods limit ?,?";
	
	stmt1 = conn.prepareStatement(sql1);
	
	stmt1.setInt(1,limitStartPage);
	stmt1.setInt(2,rowPerPage);
}


rs1 = stmt1.executeQuery();

ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();

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
	m.put("filename", rs1.getString("filename"));
	
	categoryList.add(m);

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

//디버깅 ArrayList는 문자열 디버깅 가능-주소가 아닌 값이 나오기 때문에

System.out.println("categoryCount(리스트에 추가된 카테고리 그룹별 행수 : "+categoryCount);




//쿼리3 - 전체 행수 조회용 쿼리
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


PreparedStatement stmt4 = null;
ResultSet rs4 = null;

//카테고리 테이블에서 카테고리 항목을 조회
String sql4 = "select category from category";
stmt4 = conn.prepareStatement(sql4);
rs4 = stmt4.executeQuery();

ArrayList<String> categoryName =
		new ArrayList<String>();
//조회가 된다면 카테고리 칼럼값을 categoryList 리스트에 추가
while(rs4.next()) {
	categoryName.add(rs4.getString("category"));
}
// 디버깅
System.out.println("categoryName(ArrayList<String>) : "+ categoryName);
*/

ArrayList<HashMap<String, Object>> selectGoodsList = null;
ArrayList<HashMap<String, Object>> selectGoodsListCategory = null;
//-------------------------문제지점 확인------------------------------------------------------------------------
if(request.getParameter("category")== null || category.equals("1")){
	selectGoodsList = GoodsDAO.selectGoodsList(limitStartPage, rowPerPage);
	System.out.println("GoodsDAO.selectGoodsList() 메서드 실행");
		
}else if(request.getParameter("category")!=null && !(category.equals("1"))){
	selectGoodsListCategory = GoodsDAO.selectGoodsListCategory(category,limitStartPage, rowPerPage);
	System.out.println("GoodsDAO.selectGoodsListCategory() 메서드 실행");
}
//-------------------------문제지점 확인------------------------------------------------------------------------

ArrayList<HashMap<String, Object>> selectGroupByCategory = GoodsDAO.selectGroupByCategory();
System.out.println("GoodsDAO.selectGroupByCategory() 메서드 실행");
int selectCountGoods = GoodsDAO.selectCountGoods();
System.out.println("GoodsDAO.selectCountGoods() 메서드 실행");
ArrayList<String> categoryName = GoodsDAO.categoryList();
System.out.println("categoryName = GoodsDAO.categoryList() 메서드 실행");



//페이징 목록 코드
totalRow = GoodsDAO.selectCountGoods();

//전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
if (totalRow % rowPerPage != 0) {
	totalPage = totalRow / rowPerPage + 1;
//전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
} else {
	totalPage = totalRow / rowPerPage;
}

//세션 변수 loginEmp값 받을 HashMap 변수 m 생성
HashMap<String,Object> m = new HashMap<>();


String name = null;
String empJob = null;
int grade = 0;
String admin = null;
String mail = null;
String gender = null;
//변수할당
if(type.equals("employee")){
	m = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	name = (String)(m.get("empName"));
	empJob = (String)(m.get("empJob"));
	grade = (int)(m.get("grade"));
	if(grade==1){
		admin = "Administrator";
	}
	System.out.println(session.getAttribute("loginEmp"));
	System.out.println("empName : "+name);
	System.out.println("empJob : "+empJob);
	System.out.println("grade : "+grade);

}else if(type.equals("customer")){
	m = (HashMap<String,Object>)(session.getAttribute("loginCs"));
	name = (String)(m.get("csName"));
	mail = (String)(m.get("csMail"));
	gender = (String)(m.get("csGender"));
	
	System.out.println(session.getAttribute("loginCs"));
	System.out.println("name : "+name);
	System.out.println("mail : "+mail);
	System.out.println("gender : "+gender);
}


//해쉬맵 변수 스트링변수에 할당





/*
int startRow = 0;
int rowPerPage = 10;
ArryaList<HashMap<String,Object>> goodsList> = GoodsDAO.selectGoodsList(startRow, rowPerPage);
*/


%>
<!-- view Layer -->
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
<title>goodsList</title>
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
		
	.containerlist {
		display: flex;
		flex-wrap: wrap;
		
	}
				
	.goods {
		flex: 0 0 33.333%;
		box-sizing: border-box;
		padding: 10px;
	}
		
	.goods:hover{
		
		border:solid 1px;
		padding: 9px;
		border-radius: 2px;
		border-color: #B2CCFF;
	}
		
	.box {
		margin-bottom: 5px;
	}
		
	.divimg{
		width: 400px;
		height: 300px;
		overflow: hidden;
	}		
		
	.img{
		height: 300px;
	}
	
	input[type="number"] {
	
	    background-color: #f8f8f8;
	    border: 1px solid #ccc;
	    height: 40px;
	    width: 70px;
	    text-align: center;
	}

	input[type="number"]:focus {
	    border-color: #888;
	}

	button {
	text-decoration: none;
	color: #616161;
	}
	
	button:hover {
	    background-color: #d9e9fc;
	 
	}
	
	button:active {
	    color: #000000; 
	}

	button.purchase  {
	text-decoration: none;
	color: #6ea2f5;
	}
	
	button.purchase:hover {
	    color:#4287f5;
	    text-decoration: underline;
	}
	
	button.purchase:active {
	    
	    background-color: #c2d9ff; 
	}
	
	.paymentfont{
		color: #5c5a5a;
		font-size: 20px;
	}
	
	.payment{
		color: #ff4747;
		font-size: 25px;
	}
	
	.paymentbutton{
		color: #5e5e5e;
		font-size: 10px;
		width: 60px;
		height: 30px;
		background-color: gray;
		border: 1px solid;
	}

	</style>
</head>
		<body>
			  <div class="container-fluid banner">
		        <div style="margin-bottom: 13px;">
		            <div>
		                <span class="material-symbols-outlined" style="margin-right: 3px;">
		                
		                <%
		                if(type.equals("customer")){
	     
		                	if(gender.equals("남")){
		                		%>face<%
		                	}else{
		                		%>face_3<%
		                	}
		                }else{
		                	%>face<%
		                }
		                %>
		                
		                </span>
		                <span style="margin-right: 5px; color: #000000;"><%=name%> / 
		                
		                <%
		                if(type.equals("customer")){
	     
		                	%>고객님<%
		                }else{
		                %>	<%=empJob %> <%
		                } 
		                %>
		                
		                </span>
		                <span style="margin-right: 30px;"> 
		                    <% if(admin!=null){ %>
		                        &lt;<%=admin %>&gt;
		                    <% } %>
		                </span>
		                <span style="margin-right: 1px; font-style: italic; font-size: 25px; color: #204675;">
		                    <%=name%>님 반갑습니다. 오늘도 좋은 하루 되십시오. &#x1F338;
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
		                    <a class="nav-link active" href="/shop/emp/goodsList.jsp">
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">inventory</span>
		                        <span>Catalog</span>
		                    </a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link" href="/shop/emp/addGoodsForm.jsp"> 
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
			
			<div>
				<div class="row">
					<div class="col-2" style="background-color: #EBF7FF; height: 1000px; width: 250px">		
						<h2 style="margin-bottom: 30px; margin-top: 78px; margin-left: 10px;"><span class="material-symbols-outlined" style="margin-right: 10px;">inventory</span>상품 리스트</h2>
						
						
						<div style="margin-bottom: 50px;">
							<form method="post" action="/shop/emp/goodsList.jsp">
							category :
								<select name="category">
	<% 
									if(request.getParameter("category")==null||category.equals("1")){
	%>
										<option value="1">선택</option>
	<%								} else{
										for(String a : categoryName){
											if(a.equals(category)){
	%>											<option value="<%=a %>"><%=a %></option>
	<% 
											}
										}
									}
	%>
	<%								//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
									for(String c : categoryName) {
	%>
										<option value="<%=c%>"><%=c%></option>
	<%		
									}
	%>
								</select>
								<span>
									<button type="submit">
										<span class="material-symbols-outlined">check</span>
									</button>
								</span>
							</form>
						</div>
						
						
						
						<div>
							<nav class="nav a_textColor1" aria-label="Page navigation" style="margin-top: 15px; margin-bottom:100px; height:30px;">
								<ul class="justify-content-center">			
	<%		
									//현재 페이지가 1 이상일때
									if (currentPage > 1) {
	%>
										<li class="floatLeft a_textColor2"  >
											<span class="a_marginRight"><a class="page-link"
												href="/shop/emp/goodsList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a></span></li>
										<li class="floatLeft a_textColor2">
											<span class="a_marginRight"><a class="page-link"
												href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>">이전페이지</a></span>
										</li>
	<%									//현재 페이지가 1보다 작을때
									} else {
	%>
										<li class="page-item floatLeft" style="color: gray;">
											<span class="a_marginRight disabled"><a class="page-link" style="color: gray;"
												href="/shop/emp/goodsList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a></span>
										</li>
										<li class="page-item floatLeft" style="color: gray;">
											<span class="a_marginRight disabled"><a class="page-link" style="color: gray;"
												href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>">이전페이지</a></span>
										</li>
	<%
									}		
										//현재 페이지가 최종페이지가 작을 때
									if (currentPage < totalPage) {
	%>
										<li class="floatLeft">
											<span class="a_marginRight"><a class="page-link"
												href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>">다음페이지</a></span>
										</li>
										<li class="floatLeft">
											<span class="a_marginRight"><a class="page-link"
												href="/shop/emp/goodsList.jsp?currentPage=<%=totalPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a></span></li>
	<%								//현재 페이지가 최종페이지보다 같거나 클 때
									} else {
	%>
										<li class="page-item floatLeft" style="color: gray;">
											<span class="a_marginRight disabled"><a class="page-link" style="color: gray;"
												href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage + 1%>&rowPerPage=<%=rowPerPage%>">다음페이지</a></span></li>
										<li class="page-item floatLeft" style="color: gray;">
											<span class="a_marginRight disabled"><a class="page-link" style="color: gray;"
												href="/shop/emp/goodsList.jsp?currentPage=<%=totalPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a></span></li>
	<%
									}
	
	%>
								</ul>
							</nav>
						</div>
						<div>
							<%
								if(request.getParameter("msg")!= null){
									%> <%=msg %>
							<% 	}
							%>
						</div>
					</div>	
					<div class="col-10">
						<div class="containerlist" style="height: 800px; margin-top: 100px;">
	<%
							int count = 1;

							if(category == null ||category.equals("1")){
								for(HashMap<String, Object> m4 : selectGoodsList) {
									filename = (String)m4.get("filename");
									if(count >= 7){
										break;
									}
	%>
									<div class="goods">
										<div class="divimg"  style="margin-bottom: 2px;">
								    		<img class = "img" src="/shop/upload/<%=m4.get("filename") %>">
								   	 	</div>
								   		<div class="row">
								    		<div class="col-5">
								  				<div class="box" style="font-style: italic; font-size: 14px;">
								    				<span>상품코드 : <%=m4.get("goods_no")%></span>
								    				
								    				<%
								    					if((Integer)(m4.get("goods_amount")) <= 10){
								    					%>	<span style="margin-left: 18px; color: red;">
										    				<span class="material-symbols-outlined">alarm
										    				</span> 품절임박</span>
								    				<%	}
								    				%>
								    				
								   				</div>      
												<div class="box" style="font-weight: 300;">
								  				<%=m4.get("goods_title")%>
								    </div>
								    <div>
								    	<span>상품단가 : </span>
								        <span class="box" style="color: #CC3D3D; font-size: 18px;"><%=m4.get("goods_price")%>원</span>
								    </div>
								   	</div>
								   	<div class="col-2">
								   	<form method="post" action="/shop/emp/goodsList.jsp">
							   		<div style="margin-bottom: 10px; margin-left: 0px;">
							   		
							   		<button class="purchase" style="border: none; background: none; margin-left: opx; padding-left: 0px;">
							   		구매수량</button></div>
								   			
								   		<input type="hidden" name="currentPage" value="<%=currentPage%>">
								   		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
								   		<input type="hidden" name="goods_no" value="<%=m4.get("goods_no")%>">
								   			<input type="number" style="width: 50px; margin-left: 2px;" name="order"
								   			<%
								   				if(request.getParameter("goods_no") != null){
								   				%>	value="<%=goods_no == (Integer)m4.get("goods_no") ? order : "" %>"
								   				<%
								   				}else{
								   				%>
								   				 
								   				<%	
								   				}
								   			%>
								   			>

								   		
								   		</form>
								   	</div>
								   	
								   	
								   	
								  
								
								   	
								   	<div class="col-5">
    <% if(request.getParameter("goods_no") != null && goods_no == (Integer)m4.get("goods_no") && order >0) { 
    	int beforePrice = (Integer)(m4.get("goodsIntPrice")) * order;
    	String convertedPrice = format.format(beforePrice);
    %>
        <div class="paymentfont">결제하실 금액</div>
        <div class="payment"><%= convertedPrice + "원" %></div>
        <a href="/shop/customer/purchaseAction.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&category=<%=encodedCategory%>&order_quantity=<%=order %>&total_price=<%= (Integer)(m4.get("goodsIntPrice")) * order%>&goods_no=<%=goods_no %>&filename=<%=filename %>" 
        class="btn btn-primary purchase-button">바로구매
            <span class="material-symbols-outlined">shopping_cart</span>
        </a>
    <% } %>
</div>
								   	
								   	
								   	</div>
								</div>
								
	<%
								count++;
									}}else if(category != null){
									for(HashMap<String, Object> m4 : selectGoodsListCategory) {
										filename = (String)m4.get("filename");
										
										if(count >= 7){
											break;
										}
			%>
											<div class="goods">
								
									<div class="divimg"  style="margin-bottom: 2px;">
								    	<img class = "img" src="/shop/upload/<%=m4.get("filename") %>">
								    </div>
								    <div class="row">
								    <div class="col-5">
								    <div class="box" style="font-style: italic; font-size: 14px;">
								    	<span>상품코드 : <%=m4.get("goods_no")%></span>
								    	<%
								    					if((Integer)(m4.get("goods_amount")) <= 10){
								    					%>	<span style="margin-left: 18px; color: red;">
										    				<span class="material-symbols-outlined">alarm
										    				</span> 품절임박</span>
								    				<%	}
								    				%>
								    	
								    	
								    </div>      
								    <div class="box" style="font-weight: 300;">
								    	<%=m4.get("goods_title")%>
								    </div>
								    <div>
								    	<span>상품단가 : </span>
								        <span class="box" style="color: #CC3D3D; font-size: 18px;"><%=m4.get("goods_price")%>원</span>
								    </div>
								   	</div>
								   	<div class="col-2">
								   	<form method="post" action="/shop/emp/goodsList.jsp">
							   		<div style="margin-bottom: 10px; margin-left: 0px;">
							   		
							   		<button class="purchase" style="border: none; background: none; margin-left: opx; padding-left: 0px;">
							   		구매수량</button></div>
								   		<input type="hidden" name="category" value="<%=category%>">
								   		<input type="hidden" name="currentPage" value="<%=currentPage%>">
								   		<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
								   		<input type="hidden" name="goods_no" value="<%=m4.get("goods_no")%>">
								   			<input type="number" style="width: 50px; margin-left: 2px;" name="order"
								   			<%
								   				if(request.getParameter("goods_no") != null){
								   				%>	value="<%=goods_no == (Integer)m4.get("goods_no") ? order : "" %>"
								   				<%
								   				}else{
								   				%>
								   				 
								   				<%	
								   				}
								   			%>
								   			>

								   		
								   		</form>
								   	</div>
								   	
								   	
								   	
								  
								
								   	
								   	<div class="col-5">
    <% if(request.getParameter("goods_no") != null && goods_no == (Integer)m4.get("goods_no") && order >0) {
    	int beforePrice = (Integer)(m4.get("goodsIntPrice")) * order;
    	String convertedPrice = format.format(beforePrice);
    	%>
        <div class="paymentfont">결제하실 금액</div>
        <div class="payment"><%= convertedPrice + "원" %></div>
        <a href="/shop/customer/purchaseAction.jsp?currentPage=<%=currentPage%>&rowPerPage=<%=rowPerPage%>&category=<%=encodedCategory%>&order_quantity=<%=order %>&total_price=<%= (Integer)(m4.get("goodsIntPrice")) * order%>&goods_no=<%=goods_no %>&filename=<%=filename %>" 
        class="btn btn-primary purchase-button">바로구매
            <span class="material-symbols-outlined">shopping_cart</span>
        </a>
    <% } %>
</div>
								   	
								   	
								   	</div>
								</div>
										
			<%
										count++;
									
								}
								
							}
	%>
						</div>
	
					</div>
				</div>
			</div>
		</body>
</html>