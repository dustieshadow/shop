<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import= "java.net.*" %>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("---------------empMain.jsp");
	System.out.println("사원 기본 화면페이지입니다.");
	System.out.println("세션 ID: " + session.getId());
	System.out.println("[param]category :"+request.getParameter("category"));
	
	
	String category = null;
	int currentPage = 1;
	int totalPage = 1;
	int rowPerPage = 6;
	String msg = null;
	
	if(request.getParameter("category")!= null){
		category = request.getParameter("category");
		System.out.println("category : "+category);
	}
	
	

	
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
	
	ArrayList<HashMap<String,Object>> selectGroupByCategory = GoodsDAO.selectGroupByCategory();
	ArrayList<String> categoryList = GoodsDAO.categoryList();
	
	ArrayList<HashMap<String,Object>> chartGoodsListCategory = null;
	ArrayList<HashMap<String,Object>> selectGroupByCategoryGoodsAmount = GoodsDAO.selectGroupByCategoryGoodsAmount();
	
	if(request.getParameter("category")!=null){
		
	
	chartGoodsListCategory = GoodsDAO.chartGoodsListCategory(category);
	System.out.println("chartGoodsListCategory : "+ chartGoodsListCategory );
	}

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

.bar2 {
    width: 20%; 
    background-color: #ff5e5e; 
    color: white;
    text-align: center;
    margin: 0 5px; 
    transition: all 0.3s ease; 
    width: 35px;
    min-height: 21px;
    font-size: 13px;
    
}

