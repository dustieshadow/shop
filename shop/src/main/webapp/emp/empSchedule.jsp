<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>

<%
System.out.println("----------empSchedule.jsp----------");

//memberId,msg 변수관리
String memberId = request.getParameter("memberId");
String msg = request.getParameter("msg");
System.out.println("memberId : " + memberId);
System.out.println("msg : " + msg);


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


//달력 관련 로직
//targetYear == 달력 페이지 넘길때 받는 년도값, targetMonth == 달력 페이지 넘길때 받는 월값
String targetYear = request.getParameter("targetYear");
String targetMonth = request.getParameter("targetMonth");

System.out.println("targetYear : " + targetYear);
System.out.println("targetMonth : " + targetMonth);
//Calendar 함수 사용
//target == 선택날짜 추출 , today == 오늘날짜 추출 , beforeMonth==지난달 추출, afterMonth == 다음달 추출
Calendar target = Calendar.getInstance();
Calendar today = Calendar.getInstance();
Calendar beforeMonth = Calendar.getInstance();
Calendar afterMonth = Calendar.getInstance();

//최초 페이지 진입시 타겟변수에 디폴트 캘린더값 주입
if (targetYear != null && targetMonth != null) {
	target.set(Calendar.YEAR, Integer.parseInt(targetYear));
	target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
}
//요일날짜 추출용도 date 1일로 초기화
target.set(Calendar.DATE, 1);

//tYear, tMonth, yoNum변수에 타겟날짜 주입
int tYear = target.get(Calendar.YEAR);
int tMonth = target.get(Calendar.MONTH);
int yoNum = target.get(Calendar.DAY_OF_WEEK);

System.out.println("tYear : " + tYear);
System.out.println("tMonth : " + tMonth);
System.out.println("yoNum : " + yoNum);

//달력 앞 공백칸 데이터 설정
int startBlank = yoNum - 1;
//해당 달의 마지막 날짜 주입
int lastDate = target.getActualMaximum(Calendar.DATE);
//오늘 date 추출
int todayDate = today.get(Calendar.DATE);

int lastBlank = 0;
//lastBlank(다음달 배정블록) 값 배당 로직
if ((startBlank + lastDate + lastBlank) % 7 != 0) {

	lastBlank = 7 - (startBlank + lastDate + lastBlank) % 7;
}

//countDiv == 달력 날짜(div)생성갯수 설정
int countDiv = startBlank + lastDate + lastBlank;

//지난달
beforeMonth.set(Calendar.DATE, 1);
//지난달 월 값 추출
beforeMonth.set(Calendar.MONTH, tMonth - 1);
//지난달 날짜 최대값 추출
int beforeMonthLastDate = beforeMonth.getActualMaximum(Calendar.DATE);
//다음달 시작날짜
int afterMonthStartDate = 1;

//오늘 달 구하기
int todayMonth = today.get(Calendar.MONTH);
int todayYear = today.get(Calendar.YEAR);

// 디버깅
System.out.println("---------");
System.out.println("lastBlank : " + lastBlank);
System.out.println("todayMonth : " + todayMonth);
System.out.println("todayYear : " + todayYear);
System.out.println("yoNum : " + yoNum);
System.out.println("todayDate : " + todayDate);
System.out.println("targetYear : " + targetYear);
System.out.println("targetMonth : " + targetMonth);
System.out.println("target : " + target);
System.out.println("tYear : " + tYear);
System.out.println("tMonth : " + tMonth);
System.out.println("lastDate : " + lastDate);
System.out.println("countDiv : " + countDiv);
System.out.println("startBlank : " + startBlank);



ArrayList<String> arrDiaryDate = new ArrayList<>();

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




a {
	text-decoration: none;
	color: black;
}

a:link {
	text-decoration: none;
}

a:active {
	
}

a:visited {
	
}

a:hover {
	font-weight: bold;
}

.floatLeft {
	float: left;
	
}

.red {
	background-color: blue;
}

.floatClear {
	clear: both;
	color: blue;
}
.memo{
	/*background-image: */
	background-size: cover;
}


.floatLeft a {
    display: block;
    width: 100px;; 
    height: 100px; 
    text-align: center;
    line-height: 50px; 
    border: 1px solid #849ec2;
    background-color: #fff;
    color: #333;
    text-decoration: none; 
}

.floatLeft a.red {
    background-color: #ffebee; 
    color: red; 
}

.floatLeft a.blue {
    background-color: #e3f2fd; 
    color: blue; 
}

.floatLeft a.today {
    background-color: #b5c9e8; 
}

.floatLeft a.yo {
    display: block;
    width: 100px;; 
    height: 40px; 
    text-align: center;
    line-height: 40px; 
    border: 1px solid #748cad;
    background-color: #fff;
    color: #333;
    text-decoration: none;
 
}


