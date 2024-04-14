<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>

<%
	System.out.println("----------addMemberForm.jsp---------");

	System.out.println("[param] type : "+request.getParameter("type"));
	
	String type = null;
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
    	
    
</style>
</head>
		<body>
			<div class="container border rounded">
			
				
				 <div class="article border-bottom row"  style="position: relative; left: 11px;">
				 	<div class="col-3">
				 		<span style="margin-left: 10px;">
				 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person</span>
				 			<span class="text">아이디</span>
				 		</span>
				 	</div>
				 	<div class="col-9 border-left">
				 	<input type="text" class="input-field" placeholder="Email address" style="font-style: italic;">
				 	</div> 	
				 </div>
				 	
				 	 <div class="article border-bottom2 row"  style="position: relative; left: 11px;">
				 	<div class="col-3">
				 		<span style="margin-left: 10px;">
				 			<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">lock</span>
				 			<span class="text">비밀번호</span>
				 		</span>
				 	</div>
				 	<div class="col-9 border-left">
				 	  <input type="password" class="input-field" placeholder="Password" style="font-style: italic;">
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
				 	<input type="text" class="input-field" placeholder="Name" style="font-style: italic;">
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
				 	  <input type="password" class="input-field" placeholder="Date of Birth" style="font-style: italic;">
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
				 	  <input type="password" class="input-field" placeholder="Gender" style="font-style: italic;">
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
				 	  <input type="password" class="input-field" placeholder="Phone number" style="font-style: italic;">
				 	</div> 	
				 </div>
				 
			 </div>	
			 <div style="margin-top : 500px; background-color: green; width: 550px; height: 50px; display: flex; justify-content: center; align-items: center; margin-left: auto; margin-right: auto;"" >
			 	<div>center</div>
			 
			 
			 </div>
		
				
		
		</body>
</html>