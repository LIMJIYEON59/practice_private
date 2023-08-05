package edu.kh.test.user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//The method getConnection() from the type JdbcTemplate is never used locally
//한번도 쓰인 적이 없어서 뜨는 오류이다.
public class JdbcTemplate {

	// getConnection(): 데이터베이스에 연결을 수행하는 메서드이다
	public static Connection getConnection() { 
		Connection conn = null;						
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");	// 이걸 로드한다.
			try {
				//url,사용자 이름, 비번을 사용하여 DB에 연결한다.
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
		return conn;	//반환값으로 연결된 Connection 객체를 반환한다.
	}

	// close: static void = 리턴값이 없으니 이걸 적어줘야 한다.
	// jdbc에서 사용되는 클래스가 총 3가지 Connection, Statement(원래는 prepared Statement인데 부모 꺼 씀)
	// ResultSet(close가 필요하면 꼭 써야함)
	
	//각각(3개)을 닫는 메서드이다. close(Connection conn)등, 닫을 때 예외가 발생할 수 있으므로 try-catch로 묶어줌
	
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

	
 
	// 지정된 Connection의 자동 커밋 설정을 변경하는 메서드이다. 
	// Connection 객체의 'setAutoCommit(boolean autoCommit) 메서드를 활용하여 자동 커밋 설정을 변경한다.'
	public static void setAutoCommit(Connection conn, boolean autocommit) {
		try {
			if (conn != null) conn.setAutoCommit(autocommit);	//conn아 autocommit 해줘 그리고 try-catch
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
	
	// commit(Connection conn) 트랜잭션을 커밋하는 메서드이다. Connection 객체의 'commit()' 메서드를 호출하여 트랜잭션을 커밋한다.
	// 트랜잭션 처리 후 Connection을 닫는다.
	public static void commit(Connection conn) {
		try {
			if (conn != null) conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// rollback(Connection conn) 트랜잭션을 롤백하는 메서드이다. Connection 객체의 'rollback()' 메서드를 호출하여 트랜잭션을 롤백한다.
	// 트랜잭션 처리 후 Connection을 닫는다.
	public static void rollback(Connection conn) {	
		try {
			if (conn != null) conn.rollback();	//conn을 가지고 와서 rollback을 시도
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
