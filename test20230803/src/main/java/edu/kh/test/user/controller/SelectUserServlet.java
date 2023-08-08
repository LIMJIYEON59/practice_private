package edu.kh.test.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.kh.test.user.model.service.UserService;
import edu.kh.test.user.model.vo.UserDTO;

/**
 * 사용자 정보 조회 서블릿
 */
@WebServlet("/selectUser") /* 문제 url봐라 */
public class SelectUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = new UserService(); // UserService 객체 생성 DAO 호출
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userNoStr = request.getParameter("userNo"); //파라미터에서 UserNo의 값을 문자열로 받아온다.	//userNo가 String 모양이고 이걸 이제 DB에 가지고 가야한다. 
		int userNo = 0;
		
		try {
			// 문자열로 받아온 사용자 번호(userStr)를 정수로 변환하여 userNo 변수에 할당한다.
			// 'Interger.parseInt()' 메서드를 사용해서(문자열->정수), 변환하려는 문자열을 괄호안에 전달해야한다.
			userNo = Integer.parseInt(userNoStr);	
		}catch (NumberFormatException e) {				
			// 변환 실패시에는 0으로 설정한다.(userNo가 그대로 0)
		}
	
		
		// UserService의 selectOne() 메서드를 호출하여 사용자 정보를 조회한다.
		// 그 결과는 'UserDTO' 타입의 객체인 'result'에 저장된다.   // 'selectOnt'메서드는 사용자 번호를 기반으로 DB에서 사용자 정보를 검색하는 역할을 수행한다.
		UserDTO result = service.selectOne(userNo);		// return 값이 UserDTO이다.	
		if(result != null) {							// 조회 결과가 있을 경우 			// 만약 list 면 (result.size != 0) 형태로 적어줘야 한다.
			request.setAttribute("udto", result);		// 조회한 사용자 정보를 "udto" 속성에 저장한다. //이름이 'udto'인 것에 result의 값을 채워줌 
		
			request.getRequestDispatcher("/WEB-INF/views/searchSuccess.jsp").forward(request, response); //경로 적어주기

		}else {
			request.getRequestDispatcher("/WEB-INF/views/searchFail.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		doGet(request, response);
//	}
	
}



	




