package edu.kh.test.user.model.service;

import java.sql.Connection;

import edu.kh.test.user.JdbcTemplate;
import edu.kh.test.user.model.dao.UserDAO;
import edu.kh.test.user.model.vo.UserDTO;

public class UserService {
	// UserDAO 객체를 생성
	private UserDAO dao = new UserDAO(); 
	
	// 사용자 번호를 매개변수로 받아 해당 사용자 정보를 조회하는 메서드이다.
	public UserDTO selectOne(int userNo) {
		UserDTO result = null; 
		
		// 1.데이터베이스 연결을 얻어옴	//jdbctemplate 클래스의 geconnection()메서드를 호출하여 데이터베이스 연결 객체인 'Connection'을 얻어온다.
		Connection conn = JdbcTemplate.getConnection();	
		
		// UserDAO의 selectOne 메서드를 호출하여 회원 정보 조회	//이전에 얻은 Connection 객체와 사용자 번호를 전달한다. 조회한 결과는 'result'에 저장된다.	
		// conn을 가지고 dao로 간다.(연결통로를 줄거고 view로 부터 들어 온 userNo도 주겠다.) 
		result = dao.selectOne(conn, userNo); 
		
		//데이터베이스 연결을 닫음 (메서드 실행이 끝났으므로 연결을 종료한다.)
		JdbcTemplate.close(conn); 
		
		// 조회한 사용자 정보를 반환
		return result;
	}

}
