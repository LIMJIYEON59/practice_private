package kh.test.jdbckh.student.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.test.jdbckh.student.model.dao.StudentDao;
import kh.test.jdbckh.student.model.vo.StudentVo;

/**
 * Servlet implementation class StudentListController
 */
@WebServlet({ "/student/list", "/aaa" })
public class StudentListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudentListController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("/student/list doGet() 진입");
		// TODO DB 연동하겠다(파일 만들어야 함 class -> vo랑 dao만듬 dao를 통해 student정보(데이터베이스 정보)읽고
		// vo에다가 채워주겠다. 그리고 그 값을 화면에도 뿌려준다. )
		// 즉 vo = 자료형, dao = 기능위주

		// dao에 있는 애를 불러 오겠다. 객체 생성 해야함 그리고 불러오는 거 작성
		// dao의 result에 값을 넣겠다. 그리고 그 값을 아래 링크(jsp)로 넣겠다.!!
		StudentDao dao = new StudentDao();
		List<StudentVo> result = dao.selectListStudent();
		request.setAttribute("studentList", result); // request에 "" 속성명과 result 값이 생김
		request.setAttribute("aaa", "그냥속성값테스트");
		request.setAttribute("bbb", "그냥속성값테스트");
		request.setAttribute("ccc", 333);
		request.getRequestDispatcher("/WEB-INF/view/student/list.jsp").forward(request, response); // jsp한테 request도 주고
																									// response도 준다.(바로
																									// 위 코드)
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		doGet(request, response);
//	}

//	//TODO 학생 상세 정보 가져오기
//	request.getRequestDispatcher("/WEB-INF/view/student/get.jsp").forward(request, response);	
	
	
}
