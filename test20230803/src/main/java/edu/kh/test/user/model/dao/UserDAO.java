package edu.kh.test.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import edu.kh.test.user.JdbcTemplate;
import edu.kh.test.user.model.vo.UserDTO;
// DAO: 데이터베이스 작업을 처리, 주로 사용자 데이터를 검색하는 역할을 한다.
public class UserDAO {
	//메소드를 만들어 준다. //리턴타입은 UserDTO이다.	// 단일행 메서드 이름을 selectOne()이라고 짓는다.(내맘, 아님 문제에 나타나있음)
	// selectOne인 경우 ()이 안에 pk에 해당되는 값이 들어가야 where절을 쓸 수 있다.(이 문제에선 pk의 값은 int userNo이다.)
		//그리고 service를 쓸거라 (Connection conn, int userNo) 라고 적어줘야 한다. //커넥션을 들고 온다.
	// DB 연결 객체('Connection')과 사용자 번호('UserNo')를 매개변수로 받고 // 'UserDTO' 객체를 반환한다.
	public UserDTO selectOne(Connection conn, int userNo) {
		UserDTO result = null; 	// 리턴타입(UserDTO)에 맞춰서 변수 지정 //UserDTO:객체, result:변수

//		USER_NO   NOT NULL NUMBER       
//		USER_ID   NOT NULL VARCHAR2(50) 
//		USER_NAME NOT NULL VARCHAR2(50) 
//		USER_AGE  NOT NULL NUMBER  
		
		//쿼리 문 작성(쿼리문은 문자열)	//USER_NO를 가지고 왔으니 where절에다 적고 =? 를 마지막으로 적는다.
		String query = "select USER_NO, USER_ID, USER_NAME, USER_AGE from TB_USER where USER_NO=?"; 
		//선언
		PreparedStatement pstmt = null;
		ResultSet rs = null;	//select문이라(위에 파랑이 봐라) resultset 적는데 insert문이면 적지 않는다.
		try {
			pstmt = conn.prepareStatement(query);	//conn으로부터 p(쿼리)를 넣어준다.	//conn으로부터 prepareStatement를 꺼내오고 qyery문을 가진채 보낸다. // 보낸다음 받을 자료형이 필요한데 그게 pstmt이다.
			pstmt.setInt(1, userNo); //pstmt에 ?가 있으니 설정을 해줘야 한다. //setInt이다 위에(int userNo) 값을 여기 채워줌
			rs = pstmt.executeQuery(); //실행! // 매개변수(사용자 번호)를 설정한 후 executeQuery() 메서드를 호출하여 쿼리를 실행하고 결과 집합 ResultSet을 가져온다.
			
			//rs.next() 메서드를 사용하여 결과집합('ResultSet')에서 다음 행으로 이동하고 해당 행에서 데이터를 추출하여 UserDTO 객체를 생성합니다. 
			if(rs.next()) {			   //단일행이라 여기에 while을 안 쓴다.	//next -> 한 행을 읽을게 있는가~
				result = new UserDTO(rs.getInt("userNo"), rs.getString("USER_ID"), rs.getString("USER_NAME"), rs.getInt("USER_AGE")); 
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {	
			// 결과 집합과 PreparedStatement 닫기
			JdbcTemplate.close(rs);
			JdbcTemplate.close(pstmt);
		}
		return result;
	}

}

