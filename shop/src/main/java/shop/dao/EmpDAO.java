package shop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

// emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너
public class EmpDAO {

	
	
	
	
	// HashMap<String, Object> : null이면 로그인실패, 아니면 성공
	// String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw
	
	// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("admin", "1234");
	public static HashMap<String, Object> empLogin(String id, String pw)
													throws Exception {
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection conn = DBHelper.getConnection(); 
		
		String sql = "select emp_id empId, emp_name empName, emp_job empJob, grade from emp where active = 'ON' and emp_id =? and emp_pw = password(?)";
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1,id);
		stmt.setString(2,pw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
			resultMap.put("empJob",rs.getString("empJob"));
			
		}
		conn.close();
		return resultMap;
	}
	
	public static boolean checkId(String empId) throws Exception {
		boolean result = false;
	
		
		Connection conn = DBHelper.getConnection();
		String sql = "select emp_id"
				+ " from emp"
				+ " where emp_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { // 사용불가
			result = true;
		}		
		conn.close();
		
		return result;
	}
	
	public static int insertEmp(String memberId, String memberPw, String memberName, String memberJob, String memberHireDate )
			throws Exception {
		int row = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection(); 
		
		String sql = "insert into emp(emp_id, emp_pw, emp_name, emp_job, hire_date) values(?,password(?),?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		stmt.setString(3, memberName);
		stmt.setString(4, memberJob);
		stmt.setString(5, memberHireDate);
		
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
}