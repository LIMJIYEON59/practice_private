package org.kh.member.model.dao;

public class MemberDao {
	//insert 메서드를 정의한다. //SqlSession 객체와 MembeVo 객체를 매개변수로 받는다.
	public int insertMember(SqlSession, MemberVo mOne) {	//int 형태의 반환값을 가진다.
		//MyBatis SQL 매퍼 쿼리를 실행한다. session 객체를 사용하여 insert 메서드를 호출하고
		//첫 번째 매개변수로는 매퍼 쿼리의 위치를 식별하는 문자열("mybatis.insertMember")을 전달하고
		//두 번째 매개변수로 'mOne' 객체를 전달한다.
		//실행 결과로 영향 받은 행의 수가 'result' 변수에 저장된다.
		int result = session.insert("mybatis.insertMember",mOne);	
		System.out.println("member@MemberDAO="+result);	//""이거 다음에는 result 변수의 값을 출력한다.
		return result;
	}
}

//public int insertMember(SqlSession, MemberVo mOne) -> MemberVo 자료형 누락하면 안됨
//int result = session.insert("mybatis.insertMember",mOne);	->namespace="mybatis"에 지정한 이름.id명 작성되어야함