package shop.dao;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class GoodsDAO {
	public static ArrayList<HashMap<String, Object>> selectGoodsList(int limitStartPage, int rowPerPage)
			throws Exception {

		ArrayList<HashMap<String, Object>> selectGoodsList = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
		// 긴 문자열 자동 줄바꿈 ctrl + enter

		//
		String sql1 = "select category, goods_no, emp_id, goods_title, goods_price, goods_amount, goods_content, filename, update_date, create_date from goods limit ?,?";

		PreparedStatement stmt = conn.prepareStatement(sql1);
		stmt.setInt(1, limitStartPage);
		stmt.setInt(2, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("category", rs.getString("category"));
			m.put("goods_no", rs.getInt("goods_no"));
			m.put("emp_id", rs.getString("emp_id"));
			m.put("goods_title", rs.getString("goods_title"));
			m.put("goods_price", rs.getInt("goods_Price"));
			m.put("goods_amount", rs.getInt("goods_amount"));
			m.put("goods_content", rs.getString("goods_content"));
			m.put("filename", rs.getString("filename"));
			m.put("update_date", rs.getString("update_date"));
			m.put("create_date", rs.getString("create_date"));

			selectGoodsList.add(m);

		}
		System.out.println("selectGoodsList(리스트에 추가된 칼럼명 목록) : " + selectGoodsList);
		conn.close();

		return selectGoodsList;
	}

	public static ArrayList<HashMap<String, Object>> selectGoodsListCategory(String category, int limitStartPage,
			int rowPerPage) throws Exception {

		ArrayList<HashMap<String, Object>> selectGoodsListCategory = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();
// 긴 문자열 자동 줄바꿈 ctrl + enter

//
		String sql2 = "select category, goods_no, emp_id, goods_title, goods_price, goods_amount, filename, update_date, create_date from goods where category=? limit ?,?";

		PreparedStatement stmt = conn.prepareStatement(sql2);
		stmt.setString(1, category);
		stmt.setInt(2, limitStartPage);
		stmt.setInt(3, rowPerPage);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("category", rs.getString("category"));
			m.put("goods_no", rs.getInt("goods_no"));
			m.put("emp_id", rs.getString("emp_id"));
			m.put("goods_title", rs.getString("goods_title"));
			m.put("goods_price", rs.getInt("goods_Price"));
			m.put("goods_amount", rs.getInt("goods_amount"));
			m.put("filename", rs.getString("filename"));

			selectGoodsListCategory.add(m);

		}
		System.out.println("selectGoodsListCategory(리스트에 추가된 칼럼명 목록) : " + selectGoodsListCategory);
		conn.close();

		return selectGoodsListCategory;
	}

	public static ArrayList<HashMap<String, Object>> selectCountGroupByCategory() throws Exception {

		ArrayList<HashMap<String, Object>> selectCountGroupByCategory = new ArrayList<HashMap<String, Object>>();

		Connection conn = DBHelper.getConnection();

		//
		String sql = "select" + " category, count(*) cnt " + "from goods " + "group by category";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();

			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));

			selectCountGroupByCategory.add(m);

		}
		System.out.println("selectCountGroupByCategory(리스트에 추가된 카테고리 그룹별 행수 : " + selectCountGroupByCategory);
		conn.close();

		return selectCountGroupByCategory;
	}

	public static int selectCountGoods() throws Exception {

		int totalRow = 0;

		Connection conn = DBHelper.getConnection();

		//
		String sql = "select" + " count(*) cnt " + "from goods";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			totalRow = rs.getInt("cnt");

		}
		System.out.println("totalRow : " + totalRow);
		conn.close();

		return totalRow;
	}

	public static ArrayList<String> categoryList() throws Exception {

		ArrayList<String> categoryList = new ArrayList<String>();

		Connection conn = DBHelper.getConnection();

		//
		String sql = "select category from category";

		PreparedStatement stmt = conn.prepareStatement(sql);

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			categoryList.add(rs.getString("category"));

		}
		System.out.println("categoryList : " + categoryList);
		conn.close();

		return categoryList;
	}

	public static int addGoods(String category, String empId, String goodsTitle, String filename, String goodsContent, int goodsPrice, int goodsAmount) throws Exception {

		int addGoods = 0;

		Connection conn = DBHelper.getConnection();

		//
		//String sql = "INSERT INTO goods(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date,create_date)values(?,?,?,?,?,?,?,now(),now())";
		String sql = "INSERT INTO goods(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date) VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,category);
		stmt.setString(2,empId);
		stmt.setString(3,goodsTitle);
		stmt.setString(4,filename);
		stmt.setString(5,goodsContent);
		stmt.setInt(6, goodsPrice);
		stmt.setInt(7, goodsAmount);

		System.out.println("stmt확인 : " + stmt);
		
		addGoods = stmt.executeUpdate();
		if(addGoods==1) {
			
			System.out.println("상품 등록에 성공하였습니다.");
		

		}else {
		System.out.println("상품 등록에 실패하였습니다");
		}

		return addGoods;
	}

	
	public static int modifyGoods(int goodsNo, String category, String goodsTitle, String filename, int goodsPrice, int goodsAmount, String goodsContent) throws Exception {

		int modifyGoods = 0;

		Connection conn = DBHelper.getConnection();

		//
			
		String sql = "update goods set goods_no=?,category=?,goods_title=?,filename=?,goods_price=?,goods_amount=?,goods_content=? where goods_no = ? ";
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,goodsNo);
		stmt.setString(2,category);
		stmt.setString(3,goodsTitle);
		stmt.setString(4,filename);
		stmt.setInt(5,goodsPrice);
		stmt.setInt(6, goodsAmount);
		stmt.setString(7, goodsContent);
		stmt.setInt(8, goodsNo);

		System.out.println("stmt확인 : " + stmt);
		
		modifyGoods = stmt.executeUpdate();
		if(modifyGoods==1) {
			
			System.out.println("상품 내용 수정에 성공하였습니다.");
		

		}else {
		System.out.println("상품 내용 수정에 실패하였습니다");
		}

		return modifyGoods;
	}



}