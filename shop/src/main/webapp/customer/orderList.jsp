<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import= "java.net.*" %>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("---------------orderList.jsp----------");
	
	System.out.println("세션 ID: " + session.getId());
	
	
	//배너 - 세션값에서 주입할 변수
	//고객
	String type = null;
	String msg = null;
	String mail = null;
	String name = null;

	//배너 - 세션값에서 주입할 변수
	//사원
	String empJob = null;
	int grade = 0;
	String admin = null;
	String gender = null;
	
	String state = null;
	/*
	//오더 리스트 상품정보
	String goodsNo = null;
	String totalPrice = null;
	String orderQuantity = null;
	String category = null;
	String filename = null;
	
	String listName = null;
	//오더리스트 주문날짜 정보
	String year = null;
	String month = null;
	String day = null;
	String hour = null;
	String minute = null;
	String goodsTitle = null;
	*/



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

	System.out.println("[param]state :"+request.getParameter("state"));
	
	/*
	if(request.getParameter("orderQuantity")!= null){
		orderQuantity = request.getParameter("orderQuantity");
		System.out.println("orderQuantity : "+orderQuantity);
	}
	
	if(request.getParameter("listName")!= null){
		listName = request.getParameter("listName");
		System.out.println("listName : "+listName);
	}
	
	if(request.getParameter("goodsTitle")!= null){
		goodsTitle = request.getParameter("goodsTitle");
		System.out.println("goodsTitle : "+goodsTitle);
	}
	
	if(request.getParameter("year")!= null){
		year = request.getParameter("year");
		System.out.println("year : "+year);
	}
	
	if(request.getParameter("month")!= null){
		month = request.getParameter("month");
		System.out.println("month : "+month);
	}
	
	if(request.getParameter("day")!= null){
		day = request.getParameter("day");
		System.out.println("day : "+day);
	}
	
	if(request.getParameter("hour")!= null){
		hour = request.getParameter("hour");
		System.out.println("hour : "+hour);
	}
	
	if(request.getParameter("minute")!= null){
		minute = request.getParameter("minute");
		System.out.println("minute : "+minute);
	}
	*/
	

	
	if(request.getParameter("msg")!= null){
		msg = request.getParameter("msg");
		System.out.println("msg : "+msg);
	}
	
	if(request.getParameter("mail")!= null){
		mail = request.getParameter("mail");
		System.out.println("mail : "+mail);
	}
	
	/*
	if(request.getParameter("goodsNo")!= null){
		goodsNo = request.getParameter("goodsNo");
		System.out.println("goodsNo : "+goodsNo);
	}
	
	
	
	if(request.getParameter("totalPrice")!= null){
		totalPrice = request.getParameter("totalPrice");
		System.out.println("totalPrice : "+totalPrice);
	}
	
	if(request.getParameter("filename")!= null){
		filename = request.getParameter("filename");
		System.out.println("filename : "+filename);
	}
	
	if(request.getParameter("state")!= null){
		state = request.getParameter("state");
		System.out.println("state : "+state);
	}
	*/
	
	
	//세션 변수 loginEmp값 받을 HashMap 변수 m 생성
	HashMap<String,Object> m = new HashMap<>();


	
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
		gender = (String)(m.get("csGender"));
		
		System.out.println(session.getAttribute("loginCs"));
		System.out.println("name : "+name);
		System.out.println("mail : "+mail);
		System.out.println("gender : "+gender);
		
	}


	//페이지 변수
	//전체행수 검색 변수설정 -------------------------
	int totalRow = 0;			//조회쿼리 전체행수
	int rowPerPage = 10; 		//페이지당 행수
	int totalPage = 1;			//전체 페이지수

	int currentPage = 1;		//현재 페이지수
	int limitStartPage = 0;		//limit쿼리 시작행

	//int startRow = (currentPage-1)*rowPerPage;

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


	
	//페이징 목록 코드
	totalRow = OrderDAO.selectCountOrders();

	//전체행수가 로우퍼페이지 수로 나눠도 나머지가 남을 때 전체페이지에 +1 해준다
	if (totalRow % rowPerPage != 0) {
		totalPage = totalRow / rowPerPage + 1;
	//전체행수가 로우퍼페이지 수에 딱 떨어지는 수일 때 전체페이지에 +1 해준다
	} else {
		totalPage = totalRow / rowPerPage;
	}

	System.out.println("[오더 테이블 전체 주문 숫자-OrderDAO.selectCountOrders()]-totalRow : "+totalRow);
	System.out.println("totalRow % rowPerPage : " + totalRow % rowPerPage);
	System.out.println("[오더리스트 최종페이지]totalPage : " + totalPage);
	
	//ArrayList<HashMap<String,Object>> selectGroupByCategory = GoodsDAO.selectGroupByCategory();
	//ArrayList<String> categoryList = GoodsDAO.categoryList();
	//ArrayList<HashMap<String,Object>> chartGoodsListCategory = GoodsDAO.chartGoodsListCategory(category);

	ArrayList<HashMap<String,Object>> selectOrderList = OrderDAO.selectOrderList(limitStartPage, rowPerPage);	
	ArrayList<HashMap<String,String>> selectOrderState = OrderDAO.selectOrderState(state);	
	ArrayList<HashMap<String,String>> selectOrderStateNull = OrderDAO.selectOrderStateNull();	
	System.out.println("selectOrderList(오더 전체목록 ArrayList<HashMap> ) :"+selectOrderList);
	System.out.println("selectOrderState(목록 조회용 오더상태 전체목록 ArrayList<HashMap> ) :"+selectOrderState);
	System.out.println("selectOrderStateNull(목록 조회용 오더상태 전체목록 ArrayList<HashMap> ) :"+selectOrderStateNull);
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