</style>
<title>empSchedule</title>
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
		                    <a class="nav-link active" href="/shop/emp/empSchedule.jsp">
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
		    
		    


	<!-- 처음 페이지 진입시 분기 -->
	<%
	if (targetYear == null && targetMonth == null) {
	%>

	<div>
		<%=tYear%>년
		<%=tMonth + 1%>월
	</div>
	<% //페이지를 넘겼을 때 분기
	} else {
	%>
	<%=tYear%>년
	<%=tMonth + 1%>월
	<%
	}
	%>


	<h1><%=empName%>님의 일정표
	</h1>


	
	<div class="floatClear floatLeft">
	<a class="yo">SUN</a>
	</div>
	<div class="floatLeft">
	<a class="yo">MON</a>
	</div>
	<div class="floatLeft">
	<a class="yo">TUE</a>
	</div>
	<div class="floatLeft">
	<a class="yo">WED</a>
	</div>
	<div class="floatLeft">
	<a class="yo">THI</a>
	</div>
	<div class="floatLeft">
	<a class="yo">FRI</a>
	</div>
	<div class="floatLeft">
	<a class="yo">SAT</a>
	</div>




	<%
	String refDiaryDate = null;
	String tMonthString = null;
	String tDateString = null;
	
	//최외곽 for문
	for (int i = 1; i <= countDiv; i++) {

		//일요일 마다 floatClear 진행하는 분기
		if (i % 7 == 1) {
	%>


		<div class="floatLeft floatClear" style="color: red;">
	<%	//평일 float분기
		} else {
	%>
		<div class="floatLeft">
	<%
		}

			// 이번달
				
				if (i - startBlank > 0 && i - startBlank <= lastDate) {
						//int tMonth를 String 변수로 형변환
						if (tMonth < 9) {
							tMonthString = "0" + Integer.toString(tMonth + 1);
						} else {
							tMonthString = Integer.toString(tMonth);
						}
						//int 해당날짜를 String 변수로 형변환
						if (i - startBlank < 10) {
							tDateString = "0" + Integer.toString(i - startBlank);
						} else {
							tDateString = Integer.toString(i - startBlank);
						}
						// String 날짜데이터
						refDiaryDate = tYear + tMonthString + tDateString;				
						
						System.out.println(tYear + "-" + tMonthString + "-" + tDateString);
						
						//선택된 날짜가 메모가 '있다면'
						if (arrDiaryDate.contains(tYear + "-" + tMonthString + "-" + tDateString)) {
							System.out.println("----메모가 있습니다.");
							//'오늘'이라면-선택된 날이 '오늘'인지 확인하는 분기
							if (todayDate == i - startBlank && (todayMonth + 1) == tMonth && todayYear == tYear) {
	%>								<div class="floatLeft">
									<a class="today memo" 
									href="/shop/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=i - startBlank%></a>
									</div>
	<%
							//'오늘'이 아니라면
							} else {
								//선택된 날이 '일요일'인지 확인하는 분기
								if (i % 7 == 1) {
									
	%>								<div class="floatLeft">
									<a class="memo" href="/shop/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
									style="color: red;"><%=i - startBlank%></a>
									</div>
	<%							//선택된 날이 '토요일'인지 확인하는 분기
								} else if (i % 7 == 0) {
									
	%>								<div class="floatLeft">
									<a class="memo" href="/shop/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
									style="color: blue;"><%=i - startBlank%></a>
									</div>
	<%
								}
								//평일일때
								else {
	%>							<div class="floatLeft">	
								<a class="memo" href="/shop/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=i - startBlank%></a>
								</div>
	<%
								}
							}
							
						//선택된 날에 메모가 '없다면'
						}else{
							
							//'오늘'이라면-선택된 날이 '오늘'인지 확인하는 분기
							if (todayDate == i - startBlank && (todayMonth + 1) == tMonth && todayYear == tYear) {
	%>							<div class="floatLeft">
									<a class="today article"
									href="/shop/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=i - startBlank%></a>
								</div>
	<%						//'오늘'이 아니라면
							} else {
								//선택된 날이 '일요일'인지 확인하는 분기
								if (i % 7 == 1) {
								
	%>								<div class="floatLeft">
										<a class="today article" href="/shop/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
										style="color: red;"><%=i - startBlank%></a>
									</div>
	<%							//선택된 날이 '토요일'인지 확인하는 분기
								} else if (i % 7 == 0) {
	%>								<div class="floatLeft">
										<a class="today article" href="/shop/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
										style="color: blue;"><%=i - startBlank%></a>
									</div>
	<%
								}
								//평일일때
								else {
	%>							<div class="floatLeft">
									<a class="today article" href="/shop/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=i - startBlank%></a>
								</div>
	<%
								}
							}
							
						
						}
			
				//이전달
				} else if (i - startBlank <= 0) {
						//int tMonth를 String 변수로 형변환
						if (tMonth < 9) {
						tMonthString = "0" + Integer.toString(tMonth);
			
						} else {
						tMonthString = Integer.toString(tMonth);
						}
						//int 해당날짜를 String 변수로 형변환
						if (beforeMonthLastDate - startBlank + i < 10) {
						tDateString = "0" + Integer.toString(beforeMonthLastDate - startBlank + i);
			
						} else {
						tDateString = Integer.toString(beforeMonthLastDate - startBlank + i);
						}
						// 전송할 String 날짜데이터
						refDiaryDate = tYear + tMonthString + tDateString;
						
						System.out.println(tYear + "-" + tMonthString + "-" + tDateString);
						
						//선택된 날짜가 메모가 '있다면'
						if (arrDiaryDate.contains(tYear + "-" + tMonthString + "-" + tDateString)) {
							System.out.println("----메모가 있습니다.");
								
							//'오늘'이라면-선택된 날이 '오늘'인지 확인하는 분기
							if (todayDate == beforeMonthLastDate - startBlank + i && (todayMonth + 1) == tMonth && todayYear == tYear) {
	%>						<a class="memo today"
								href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=beforeMonthLastDate - startBlank + i%></a>
	<%						//'오늘'이 아니라면
							} else {
								//선택된 날이 '일요일'인지 확인하는 분기
								if (i % 7 == 1) {
	%>							<a class="memo" href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
									style="color: red;"><%=beforeMonthLastDate - startBlank + i%></a>
	<%
								}
								//평일일때
								else {
	%>							<a class="memo" href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=beforeMonthLastDate - startBlank + i%></a>
	<%
								}
				
							}
						
						//선택된 날에 메모가 '없다면'
						} else {
							//'오늘'이라면-선택된 날이 '오늘'인지 확인하는 분기
							if (todayDate == beforeMonthLastDate - startBlank + i && (todayMonth + 1) == tMonth && todayYear == tYear) {
	%>								<a class="today"
									href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=beforeMonthLastDate - startBlank + i%></a>
	<%						//'오늘'이 아니라면
							} else {
									//선택된 날이 '일요일'인지 확인하는 분기
									if (i % 7 == 1) {
	%>									<a href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
										style="color: red;"><%=beforeMonthLastDate - startBlank + i%></a>
	<%
									}
									
				
									//평일일때
									else {
									%><a href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=beforeMonthLastDate - startBlank + i%></a>
									<%
									}
					
							}
				
						}

				//다음달
				} else {
							//int tMonth를 String 변수로 형변환
						if (tMonth < 9) {
							tMonthString = "0" + Integer.toString(tMonth + 2);
				
						} else {
							tMonthString = Integer.toString(tMonth);
						}
				
						tDateString = "0" + Integer.toString(afterMonthStartDate);
						// diaryOne으로 전송할 String 날짜데이터
						refDiaryDate = tYear + tMonthString + tDateString;
				
						System.out.println(tYear + "-" + tMonthString + "-" + tDateString);
						//선택된 날짜가 메모가 '있다면'
						if (arrDiaryDate.contains(tYear + "-" + tMonthString + "-" + tDateString)) {
							System.out.println("----메모가 있습니다.");
								//'오늘'이라면-선택된 날이 '오늘'인지 확인하는 분기
								if (todayDate == afterMonthStartDate + 1 && (todayMonth + 1) == tMonth && todayYear == tYear) {
	%>							<a class="today memo"
									href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=afterMonthStartDate++%></a>
	<%							//'오늘'이 아니라면
								} else {
								//선택된 날이 '일요일'인지 확인하는 분기
									if (i % 7 == 1) {
	%>									<a class="memo" href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
										style="color: red;"><%=afterMonthStartDate++%></a>
	<%							//선택된 날이 '토요일'인지 확인하는 분기
									} else if (i % 7 == 0) {
	%>									<a class="memo" href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
										style="color: blue;"><%=afterMonthStartDate++%></a>
	<%
									}
									//평일일때
									else {
	%>									<a class="memo" href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=afterMonthStartDate++%></a>
	<%
									}
								}
					
						//선택된 날에 메모가 '없다면'
						} else {
								//'오늘'이라면-선택된 날이 '오늘'인지 확인하는 분기
								if (todayDate == afterMonthStartDate + 1 && (todayMonth + 1) == tMonth && todayYear == tYear) {
	%>								<a class="today"
									href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=afterMonthStartDate++%></a>
	<%							//오늘이 아니라면
								} else {
									//선택된 날이 '일요일'인지 확인하는 분기
									if (i % 7 == 1) {
	%>								<a href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
										style="color: red;"><%=afterMonthStartDate++%></a>
	<%								//선택된 날이 '토요일'인지 확인하는 분기
									} else if (i % 7 == 0) {
	%>								<a href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"
										style="color: blue;"><%=afterMonthStartDate++%></a>
	<%
									}
									//평일일때
									else {
	%>								<a href="/shop/emp/empSchedule.jsp?diaryDate=<%=refDiaryDate%>"><%=afterMonthStartDate++%></a>
	<%
									}
								}
							
								
							}
				}
			%>
		</div>
	</div>
	<%
	}
	%>



	<div class="floatClear floatLeft">
		<a class="yo"
			href="/shop/emp/empSchedule.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth - 1%> ">이전달</a>
	</div>
	<div class="floatLeft">
		<a class="yo"
			href="/shop/emp/empSchedule.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth + 1%>">다음달</a>
	</div>
	

</body>


</html>