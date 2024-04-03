<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>

<%
System.out.println("---------------goodList.jsp");

System.out.println("[param]rowPerPage : " + request.getParameter("rowPerPage"));
System.out.println("[param]currentPage : " + request.getParameter("currentPage"));

// 인증분기	 : 세션변수 이름 - loginEmp
if (session.getAttribute("loginEmp") == null) {
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
	return;
}
//controller layer
//String s = "SELECT * FROM category";

//페이징 관련 변수



String category = request.getParameter("category");
System.out.println("category : " + category);

//전체행수 검색 변수설정 -------------------------
int totalRow = 0;			//조회쿼리 전체행수
int rowPerPage = 20; 		//페이지당 행수
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

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null;
PreparedStatement stmt1 = null;
ResultSet rs1 = null;
//쿼리1 - 테이블에 뿌릴 데이터 조회
String sql1 = "select category, goods_no, emp_id, goods_title, goods_price, goods_amount, update_date, create_date from goods limit ?,?";
conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
stmt1 = conn.prepareStatement(sql1);
stmt1.setInt(1,limitStartPage);
stmt1.setInt(2,rowPerPage);
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
	
	categoryList.add(m);

}


//쿼리2 - 전체 행수 조회용 쿼리
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
System.out.println("categoryList(리스트에 추가된 칼럼명 목록) : "+categoryList);
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


//페이징 목록 코드


//전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
if (totalRow % rowPerPage != 0) {
	totalPage = totalRow / rowPerPage + 1;
//전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
} else {
	totalPage = totalRow / rowPerPage;
}

%>
<!-- view Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>goodsList</title>
</head>
		<body>
			<!-- 메인메뉴 -->
			<div>
				<jsp:include page="/emp/empMenu.jsp"></jsp:include>
			</div>
			
			<!--  서브메뉴 카테고리별 -->
			<div>
				<a href="/shop/emp/goodsList.jsp">전체</a>
	<%
				for (HashMap m2 : categoryCount) {
	%>
				<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m2.get("category"))%>">
	<%=				(String)(m2.get("category"))%>(<%=(Integer)(m2.get("cnt"))%>)
				</a>	
	<%
				}
	%>
			</div>
			<h1>상품 목록</h1>
			
			<!-- 페이징 버튼 -->	
					<div>
						<form method="get" action="/shop/emp/goodsList.jsp">
							
							
								<span></span><select name="rowPerPage">
	<%
									if (rowPerPage == 20) {
	%>
										<option value="20">20</option>
										<option value="30">30</option>
										<option value="40">40</option>
										<option value="50">50</option>
	<%
									} else if (rowPerPage == 30) {
	%>
										<option value="20">20</option>
										<option value="30" selected="selected">30</option>
										<option value="40">40</option>
										<option value="50">50</option>
	<%
									} else if (rowPerPage == 40) {
	%>
										<option value="20">20</option>
										<option value="30">30</option>
										<option value="40" selected="selected">40</option>
										<option value="50">50</option>
	<%
									} else if (rowPerPage == 50) {
	%>
										<option value="20">20</option>
										<option value="30">30</option>
										<option value="40">40</option>
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
					<thead class="table-success">
						<tr>
							<th>상품코드</th>
							<th>카테고리</th>
							<th>사원ID</th>
							<th>상품명</th>
							<th>단가</th>
							<th>보유재고 수량</th>
							<th>상품변동일자</th>
							<th>최초입고날짜</th>
						</tr>
					</thead>
					<tbody>
	<%					//rs.getString이 아닌 HashMap으로 값을 뿌림
						for(HashMap<String, Object> m : categoryList) {
	%>
							<tr>
								<td><%=(Integer)(m.get("goods_no"))%></td>
								<td><%=(String)(m.get("category"))%></td>
								<td><%=(String)(m.get("emp_id"))%></td>
								<td><%=(String)(m.get("goods_title"))%></td>
								<td><%=(Integer)(m.get("goods_price"))%></td>
								<td><%=(Integer)(m.get("goods_amount"))%></td>
								<td><%=(String)(m.get("update_date"))%></td>
								<td><%=(String)(m.get("create_date"))%></td>
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
										href="/shop/emp/goodsList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a></span></li>
									<li class="floatLeft a_textColor2">
										<span class="a_marginRight"><a class="page-link"
										href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage - 1%>&rowPerPage=<%=rowPerPage%>">이전페이지</a></span>
									</li>
				<%				//현재 페이지가 1보다 작을때
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
				<%				//현재 페이지가 최종페이지보다 같거나 클 때
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
			
		</body>
</html>