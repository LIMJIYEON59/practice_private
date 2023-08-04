package edu.kh.test.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcTemplate {
	// 이래야지 광범위하게 new를 안해도되니깐
	public static Connection getConnection() { // connection 객체 getconnection()이라는 메서드 생성
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			try {
				conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:xe", "abc", "abc");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		if(conn != null) {
			System.out.println("연결 성공");
		}else {
			System.out.println("연결 실패");
		}
		return conn;
	}

	// close: static void = 리턴값이 없으니 이걸 적어줘야 한다.
	// jdbc에서 사용되는 클래스가 총 3가지 Connection, Statement(원래는 prepared Statement인데 부모 꺼 씀)
	// ResultSet(close가 필요하면 꼭 써야함)

	// conn.close()해준다 그리고 try-catch 해준다. (이것 때문에 jdbcTemplate)
	// nullpointexception이 많이 뜸 그래서 if문 쓰고 conn이 null이 아닐 때만 close를 해주겠다.
	public static void close(Connection conn) {
		try {
			if (conn != null)conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(Statement stmt) {
		try {
			if (stmt != null)stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(ResultSet re) {
		try {
			if (re != null)	re.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// close -> try-catch -> null 이 끝났으면 commit도 해준다.
	
	// setAutoCommit: set으로 시작하는 애들은 return값이 없다. 
	// boolean으로 하고 autocommit이라고 이름을 만듬
	public static void setAutoCommit(Connection conn, boolean autocommit) {
		try {
			if (conn != null) conn.setAutoCommit(autocommit);	//conn아 autocommit 해줘 그리고 try-catch
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
	
	// 객체 Connection 
	public static void commit(Connection conn) {
		try {
			if (conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// rollback 을 마무리로 총 5개 적어준다.
	public static void rollback(Connection conn) {	
		try {
			if (conn != null) conn.rollback();	//conn을 가지고 와서 rollback을 시도
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
