<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import ="java.net.*" %>

<%

System.out.println("---------------loginForm.jsp");

//인증분기 세션 변수 이름 loginEmp
//if(session.getAttribute("loginEmp") != null) {
	//response.sendRedirect("/shop/emp/empMain.jsp");
	//return;
//}
//로그인 화면에서 받을 에러메세지 변수생성
String errMsg = null;

if(request.getParameter("errMsg")!=null){
	errMsg = request.getParameter("errMsg");
}

System.out.println("로그인 액션에서 넘겨받은 errMsg값 : "+request.getParameter("errMsg"));


%>

<!DOCTYPE html>
<html>
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Gowun+Batang:wght@400;700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Chakra+Petch:ital,wght@0,300;1,700&display=swap" rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Chakra+Petch:ital,wght@0,300;1,700&family=Rajdhani:wght@500&display=swap" rel="stylesheet">

<title>loginForm</title>
<style>

	.container{
	display: flex;
	
	flex-direction : column;
	width: 550px; 
	height: 115px; 
	margin-top: 120px; 
	padding: 0;
	box-shadow: 0 0 10px rgba(0,0,0,0.1);
	}

.article {
    display: flex;
    align-items: center;
    height: 100px;
    width: 100%;
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
        border-left: 1px solid #FFFFFF;
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
    	
    	
    .rounded-container {
        border: 1px solid light; 
        border-radius: 8px; 
        background-color: white; 
        width: 600px;
        height: 300px;
        padding: 20px; 
        box-shadow: 0 0 10px rgba(0,0,0,0.1); 
    }

.homepluss a, .homepluss a:visited, .homepluss a:hover, .homepluss a:active
	{
	display:flex;
	justify-content : center;
	font-family: "Black Han Sans", sans-serif;
	font-weight: 400;
	font-style: normal;
	font-size: 38px;
	color: #262b33;
	text-decoration: none;
	margin-top: 30px;
}


.chakra-petch-light {
  font-family: "Chakra Petch", sans-serif;
  font-weight: 300;
  font-style: normal;
}

.chakra-petch-bold-italic {
  font-family: "Chakra Petch", sans-serif;
  font-weight: 700;
  font-style: italic;
}

.rajdhani-medium {
  font-family: "Rajdhani", sans-serif;
  font-weight: 500;
  font-style: normal;
}



</style>
</head>
	<body>
		
		<div class="homepluss" style="margin-top: 100px;">
				<a href="">HomePluss Inc.</a>
			</div>
		<div style="display: flex; align-items: center; justify-content: center; margin-top: 100px;">
			<div class="rounded-container"   style="width: 600px; height: 300px; ">
				<div class="container border rounded" style="margin-top: 10px;">
					<div class="article border-bottom row"  style="position: relative; left: 11px;">
						<div class="col-3">
							<span style="margin-left: 10px;">
						 		<span class="material-symbols-outlined icon p-0" style="margin-right: 4px;">person</span>
						 		<span class="text">아이디</span>
						 	</span>
						</div>
						<div class="col border-left">
							<input name = "memberId" type="text" class="input-field" placeholder="Email address" style="font-style: italic;" required>
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
							<input name ="empPw" type="password" class="input-field" placeholder="Password" style="font-style: italic;" required>
						</div> 	
					</div>
				</div>
				<div style="display: flex; justify-content: center; margin-top: 20px;" >
			<div>
				<a href="" class="btn btn-basic rajdhani-medium" style="margin-right: 1px; width: 270px; font-style: italic; color: #626670; " >Customer</a>
			</div>
			<div>
				<a href="" class="btn btn-basic rajdhani-medium" style="margin-left: 1px; width: 270px; font-style: italic; color: #626670;">Employee</a>
			</div>	
		</div>
					<button class="rounded" style="font-weight:bold;  font-size:25px;  border :  1px solid grey;  margin-top : 20px; background-color: #32a852; width: 550px; height: 60px; display: flex; justify-content: center; align-items: center; margin-left: auto; margin-right: auto;" >
						<div style="color: white;">로그인</div>
					</button>
			</div>			
		</div>
	</body>
</html>