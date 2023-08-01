package kh.test.jdbckh.student.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.test.jdbckh.student.model.dao.StudentDao;
import kh.test.jdbckh.student.model.vo.StudentVo;

/**
 * Servlet implementation class StudentGetController
 */
@WebServlet("/student/get")
public class StudentGetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet() 
     */
    public StudentGetController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1.전딜받은 parameter 읽어내기
		String studentNo = request.getParameter("sno");
		System.out.println(studentNo);
		// 2. 전달받은 데이터를 활용해서 DB학생 상세 정보 가져오기	//Dao의 메소드 하나를 호출한다.
		StudentDao dao = new StudentDao();
		StudentVo vo = dao.selectOneStudent(studentNo); //값을 담을 수 있도록 변수 선언
		request.getRequestDispatcher("/WEB-INF/view/student/get.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		doGet(request, response);
//	}

}
