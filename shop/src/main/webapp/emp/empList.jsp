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
%>

<!-- View Layer : 모델(ArrayList<HashMap<String, Object>>) 출력 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<title>empList</title>
</head>
		<body>
			<!-- empMenu.jsp  인클루드(include)기술 : 주체(서버) vs redirect(주체: 클라이언트) //주체가 서버이기 때문에 프로젝트명 필요없이 폴더내에서 이동가능-->
			<jsp:include page="/emp/empMenu.jsp"></jsp:include>
			<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
			<h1>사원 목록</h1>
			<div class="container mt-3">
				<table class="table table-hover">
					<thead class="table-success">
						<tr>
							<th>사원ID</th>
							<th>사원이름</th>
							<th>직종분류</th>
							<th>입사날짜</th>
							<th>회원여부</th>
						</tr>
					</thead>
					<tbody>
	<%					//rs.getString이 아닌 list(ArrayList)에서 값을 꺼내서 뿌림
						for(HashMap<String, Object> m : list) {
	%>
							<tr>	<!--HashMap에서 꺼낸 Object 객체를 String으로 형변환 -->
								<td><%=(String)(m.get("empId"))%></td>
								<td><%=(String)(m.get("empName"))%></td>
								<td><%=(String)(m.get("empJob"))%></td>
								<td><%=(String)(m.get("hireDate"))%></td>
								<td>		
	<%								//grade값이 0이상인 관리자 계급만 수정권한 부여 분기
								    HashMap<String, Object> sm = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
	
								    if((Integer)(sm.get("grade")) > 0) {
	%>									<!-- 사원 active 수정 페이지에 active값, empId값 전달 -->
										<a href='modifyEmpActive.jsp?active=<%=(String)(m.get("active"))%>&empId=<%=(String)(m.get("empId"))%>'>
											<%=(String)(m.get("active"))%>
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

