package org.kh.member.model.service;

import org.apache.ibatis.session.SqlSession;

public class MemberService {
	MemberDAOLogic memberDAO = new MemberDAOLogic();	//(인스턴스)'memberDAO' 객체 생성
	// 'insertMember' 메서드를 정의한다. 이 메서드는 MEmberVo 클래스의 객체 mOne을 매개변수로 받고 int 형태의 반환값을 가진다.
	public int insertMember(MemberVo mOne) {
		SqlSession session = SqlSessionTemplate.getSqlSession();
		//DAO 객체를 사용하여 (DB에 회원정보삽입) insertMember 메서드를 호출 
		int result = memberDAO.insertMember(session, mOne);	//결과값은 result에 저장됨
		if(result>0) {
			session.commit();
		}else {
			session.rollback();
		}
		session.close();
		return result;
	}
}