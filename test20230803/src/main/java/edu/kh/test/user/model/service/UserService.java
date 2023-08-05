package edu.kh.test.user.model.service;

import java.sql.Connection;

import edu.kh.test.user.JdbcTemplate;
import edu.kh.test.user.model.dao.UserDAO;
import edu.kh.test.user.model.vo.UserDTO;

public class UserService {
	private UserDAO dao = new UserDAO(); //selectOne 메소드를 호출한다	//dao 객체를 생성
	
	public UserDTO selectOne(int userNo) {
		UserDTO result = null; 
		
		// 데이터베이스 연결을 얻어옴	//jdbctemplate부터 geconnection을 호출한다.
		Connection conn = JdbcTemplate.getConnection();	
		
		// dao의 selectOne 메서드를 호출하여 회원 정보 조회	//dao를 호출하고 그 값을 result에 담는다.
		result = dao.selectOne(conn, userNo); 
		
		//데이터베이스 연결을 닫음
		JdbcTemplate.close(conn); 
		return result;
	}

}
