<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "shop.dao.*" %>
<%@ page import = "java.net.*" %>


<%
System.out.println("----------modifyEmpAction.jsp----------");
System.out.println("세션 ID: " + session.getId());

String msg = null;
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




System.out.println("[param]empId :" + request.getParameter("empId"));
System.out.println("[param]empName :" + request.getParameter("empName"));
System.out.println("[param]empJob :" + request.getParameter("empJob"));
System.out.println("[param]hireDate :" + request.getParameter("hireDate"));

String empId = null;
String empName = null;
String empJob = null;
String hireDate = null;

if (request.getParameter("empId") != null) {
	empId = request.getParameter("empId");
	System.out.println("empId : " + empId);
}
if (request.getParameter("empName") != null) {
	empName = request.getParameter("empName");
	System.out.println("empName : " + empName);

}

if (request.getParameter("empJob") != null) {
	empJob = request.getParameter("empJob");
	System.out.println("empJob : " + empJob);

}
if (request.getParameter("hireDate") != null) {
	hireDate = request.getParameter("hireDate");
	System.out.println("hireDate : " + hireDate);
}

int empModify = EmpDAO.empModify(empId, empName, empJob, hireDate);

if(empModify == 1){
	System.out.println("emp정보변경에 성공하였습니다.");
	msg = URLEncoder.encode("사원정보가 성공적으로 변경되었습니다.","UTF-8");
	response.sendRedirect("/shop/emp/empList.jsp?msg="+msg);
}else{
	System.out.println("emp정보변경에 실패하였습니다.");
	msg = URLEncoder.encode("사원정보 변경에 실패하였습니다.","UTF-8");
	response.sendRedirect("/shop/emp/empList.jsp?msg="+msg);
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>