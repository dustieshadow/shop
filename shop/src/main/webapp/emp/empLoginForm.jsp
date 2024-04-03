<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//인증분기 세션 변수 이름 loginEmp
System.out.println("---------------empLoginForm.jsp");

if(session.getAttribute("loginEmp") != null) {
	response.sendRedirect("/shop/emp/empList.jsp");
	return;
}

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
<title>empLoginForm</title>
<style>
	.login{
		display: flex;
		justify-content: center;
		algin-items:center;
	}

</style>
</head>
	<body style="background-color: #FFEBFE;">
	
		<form method="post" action="/shop/emp/empLoginAction.jsp">
			<div class="row">
				<div class="col"></div>
				<div>
				<div class="container col login rounded" style="background-color: #FFFFFF; width:520px; height: 1000px;">
					<div class="col-2"></div>
					<div class="col">
						<div>
							<img src="/shop/emp/img/shopicon.png" style="width: 100px; height: 100px; margin-top: 35px; margin-left: 15px;">
						</div>
						<div>
							<input type="text" class="rounded" style="width: 440px; height: 50px; margin-bottom: 15px; margin-top: 80px;" name="empId" placeholder="id를 입력해주세요">
						</div>
						<div>
							<input type="text" class="rounded" style="width: 440px; height: 50px; margin-bottom: 25px;" name="empPw" placeholder="pw를 입력해주세요">
						</div>
						<div>
							<button type="submit" class="btn btn-primary btn-block" style="width: 440px;  height: 40px; margin-bottom: 20px;">로그인</button>
						</div>
						
						<div>
							<button type="button" class="btn btn-primary btn-block" style="width: 440px;  height: 40px; margin-bottom: 15px;">회원가입</button>
						</div>
					</div>
					<div class="col-2"></div>
					</div>
				</div>
				<div class="col"></div>
			</div>
		</form>
		
	</body>
</html>