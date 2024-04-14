<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import= "java.net.*" %>

<%
	System.out.println("---------------empMain.jsp");
	System.out.println("사원 기본 화면페이지입니다.");

	// 인증분기	 : 세션변수 이름 - loginEmp
	if (session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/loginForm.jsp");
		return;
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
		                    <a class="nav-link active" href="/shop/emp/empMain.jsp">
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
		                    <a class="nav-link" href="/shop/emp/empList.jsp">
		                        <span class="material-symbols-outlined" style="margin-right: 8px;">badge</span>
		                        <span>Employee</span>
		                    </a>
		                </li>
		            </ul>
		        </div>
		    </div>
		
		    <div>
		
		    </div>
		</body>
	
</html>