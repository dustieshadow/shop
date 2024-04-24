<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import= "java.net.*" %>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("---------------orderList.jsp----------");
	
	System.out.println("세션 ID: " + session.getId());
	
	
	String errMsg = null;
	String type = null;
	String msg = null;
	String filename = null;



	


	if (session.getAttribute("loginEmp") == null && session.getAttribute("loginCs") == null) {
		System.out.println("비정상적 접근입니다.");
		msg = URLEncoder.encode("비정상적 접근입니다.","UTF-8");
		response.sendRedirect("/shop/emp/loginForm.jsp?msg="+msg);
		return;
	} else if (session.getAttribute("loginEmp") == null && session.getAttribute("loginCs") != null){
		type = "customer";
	
	}
	
	if(type==null){
		type = "employee";
	}
	
	System.out.println("type : " + type);

	System.out.println("[param]category :"+request.getParameter("category"));
	
	
	String category = null;
	int currentPage = 1;
	int totalPage = 1;
	int rowPerPage = 6;
	
	if(request.getParameter("category")!= null){
		category = request.getParameter("category");
		System.out.println("category : "+category);
	}
	
	if(request.getParameter("filename")!= null){
		filename = request.getParameter("filename");
		System.out.println("filename : "+filename);
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

	
	ArrayList<HashMap<String,Object>> selectGroupByCategory = GoodsDAO.selectGroupByCategory();
	ArrayList<String> categoryList = GoodsDAO.categoryList();
	ArrayList<HashMap<String,Object>> chartGoodsListCategory = GoodsDAO.chartGoodsListCategory(category);


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

  .chart-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 800px;
            margin: 0 auto;
            margin-top: 50px;
        }


.chart-container {
    display: flex;
    justify-content:center;
    align-items: flex-end;
    height: 300px; 
    border: 2px solid #000;
    padding: 10px;
    background-color: #f4f4f4; 
    width: 800px;
    margin-top: 100px;
    margin-left: 5px;

}
  .chart-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px; 
        }

.bar {
    width: 20%; 
    background-color: #4CAF50; 
    color: white; 
    text-align: center;
    margin: 0 5px; 
    transition: all 0.3s ease; 
    width: 35px;
    min-height: 21px;
}

.bar:hover {
    opacity: 0.8; 
}

.category-label {
    margin-top: 5px;
    margin-right : 30px;
    font-size: 12px; 
    color: #333; 
     writing-mode: vertical-lr;
    text-align: center;
}

.chart-group {
        
  display: flex;
  flex-direction: column;
   align-items: center;
    margin-right: 20px;
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
		                    <a class="nav-link  active" href="/shop/customer/orderList.jsp"> 
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
		                    <a class="nav-link" href="/shop/emp/empSchedule.jsp">
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
					<div class="col-2" style="background-color: #EBF7FF; height: 1000px; width: 250px">		
						<h2 style="margin-bottom: 30px; margin-top: 78px; margin-left: 10px;"><span class="material-symbols-outlined" style="margin-right: 10px;">quick_reorder</span>주문 내역</h2>
						
						
						<div style="margin-bottom: 50px;">
							<form method="post" action="/shop/emp/empMain.jsp">
							category :
								<select name="category">
	<% 
									if(request.getParameter("category")==null){
	%>
										<option value="">선택</option>
	<%								} else{
										for(String a : categoryList){
											if(a.equals(category)){
	%>											<option value="<%=a %>"><%=a %></option>
	<% 
											}
										}
									}
	%>
	<%							//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
									for(String c : categoryList) {
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

					</div>	

		</body>
	
</html>