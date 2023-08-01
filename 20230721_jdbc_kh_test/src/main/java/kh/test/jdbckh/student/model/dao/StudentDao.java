package kh.test.jdbckh.student.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kh.test.jdbckh.student.model.vo.StudentVo;

public class StudentDao {
	
	//DB에서 tb_student 테이블의 전달받은 학번을 통해 학생1명의 상세정보를 얻어옴
		//  () <- 이 파라메타에 학번에 관한 내용이 들어가있어야 한다. 리턴 해줘야함(혼자 먹고 치우지 않으니)
			// 학생 전체 정보 = StudentVo
	public StudentVo selectOneStudent(String studentNo) {
		String query
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 이름:selectListStudent 혹은 StudentList등등 룰이 있음
	// DB에서 tb_student 테이블의 있는 모든 내용을 읽어서 꺼냄
	
	// void는 혼자만 하겠다는 소리 그래서 리턴 타입을 void말고 다른걸로 바꿔줘야 한다.
	// StudntVo 모양의 하나만 있으면 안됨 왜? 여러개의 데이터를 가져올거니깐 =>List<StudentVo>
	// result(이름)
	// 데이터 베이스 가서 꺼내오겠다.
		/*	public List<StudentVo> selectListStudent() {
				List<StudentVo> result = null;
	
				return result;
	
			}
		 */
	
	//ppt 시작
	public List<StudentVo> selectListStudent() {
			List<StudentVo> result = null;
			// 선언 밖에다 해 줌
			Connection conn = null;
			Statement  stmt = null;
			PreparedStatement pstmt = null;
		
			
			try {
				// Class.forName()이라는 메소드에다가 (...) 클래스 이름을 준다. 그리고 나서 얘가 로딩하고 꺼낸다. =반드시 ClassNotFoundException 처리를 해야 함
				// 1. driver 있다면 로딩함. // 없다면 ClassNotFoundException
					// forName 얘는 리턴타입이 void라서 앞에 뭐가 없음
				Class.forName("oracle.jdbc.driver.OracleDriver");
				// 2. Connection 객체 생성 // dbms와 연결(연결통로 생성 conn이라는 객체를 통해)
				// getConnection은 Connection 모양으로 리턴한다. (getConnection를 통해 객체를 만듬(이미 생성된걸 꺼내는 것 new해서 만들지 않음))
				conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:xe", "kh", "kh"); //passward도 같이 쓰려고 3번째 꺼 임포트 (url,계정명,비번(대소문자 구분 하기))
				// 점검하기(연결 잘 됐는지.확인용도)
				if(conn != null) {
						System.out.println("DB 연결 성공!!!!!!!!");
				} else {
						System.out.println("DB 연결 실패");
				}
				// 3. Statement/PrepareStatement 객체 생성 (new라고 생성x conn객체로부터 받아오는 것이다. - query 문을 실어서 보낸다.)
//				stmt = conn.createStatement();
					//prepareStatement이걸 만들어서 거기에 query문 넣고
				String query = "select * from tb_student";
				pstmt = conn.prepareStatement(query);
				// 4. query 문을 실행해달라고 함. - 그 결과값을 return 받음
					//executeQuery이걸 하면 ResultSet을 줄 것이다.
				// select quert 문이면 ResultSet 모양
				// insert/update/delete 문이면 int 모양
				ResultSet rs = pstmt.executeQuery();
				
				// 5. ResultSet에서 row(record)=한줄 읽어오기 위해 cursor(포인트)를 이동함.(=한 줄씩 읽기 위해 while문 씀)
					//그것드을 vo모양에 담는다. 그리고 =>이것들을 controller로 보냄
				result = new ArrayList<StudentVo>(); // 이렇게 만들면 이제 result는 null이 아니다.
				while(rs.next() ==true) {
					// 한 줄 row/record 를 읽을 준비 완료 
					// 좀 더 세분화 어떤 한 줄인지 모르니깐.
					// 확인용도.System.out.println(rs.getString("STUDENT_NAME")); // " " 컬럼명 
					StudentVo vo = new StudentVo();
					vo.setStudentNo(rs.getString("Student_No"));
					vo.setDepartmentNo( rs.getString("department_no"));
					vo.setStudentName( rs.getString("Student_Name"));
					vo.setAbsenceYn( rs.getString("Absence_Yn"));
					vo.setCoachProfessorNo( rs.getString("Coach_Professor_No"));
					vo.setStudentAddress( rs.getString("Student_Address"));
					vo.setEntranceDate( rs.getDate("Entrance_Date") );;
					
					result.add(vo);
			
				}
			
			} catch (ClassNotFoundException e) {
				// 1. driver (ojdbc.jar) 없음(드라이브가 없다 (...)이게 없다 그것에 관한 오류이다.
				e.printStackTrace();
			} catch (SQLException e) {
				// 2. 연결 실패 오류(getConnection부분)
				e.printStackTrace();
				// conn이 쓰는 용량이 많아 꼭 close 해서 닫아줘야 한다. (근데 선언은 try-catch문 안에서 못함 밖으로 빼줘야 한다.)
				// close 순서 있음 지켜야 함
			} finally {
				try {
					// null point Exception 오류가 있을 가능성으로 if어쩌구 씀
					if(pstmt!= null) {
						pstmt.close();
					}
					if(stmt!=null) {
						stmt.close();
					}
					if(conn!=null) {
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
//			확인용.System.out.println(result);
			return result;
		
		}

}
