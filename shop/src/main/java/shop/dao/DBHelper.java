package shop.dao;
import java.io.FileReader;
import java.sql.*;
import java.util.Properties;


public class DBHelper {
	public static Connection getConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		
		//로컬 pc의 Properties 파일 읽어오기
		FileReader fr = new FileReader("d:\\dev\\auth\\mariadb.properties"); //역슬래시 \를 사용하고싶다면 \\두개 사용하면된다
		Properties prop = new Properties();
		prop.load(fr);
		//System.out.println(prop.getProperty("id"));
		//System.out.println(prop.getProperty("pw"));
		
		String db = prop.getProperty("db");
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		
		Connection conn = DriverManager.getConnection(db,id,pw);
		
		return conn;
	}
}