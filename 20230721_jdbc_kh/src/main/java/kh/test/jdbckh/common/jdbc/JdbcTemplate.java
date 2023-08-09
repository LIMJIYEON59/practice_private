package kh.test.jdbckh.common.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcTemplate {
	private static Connection conn = null;

	public static Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@1.221.120.195:1521:xe", "LJY", "LJY");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (conn != null) {
			System.out.println("== DB 연결 실패");
		} else {
			System.out.println("== DB 연결 성공");
		}
		return conn;
	}

	public static void close(Connection conn) {
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(Statement stmt) {
		try {
			if (stmt != null)
				stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void close(ResultSet rs) {
		try {
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void setAutocommit(Connection conn, boolean autocommit) {
		try {
			if (conn != null)
				conn.setAutoCommit(autocommit);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void commit(Connection conn) {
		try {
			if (conn != null)
				conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void rollback(Connection conn) {
		try {
			if (conn != null)
				conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
