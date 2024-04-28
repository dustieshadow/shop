package shop.dao;
import java.sql.*;
import java.util.*;


public class OrderDAO {
	
	public static int insertOrder(String mail, int goodsNo, int totalPrice, int orderQuantity, String name, String filename) throws Exception {
		int insertOrder = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "insert into orders(mail, goods_no, total_price, order_quantity,name, filename) values(?,?,?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, totalPrice);
		stmt.setInt(4, orderQuantity);
		stmt.setString(5, name);
		stmt.setString(6, filename);
	
		insertOrder = stmt.executeUpdate();
		
		if(insertOrder == 1) {
			System.out.println("신규 주문 생성에 성공하였습니다.");
		}

		conn.close();
		return insertOrder;
	}
	
	public static ArrayList<HashMap<String, Object>> selectOrderList(int limitStartPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectOrderList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		//String sql = "select mail, goods_no, total_price, state , filename, order_quantity, name, EXTRACT(year from order_date) year, EXTRACT(month from order_date) MONTH, EXTRACT(day from order_date) DAY, EXTRACT(hour from order_date) hour, EXTRACT(minute from order_date) minute from orders order by order_date desc limit ?,?";

		
		String sql = "SELECT o.mail mail, o.orders_no orders_no ,o.goods_no goods_no, format(o.total_price,0) total_price, o.state state , o.filename filename, o.order_quantity order_quantity, o.NAME name, EXTRACT(year from order_date) YEAR, eXTRACT(month from order_date) MONTH, EXTRACT(day from order_date) DAY, EXTRACT(hour from order_date) HOUR, EXTRACT(minute from order_date) MINUTE, g.goods_title goods_title from orders o INNER JOIN goods g on o.goods_no = g.goods_no order by order_date desc limit ?,?";

		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, limitStartPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("mail", rs.getString("mail"));
			m.put("ordersNo", rs.getInt("orders_no"));
			m.put("goodsNo", rs.getInt("goods_no"));
			m.put("totalPrice", rs.getString("total_price"));
			m.put("state", rs.getString("state"));
			m.put("filename", rs.getString("filename"));
			m.put("orderQuantity", rs.getString("order_quantity"));
			m.put("listName", rs.getString("name"));
			m.put("year", rs.getString("YEAR"));
			m.put("month", rs.getString("MONTH"));
			m.put("day", rs.getString("DAY"));
			m.put("hour", rs.getString("HOUR"));
			m.put("minute", rs.getString("MINUTE"));
			m.put("goodsTitle", rs.getString("goods_title"));

			selectOrderList.add(m);

		}
		System.out.println("selectOrderList(오더 테이블 칼럼명 목록) : " + selectOrderList);
		conn.close();

		return selectOrderList;
	}
	

	public static int selectCountOrders() throws Exception {

		int totalRow = 0;

		Connection conn = DBHelper.getConnection();

		//
		String sql = "select" + " count(*) cnt " + "from orders";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			totalRow = rs.getInt("cnt");

		}
		System.out.println("totalRow : " + totalRow);
		conn.close();

		return totalRow;
	}
	
	public static ArrayList<HashMap<String, String>> selectOrderState(String state)
			throws Exception {

		ArrayList<HashMap<String, String>> selectOrderState = new ArrayList<HashMap<String, String>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "select state from orderstate where state = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, state);
	

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, String> m = new HashMap<String, String>();

			m.put("state", rs.getString("state"));
		


			selectOrderState.add(m);

		}
		
		System.out.println("selectOrderState(오더 테이블 칼럼명 목록) : " + selectOrderState);
		conn.close();

		return selectOrderState;
	}
	
	
	public static ArrayList<HashMap<String, String>> selectOrderStateNull()
			throws Exception {

		ArrayList<HashMap<String, String>> selectOrderStateNull = new ArrayList<HashMap<String, String>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql = "select state from orderstate";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, String> m = new HashMap<String, String>();

			m.put("state", rs.getString("state"));
			selectOrderStateNull.add(m);

		}
		
		System.out.println("selectOrderState(오더 테이블 칼럼명 목록) : " + selectOrderStateNull);
		conn.close();

		return selectOrderStateNull;
	}
	
	public static int updateChangeStateOrder(String mail, int goodsNo, int totalPrice, int orderQuantity, String name, String filename) throws Exception {
		int insertOrder = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "insert into orders(mail, goods_no, total_price, order_quantity,name, filename) values(?,?,?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, totalPrice);
		stmt.setInt(4, orderQuantity);
		stmt.setString(5, name);
		stmt.setString(6, filename);
	
		insertOrder = stmt.executeUpdate();
		
		if(insertOrder == 1) {
			System.out.println("신규 주문 생성에 성공하였습니다.");
		}

		conn.close();
		return insertOrder;
	}
	
	

}