.ordercontainer{
	display: flex;
	flex-wrap: wrap;
	width: 1800px;
}

.ordercolumn{
	margin-top: 10px;
}

.orderlist{
	width: 100%;
	height: 120px;
	border-bottom: 1px solid #BDBDBD;
	
}

.orderbanner{
	width: 100%;
	height: 50px;
	background-color: #B2CCFF;
	margin-top: 10px;
	border-top: 2px solid #5D5D5D;
	border-bottom: 1px solid #8C8C8C;
}

.orderdatepayment{
	border-right: 1px solid #EAEAEA;
	height: 120px;
}

.orderdate{
	height: 60px;
	border-bottom: 1px solid #EAEAEA;
}

.orderpayment{
	height: 60px;
}


.divimg {
    margin-top: 5px;
    width: 110px; 
    height: 110px;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
}

.img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain; 
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
							<form method="post" action="/shop/customer/orderList.jsp">
							배송상태 :
								<select name="state">
	<% 
									if(request.getParameter("state")==null || state.equals("1")){
	%>
										<option value="1">선택</option>
	<%								} else{
										for(HashMap<String, String> a : selectOrderState){
											if(a.get("state").equals(state)){
	%>											<option value="<%=a.get("state") %>"><%=a.get("state") %></option>
	<% 
											}
										}
									}
	%>
	<%							//category 칼럼값이 포함된 categoryList 리스트에서 foreach문으로 출력
									for(HashMap<String, String> a : selectOrderStateNull) {
	%>
										<option value="<%=a.get("state")%>"><%=a.get("state")%></option>
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
					
					<div class="col-10">
						<div class="ordercontainer">
							
							<div class="orderbanner">
								<div class="row">
									<div class="ordercolumn col-2" style="margin-left: 130px;">결제
									</div>
									<div class="ordercolumn col-4" style="margin-left: 120px;">상품명/상품번호
									</div>
									
									<div class="ordercolumn col" style="margin-left: 120px;">주문상태
									</div>
								</div>
							</div>
							
							<div class="orderlist">
								<div class="row">
									<div class="orderdatepayment col-2">
									
										<% for(HashMap<String, Object> m2 : selectOrderList){
											%>
									
											<div class="orderdate">
												<div style="margin-left: 10px;">결제일자</div>
												<div style="margin-top:8px;  text-align: right; font-size: 20px; color: #F361A6;"><%=m2.get("year") %>-<%=m2.get("month") %>-<%=m2.get("day") %> &nbsp;<%=m2.get("hour") %>:<%=m2.get("minute") %></div>
									
											</div>
											<div class="orderpayment">
												<div style="margin-left: 10px;">결제금액</div>
												<div style="text-align: right; font-size: 25px; color: #F361A6;"><%=m2.get("totalPrice") %>원</div>
										
											</div>
									</div>
									<div class="col-3 row" style="border-right: 1px solid #EAEAEA;">
									<div class="divimg col"  style="margin-bottom: 2px;">
								    	<img class = "img" src="/shop/upload/<%=m2.get("filename") %>">
								    </div>
								    <div class="col-6" style="font-size: 15px; text-align: center; align-items: center; display: flex; color: #5c5c5c; padding-left: 0px; padding-right: 0px;">
								    <%=m2.get("goodsTitle") %>
								    </div>
								  		    
									</div>
									  <div class="orderdatepayment col-1">							
											<div class="orderdate">
												<div style="margin-left: 10px;">상품번호</div>
												<div style="margin-top:8px;  text-align: right; font-size: 20px; color: #5c5c5c;"><%=m2.get("goodsNo") %></div>
									
											</div>
											<div class="orderpayment">
											<div style="margin-left: 10px;">주문번호</div>
												<div style="text-align: right;  font-size: 20px; color: #5c5c5c;"><%=m2.get("ordersNo") %></div>
										
											</div>
									</div>
									
									<div class="col" style="display: flex; align-items: center; justify-content: space-between; padding-right: 20px;">
    									<div><span class="material-symbols-outlined btn
    									<%if(m2.get("filename").equals("결제완료")){
    										%>btn-light
    									<% }else{
    										%>btn-primary<%
    									}%>
    									  purchase-button" style="font-size: 60px;">credit_card</span>
   										<div style="margin-left: 13px;">결제완료</div>
   										</div>
   										
   										<div style="height: 2px; width: 20px; background-color: grey; margin-bottom: 20px;"></div>
   										<div>
   										<span class="material-symbols-outlined btn 
   										<%if(m2.get("filename").equals("출하지시")){
    										%>btn-light
    									<% }else{
    										%>btn-primary<%
    									}%>
   										btn-light purchase-button" style="font-size: 60px;">chat_paste_go</span>
   										<div style="margin-left: 13px;">출하지시</div>
   										</div>
   										<div style="height: 2px; width: 20px; background-color: grey; margin-bottom: 20px;"></div>
  										<div>
  										<span class="material-symbols-outlined btn 
  										<%if(m2.get("filename").equals("배송시작")){
    										%>btn-light
    									<% }else{
    										%>btn-primary<%
    									}%>
  										btn-light purchase-button" style="font-size: 60px;">conveyor_belt</span>
  										<div style="margin-left: 13px;">배송시작</div>
   										</div>
  										<div style="height: 2px; width: 20px; background-color: grey; margin-bottom: 20px;"></div>
  										<div>
  										<span class="material-symbols-outlined btn 
  										<%if(m2.get("filename").equals("배송완료")){
    										%>btn-light
    									<% }else{
    										%>btn-primary<%
    									}%>
    									btn-light purchase-button" style="font-size: 60px;">approval_delegation</span>
 										<div style="margin-left: 13px;">배송완료</div>
   										</div>
 										<div style="height: 2px; width: 20px; background-color: grey; margin-bottom: 20px;"></div>
  										<div>
  										<span class="material-symbols-outlined btn 
  										<%if(m2.get("filename").equals("구매승인")){
    										%>btn-light
    									<% }else{
    										%>btn-primary<%
    									}%>
    									btn-light purchase-button" style="font-size: 60px;">trackpad_input</span>
										<div style="margin-left: 13px;">구매승인</div>
   										</div>
									
									</div>
									
							
								</div>
							</div>
							
	<%
							} 
	%>
						
						</div>
					
		
					</div>
				</div>
		</body>
	
</html>