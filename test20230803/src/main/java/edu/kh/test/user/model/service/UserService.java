package edu.kh.test.user.model.service;

import java.sql.Connection;

import edu.kh.test.user.JdbcTemplate;
import edu.kh.test.user.model.dao.UserDAO;
import edu.kh.test.user.model.vo.UserDTO;

public class UserService {
	private UserDAO dao = new UserDAO(); //selectOne 메소드를 호출한다
	
	public UserDTO selectOne(int userNo) {
		UserDTO result = null; 
		Connection conn = JdbcTemplate.getConnection();	//jdbctemplate부터 geconnection을 호출한다.
		result = dao.selectOne(conn, userNo); //dao를 호출하고 그 값을 result에 담는다.
		JdbcTemplate.close(conn); //호출하고 conn을 close를 해준다.
		return result;
	}

}
