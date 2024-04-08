<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>

<%
	System.out.println("---------------empList.jsp");
	System.out.println("---사원리스트를 조회하는 페이지입니다---");
%>
<!-- Controller Layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
	// request 분석
	//페이징 변수생성
	int currentPage = 1; //현재 페이지 초기값 할당 
	//현재 페이지에 대한 파라미터값이 있다면 currentPage 변수에 할당
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10; //로우퍼페이지 초기값 할당
	int startRow = (currentPage-1)*rowPerPage; //시작행 변수로직
%>

<!-- Model Layer -->

<%
	// 특수한 형태의 데이터(RDBMS:mariadb) 
	// -> API사용(JDBC API)하여 자료구조(ResultSet) 취득 
	// -> 일반화된 자료구조(ArrayList<HashMap>)로 변경 -> 모델 취득
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	//쿼리1 - 테이블에 뿌릴 데이터 조회(emp테이블)
	String sql1 = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt1 = conn.prepareStatement(sql1);
	
	stmt1.setInt(1, startRow);
	stmt1.setInt(2, rowPerPage);
	rs1 = stmt1.executeQuery(); 
	// JDBC API 종속된 자료구조 모델 ResultSet  -> 기본 API 자료구조(ArrayList)로 변경
	
	//쿼리2
	
	
	
	
	//rs1 조회값을 list(ArrayList)에 저장하기 위한 ArryaList 객체생성
	ArrayList<HashMap<String, Object>> list
		= new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs1.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		//HashMap에 키,밸류값 입력
		m.put("empId", rs1.getString("empId"));
		m.put("empName", rs1.getString("empName"));
		m.put("empJob", rs1.getString("empJob"));
		m.put("hireDate", rs1.getString("hireDate"));
		m.put("active", rs1.getString("active"));
		//ArrayList에 HashMap값 입력
		list.add(m);
	}
	// JDBC API 사용이 끝났다면 DB자원들을 반납
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
%>

<!-- View Layer : 모델(ArrayList<HashMap<String, Object>>) 출력 -->
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
	<title>empList</title>
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
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">account_circle</span>
		                        <span>Account</span>
		                    </a>
		                </li>
		
		                <li class="nav-item">
		                    <a class="nav-link" href="/shop/emp/goodsList.jsp">
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
		                    <a class="nav-link" href="/shop/emp/categoryList.jsp"> 
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">category</span>
		                        <span>Items</span>
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
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">alarm</span>
		                        <span>Schedule</span>
		                    </a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link active" href="/shop/emp/empList.jsp">
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">badge</span>
		                        <span>Employee</span>
		                    </a>
		                </li>
		            </ul>
		        </div>
		    </div>
		
			<h1>사원 목록</h1>
			<div class="container mt-3">
				<table class="table table-hover">
					<thead class="table-success">
						<tr>
							<th>사원ID</th>
							<th>사원이름</th>
							<th>직급</th>
							<th>입사날짜</th>
							<th>회원여부</th>
						</tr>
					</thead>
					<tbody>
	<%					//rs.getString이 아닌 list(ArrayList)에서 값을 꺼내서 뿌림
						for(HashMap<String, Object> m2 : list) {
	%>
							<tr>	<!--HashMap에서 꺼낸 Object 객체를 String으로 형변환 -->
								<td><%=(String)(m2.get("empId"))%></td>
								<td><%=(String)(m2.get("empName"))%></td>
								<td><%=(String)(m2.get("empJob"))%></td>
								<td><%=(String)(m2.get("hireDate"))%></td>
								<td>		
	<%								//grade값이 0이상인 관리자 계급만 수정권한 부여 분기
								    HashMap<String, Object> sm = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
	
								    if((Integer)(sm.get("grade")) > 0) {
	%>									<!-- 사원 active 수정 페이지에 active값, empId값 전달 -->
										<a href='modifyEmpActive.jsp?active=<%=(String)(m2.get("active"))%>&empId=<%=(String)(m2.get("empId"))%>'>
											<%=(String)(m2.get("active"))%>
										</a>
	<%								}
	%>
								</td>
							</tr>
					</tbody>
	<%		
						}
	%>
				</table>
			</div>
		</body>
</html>

