<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
	
	request.setCharacterEncoding("UTF-8");
	
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	//세션 설정값 : 입력시 로그인 emp의 emp_id값이 필요함
	HashMap<String,Object> loginMember = (HashMap<String,Object>)(session.getAttribute("loginEmp"));

	//Model Layer
	
	//controller Layer
	
	//response.sendRedirect("/shop/emp/goodsList.jsp");
	
	Part part = request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	// 원본 이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx); // .png
	
	UUID uuid = UUID.randomUUID(); //java에서 랜덤(중복불가) 문자 만드는 클래스
	String filename = uuid.toString().replace("-","");
	filename = filename + ext;
	
	//sql1에 파일네임 변수 추가
	//String sql1 =
	/*
	if(row == 1){ //insert 성공 -> 파일업로드
		//part -> 1) is -> 2) os -> 3) 빈파일
		inputStream is = part.getInputStream();
		3) + 2)
		String filePath = request.getServletContext().getRealPath("/upload");
		File f = new file(filePath, filename); 빈파일 생성
		outPutStream os = Files.newOutputStream(f.toPath()); // os + file
		is.transferTo(os);
		
		os.close();
		is.close();
	}
	
	//파일 삭제
	File df = new File(filePath, rs.getString("filename")) //파일이 없다면 신규생성, 기존 파일이 있다면 기존 파일을 불러온다
	*/
%>