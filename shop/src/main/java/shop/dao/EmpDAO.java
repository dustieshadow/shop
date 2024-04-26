package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

// emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너
public class EmpDAO {

	// HashMap<String, Object> : null이면 로그인실패, 아니면 성공
	// String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw

	// 호출코드 HashMap<String, Object> m = EmpDAO.empLogin("", "");
	public static HashMap<String, Object> empLogin(String id, String pw) throws Exception {
		HashMap<String, Object> resultMap = null;

		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "select emp_id empId, emp_name empName, emp_job empJob, grade from emp where active = 'ON' and emp_id =? and emp_pw = password(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
			resultMap.put("empJob", rs.getString("empJob"));

		}
		conn.close();
		return resultMap;
	}

	public static boolean checkId(String empId) throws Exception {
		boolean result = false;

		Connection conn = DBHelper.getConnection();
		String sql = "select emp_id" + " from emp" + " where emp_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) { // 사용불가
			result = true;
		}
		conn.close();

		return result;
	}

	public static int insertEmp(String memberId, String memberPw, String memberName, String memberJob,
			String memberHireDate) throws Exception {
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

	public static int insertEmpPw(String memberId, String memberPw)
			throws Exception {
		int row = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection(); 
		
		String sql = "insert into empPw(emp_id, emp_pw) values(?,password(?))";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
	
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	
	
	
	public static ArrayList<HashMap<String, Object>> empList() throws Exception {
		ArrayList<HashMap<String, Object>> empList = new ArrayList<HashMap<String,Object>>();

// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, update_date updateDate, active, grade from emp order by hire_date";
		PreparedStatement stmt = conn.prepareStatement(sql);
	
		ResultSet rs = stmt.executeQuery();

		
		// ResultSet -> ArrayList<HashMap<String, Object>>
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			//HashMap에 키,밸류값 입력
			m.put("empId", rs.getString("empId"));
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("active", rs.getString("active"));
			m.put("grade", rs.getString("grade"));
			//ArrayList에 HashMap값 입력
			empList.add(m);
		}
		conn.close();
		return empList;
	}
	
	public static int empActiveToOn(String empId) throws Exception {
		int row = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "update emp set active = 'ON' ,update_date = now() WHERE emp_id =? and active = 'OFF'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
	
		row = stmt.executeUpdate();

		conn.close();
		return row;
	}
	
	public static int empActiveToOff(String empId) throws Exception {
		int row = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "update emp set active = 'OFF' , update_date = now() WHERE emp_id =? and active = 'ON' ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
	
		row = stmt.executeUpdate();

		conn.close();
		return row;
	}
	
	public static int empModify(String empId, String empName, String empJob, String hireDate ) throws Exception {
		int empModify = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "update emp set emp_id = ? , emp_name = ?, emp_job = ?, hire_date = ?, update_date = now()  WHERE emp_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empName);
		stmt.setString(3, empJob);
		stmt.setString(4, hireDate);
		stmt.setString(5, empId);
	
		empModify = stmt.executeUpdate();

		conn.close();
		return empModify;
	}

}