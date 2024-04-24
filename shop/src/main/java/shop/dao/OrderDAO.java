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
		String sql = "select mail, goods_no, total_price, state , filename, order_quantity, name, order_date from orders limit ?,?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, limitStartPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("mail", rs.getString("mail"));
			m.put("goodsNo", rs.getInt("goods_no"));
			m.put("totalPrice", rs.getInt("total_price"));
			m.put("state", rs.getString("state"));
			m.put("filename", rs.getString("filename"));
			m.put("orderQuantity", rs.getString("order_quantity"));
			m.put("name", rs.getString("name"));
			m.put("orderDate", rs.getString("order_date"));

			selectOrderList.add(m);

		}
		System.out.println("selectOrderList(오더 테이블 칼럼명 목록) : " + selectOrderList);
		conn.close();

		return selectOrderList;
	}
	
	

}