.bar3 {
    width: 20%; 
    background-color: #c2d8ff; 
    color: #373f5c; 
    text-align: center;
    margin: 0 5px; 
    transition: all 0.3s ease; 
    width: 35px;
    min-height: 21px;
    font-size: 13px;
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

pricefont{
	color : black;
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
					<div class="col-2" style="background-color: #EBF7FF; height: 1000px; width: 250px">		
						<h2 style="margin-bottom: 30px; margin-top: 78px; margin-left: 10px;"><span class="material-symbols-outlined" style="margin-right: 10px;">monitoring</span>메인 차트</h2>
						
						
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
		    
		    
		    
		    <%
		    if(category == null || category.equals("")){
		    	
		    	
		    	int maxAmount = 0;
		    	int maxPrice = 0;
		    	int maxQuantity = 0;
		    	
		    	
		    	for (HashMap<String,Object> goodsAmountChart : selectGroupByCategoryGoodsAmount) {
		    		int currentAmount = (Integer) goodsAmountChart.get("goodsAmount");
	
		    		if (currentAmount > maxAmount) {
		    			maxAmount = currentAmount;
		    			System.out.println("maxAmount : "+maxAmount);
		    		}    			
		    	} 
		    	
		    	for (HashMap<String,Object> goodsAmountChart : selectGroupByCategory) {
		    
		    		int currentPrice = (Integer) goodsAmountChart.get("totalPrice");
		    		int currentQuantity = (Integer) goodsAmountChart.get("orderQuantity");
		    		
		    		System.out.println("currentQuantity : "+currentQuantity);
		    		System.out.println("maxQuantity : "+maxQuantity);
		    		
		    	
		    		if(currentPrice > maxPrice){
		    			maxPrice = currentPrice;
		    			System.out.println("maxPrice : "+maxPrice);
		    		}
		    		if(currentQuantity > maxQuantity){
		    			maxQuantity = currentQuantity;
		    			System.out.println("maxQuantity : "+maxQuantity);
		    		}
		    			
		    	} 
%>								
								<div class="col">
								<div style="display: flex; justify-content: center;">
								   <div class="chart-wrapper">
        <div class="chart-title">품목별 재고수량 차트</div>
        <div class="chart-container" style="margin-top: 10px;">
            <% 
            
            
            
            for (HashMap<String,Object> goodsAmountChart : selectGroupByCategoryGoodsAmount) {
                int goodsAmount = (Integer) goodsAmountChart.get("goodsAmount");
                String categoryName = (String) goodsAmountChart.get("category");
                double maxHeight = (double) goodsAmount / maxAmount * 100;
            %>
            <div class="bar" style="height:<%=maxHeight%>%;"><%=goodsAmount%></div>
            <div class="category-label"><%=categoryName%></div>
            <% } %>
        </div>
    </div>
    
    					   <div class="chart-wrapper">
        <div class="chart-title">품목별 총매출 차트(만원)</div>
        <div class="chart-container " style="margin-top: 10px;">
            <% for (HashMap<String,Object> goodsAmountChart : selectGroupByCategory) {
                int totalPrice = (Integer) goodsAmountChart.get("totalPrice");
                String categoryName = (String) goodsAmountChart.get("category");
                double maxHeight = (double) totalPrice / maxPrice * 100;
                String priceWon = Integer.toString(totalPrice);
                int newLength = priceWon.length() - 4;
           		String truncatedStr = priceWon.substring(0, newLength);
                
            %>
            <div class="bar2	" style="height:<%=maxHeight%>%;" ><%=truncatedStr%></div>
            <div class="category-label"><%=categoryName%></div>
            <% } %>
        </div>
    </div>
    </div>
    
    
      <div class="chart-wrapper">
        <div class="chart-title">품목별 총주문량 차트</div>
        <div class="chart-container " style="margin-top: 10px;">
            <% for (HashMap<String,Object> goodsAmountChart : selectGroupByCategory) {
                int orderQuantity = (Integer) goodsAmountChart.get("orderQuantity");
                String categoryName = (String) goodsAmountChart.get("category");
                double maxHeight = (double) orderQuantity / maxQuantity * 100;
          
                
            %>
            <div class="bar3" style="height:<%=maxHeight%>%;" ><%=orderQuantity%></div>
            <div class="category-label"><%=categoryName%></div>
            <% } %>
        </div>
    </div>
    </div>
    
    
    <%}else{
    	
    	int maxAmount = 0;
    	int maxPrice = 0;
    	int maxQuantity = 0;
    	
    	for (HashMap<String,Object> goodsAmountChart : chartGoodsListCategory) {
    		int currentAmount = (Integer) goodsAmountChart.get("goodsAmount");
    		int currentPrice = (Integer) goodsAmountChart.get("totalPrice");
    		int currentQuantity = (Integer) goodsAmountChart.get("orderQuantity");
    		
    		System.out.println("currentQuantity : "+currentQuantity);
    		System.out.println("maxQuantity : "+maxQuantity);
    		
    		if (currentAmount > maxAmount) {
    			maxAmount = currentAmount;
    			System.out.println("maxAmount : "+maxAmount);
    		}
    		if(currentPrice > maxPrice){
    			maxPrice = currentPrice;
    			System.out.println("maxPrice : "+maxPrice);
    		}
    		if(currentQuantity > maxQuantity){
    			maxQuantity = currentQuantity;
    			System.out.println("maxQuantity : "+maxQuantity);
    		}
    			
    	} 
    	
    	
   
    	
			%>	<div class="col">
				<div style="display: flex; justify-content: center;">
				   <div class="chart-wrapper">
		<div class="chart-title"><%=category %> 재고수량 차트</div>
		<div class="chart-container" style="margin-top: 10px;">
		<% 
		
		
		
		for (HashMap<String,Object> goodsAmountChart : chartGoodsListCategory) {
		
			
		int goodsAmount = (Integer) goodsAmountChart.get("goodsAmount");
		String goodsName = (String) goodsAmountChart.get("goodsTitle");
		double maxHeight = (double) goodsAmount / maxAmount * 100;
		%>
		<div class="bar" style="height:<%=maxHeight%>%;"><%=goodsAmount%></div>
		<div class="category-label"><%=goodsName%></div>
		<% } %>
		</div>
		</div>
		
		   <div class="chart-wrapper">
		<div class="chart-title"><%=category %> 총매출 차트(만원)</div>
		<div class="chart-container " style="margin-top: 10px;">
		<% for (HashMap<String,Object> goodsAmountChart : chartGoodsListCategory) {
		 
		int totalPrice = (Integer) goodsAmountChart.get("totalPrice");
		String goodsName = (String) goodsAmountChart.get("goodsTitle");
		double maxHeight = (double) totalPrice / maxPrice * 100;
		String priceWon = Integer.toString(totalPrice);
		int newLength = priceWon.length() - 4;
		String truncatedStr = priceWon.substring(0, newLength);
		
		%>
		<div class="bar2	" style="height:<%=maxHeight%>%;" ><%=truncatedStr%></div>
		<div class="category-label"><%=goodsName%></div>
		<% } %>
		</div>
		</div>
		</div>
		
		
		<div class="chart-wrapper">
		<div class="chart-title"><%=category %> 총주문량 차트</div>
		<div class="chart-container " style="margin-top: 10px;">
		<% for (HashMap<String,Object> goodsAmountChart : chartGoodsListCategory) {
		 
		int orderQuantity = (Integer) goodsAmountChart.get("orderQuantity");
		String goodsName = (String) goodsAmountChart.get("goodsTitle");
		double maxHeight = (double) orderQuantity / maxQuantity * 100;
		
		
		%>
		<div class="bar3" style="height:<%=maxHeight%>%;" ><%=orderQuantity%></div>
		<div class="category-label"><%=goodsName%></div>
		<% } %>
		</div>
		</div>
		</div>

    	

    <%  } %>
		</body>
	
</html>