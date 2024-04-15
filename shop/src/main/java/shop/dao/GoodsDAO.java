package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	public static ArrayList<HashMap<String, Object>> selectGoodsList(
					int stratRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter
		String sql = "select *"
				+ " from goods"
				+ " order by create_date desc"
				+ " limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, stratRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getInt("goods_no"));
			m.put("category", rs.getString("category"));
			// ....
			list.add(m);
		}
		
		conn.close();
		
		return list;
	}
}