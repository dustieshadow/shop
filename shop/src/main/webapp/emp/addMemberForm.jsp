<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>

<%
	System.out.println("----------addMemberForm.jsp---------");
	System.out.println("세션 ID: " + session.getId());
	System.out.println("[param] type : "+request.getParameter("type"));
	
	String memberId = null;
	String msg = null;
	String type = null;
	
	System.out.println("[param]중복확인 memberId : "+request.getParameter("memberId"));
	System.out.println("[param] msg : "+request.getParameter("msg"));
	System.out.println("[param] type : "+request.getParameter("type"));
	
	if(request.getParameter("memberId")!=null){
		memberId = request.getParameter("memberId");
	}
	
	if(request.getParameter("msg")!=null){
		msg = request.getParameter("msg");
	}
	
	
	if(request.getParameter("type")!= null){
		type = request.getParameter("type");
		System.out.println("type : "+ type);
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
<style>
	.container{
	display: flex;
	
	flex-direction : column;
	width: 550px; 
	height: 100px; 
	margin-top: 120px; 
	padding: 0;
	
	}

	.article{
	display : flex;
	align-items: center;
	height: 50px;"
	width:100px;
	
	}
	
	.border-bottom{
	border-bottom: 1px solid;
    width: 100%;
	}
	
	.icon{
	position: relative;
	top:3px;
	}
	.text{
	position: relative;
	bottom: 3px;
	
	}
	
	.border-left {
        border-left: 1px solid #c9c9c9;
        height: 100%;
        }
    .border-bottom2{
    border-bottom: 1px solid trasparent;
    width: 100%;
    }
    
       .input-field {
        height: 100%;
        width: 100%;
        border: none;
        padding: 0 13px;
     
    }
    	.input-field:active{
    	  border: 1px solid black;
    	}
    	
    	button {
text-decoration: none;
color: #a6a6a6;
}

button:hover {
    background-color: #d9e9fc;
 
}


button:active {
    color: #2b2d36;
 
}
    	
    	
    	
  
</style>
</head>
		<body>
			<div>
				<a href="/shop/emp/addMemberForm.jsp?type=customer">고객</a>
			</div>
			<div>
				<a href="/shop/emp/addMemberForm.jsp?type=employee">사원</a>
			</div>	
		
		
			<%=msg %>
		
			<%
				if(type == null || type.equals("customer")){
					
					
				
			%>
		
			<form method="post" action="/shop/customer/customerCheckId.jsp">
				<div class="container border rounded">
					
					 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person</span>
					 			<span class="text">아이디</span>
					 		</span>
					 	</div>
				
	 	
					 	<div class="col-7 border-left">
					 	<input name = "memberId" type="text" class="input-field" placeholder="Email address" style="font-style: italic;">
					 	</div>
						<div class="col-2 border-left" style="padding-left: 0px; padding-right: 0px;">
					 		<button type="submit" style="background-color: #32a852; width: 100%; height: 100%;">중복확인</button>
					 	
					 	</div>
					 </div>
					  
					 	<input type="hidden" name = type value="customer">
					</form>
					
					<form method="post" action="/shop/emp/addMemberAction.jsp">
						<input type="hidden" name="type" value="customer">
						<input type="hidden" name="memberId" value="<%=memberId%>">
					 	 <div class="article border-bottom2 row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">lock</span>
					 			<span class="text">비밀번호</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name ="memberPw" type="password" class="input-field" placeholder="Password" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
				
					 	
				
				 
				 </div>
					
						<div class="container border rounded" style="margin-top: 10px; height: 200px; ">
				
					
					 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person_pin</span>
					 			<span class="text">이름</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	<input name="memberName" type="text" class="input-field" placeholder="Name" style="font-style: italic;">
					 	</div> 	
					 </div>
					 	
					 	 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">calendar_clock</span>
					 			<span class="text">생년월일</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name="memberBirthDate" type="text" class="input-field" placeholder="Date of Birth" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
					  	 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">wc</span>
					 			<span class="text">성별</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name="memberGender" type="text" class="input-field" placeholder="Gender" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
					  	 <div class="article border-bottom2 row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">phone_iphone</span>
					 			<span class="text">전화번호</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name="memberPhone" type="text" class="input-field" placeholder="Phone number" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
				 </div>
				 
				  <button class="rounded" style="margin-top : 430px; background-color: #32a852; width: 550px; height: 50px; display: flex; justify-content: center; align-items: center; margin-left: auto; margin-right: auto;" >
				 	<div>회원가입</div>
				 
				 
				 </button>
				 
				 <%
				} else if(type.equals("employee")){
					
					if(memberId==null){
						
					
				 %>
				
				<form method="post" action="/shop/emp/empCheckId.jsp">
				<div class="container border rounded">
					<input type="hidden" name="type" value="employee">
					
					 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person</span>
					 			<span class="text">아이디</span>
					 		</span>
					 	</div>
					 	<div class="col-7 border-left">
					 	<input name = "memberId" type="text" class="input-field" placeholder="Email address" style="font-style: italic;">
					 	</div>
					 	<div class="col-2 border-left"  style="padding-left: 0px; padding-right: 0px;">
					 	<button type="submit" style=" width: 100%; height: 100%; background-color: #32a852;">중복확인</button>
					 	</div>
					 </div>
					 	</form>
					 	<form method="post" action="/shop/emp/addMemberAction.jsp">
					 	
					 	 <div class="article border-bottom2 row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">lock</span>
					 			<span class="text">비밀번호</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name ="empPw" type="password" class="input-field" placeholder="Password" style="font-style: italic;">
					 	</div> 	
					 </div>

				 </div>
					
						<div class="container border rounded" style="margin-top: 10px; height: 150px; ">
				<input type="hidden" name="type" value="employee">
					
					 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person_pin</span>
					 			<span class="text">성명</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	<input name="empName" type="text" class="input-field" placeholder="Name" style="font-style: italic;">
					 	</div> 	
					 </div>
					 	
					 	 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">home_work</span>
					 			<span class="text">부서</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name="empJob" type="text" class="input-field" placeholder="Date of Birth" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
					  	 <div class="article border-bottom2 row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person_apron</span>
					 			<span class="text">입사날짜</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name="hireDate" type="text" class="input-field" placeholder="Gender" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
					  
				 </div>
				
				<%} else if(memberId != null){
					
					%>
					
					<form method="post" action="/shop/emp/empCheckId.jsp">
				<div class="container border rounded">
					<input type="hidden" name="type" value="employee">
					
					 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person</span>
					 			<span class="text">아이디</span>
					 		</span>
					 	</div>
					 	<div class="col-7 border-left">
					 	<input name = "empId" type="text" class="input-field" placeholder="Email address" style="font-style: italic;" value="<%=memberId%>">
					 	
					 	</div>
					 	<div class="col-2 border-left p-0" style="padding-left: 0px;">
					 	<button type="submit" style=" width: 100%; height: 100%; background-color: #32a852;">중복확인</button>
					 	
					 	</div>
					 </div>
					 	</form>
					 	<form method="post" action="/shop/emp/addMemberAction.jsp">
					 	<input type="hidden" name = "empId" value="<%=memberId %>">
					 	
					 	 <div class="article border-bottom2 row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">lock</span>
					 			<span class="text">비밀번호</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name ="empPw" type="password" class="input-field" placeholder="Password" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
				
					 	
				
				 
				 </div>
					
						<div class="container border rounded" style="margin-top: 10px; height: 150px; ">
				<input type="hidden" name="type" value="employee">
					
					 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person_pin</span>
					 			<span class="text">성명</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	<input name="empName" type="text" class="input-field" placeholder="Name" style="font-style: italic;">
					 	</div> 	
					 </div>
					 	
					 	 <div class="article border-bottom row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">home_work</span>
					 			<span class="text">부서</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name="empJob" type="text" class="input-field" placeholder="Date of Birth" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
					  	 <div class="article border-bottom2 row"  style="position: relative; left: 11px;">
					 	<div class="col-3">
					 		<span style="margin-left: 10px;">
					 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person_apron</span>
					 			<span class="text">입사날짜</span>
					 		</span>
					 	</div>
					 	<div class="col-9 border-left">
					 	  <input name="hireDate" type="text" class="input-field" placeholder="Gender" style="font-style: italic;">
					 	</div> 	
					 </div>
					 
					  
					  
					
					  
					  
				 </div>
					
				
					
					<% 
					
				
				 
				 
				}
					
				  	%>
					<button class="rounded" style="margin-top : 480px; background-color: #32a852; width: 550px; height: 50px; display: flex; justify-content: center; align-items: center; margin-left: auto; margin-right: auto;" >
					 	<div>회원가입</div>
					 
					 
					 </button>
					 <%
			}
				 %>
					 
				
				
			
				
			</form>
		</body>
</html>