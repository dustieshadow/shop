package shop.dao;
import java.sql.*;
import java.util.*;


public class OrderDAO {
	
	public static int insertOrder(String mail, int goodsNo, int totalPrice, int orderQuantity) throws Exception {
		int insertOrder = 0;
		// DB 접근
		Connection conn = DBHelper.getConnection();

		String sql = "insert into order(mail, goods_no, total_price, order_quantity) values(?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, totalPrice);
		stmt.setInt(4, orderQuantity);
	
		insertOrder = stmt.executeUpdate();
		
		if(insertOrder == 1) {
			System.out.println("신규 주문 생성에 성공하였습니다.");
		}

		conn.close();
		return insertOrder;
	}
	
	

}
