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
 * 결과 처리 페이지 성공?실패?
 */
@WebServlet("/selectUser") /* 문제 url봐라 */
public class SelectUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = new UserService(); // DAO 호출
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userNoStr = request.getParameter("userNo");	//userNo가 String 모양이고 이걸 이제 DB에 가지고 가야한다.	
		int userNo = 0;
		
		try {
			userNo = Integer.parseInt(userNoStr);				
		}catch (NumberFormatException e) {
		}
	
		

		UserDTO result = service.selectOne(userNo);	//service.selectOne을 호출한다.	// return 값이 UserDTO이다.	//result 결과물을 받아서 service를 호출한다.(no를 가지고) selectone(한개만 꺼낸다)
		if(result != null) {	// 만약 list 면 (result.size != 0) 형태로 적어줘야 한다.
			request.setAttribute("udto", result);	//이름이 udto인 놈에 result의 갑을 채워줌 //그리고 밑으로 이동을 하는데
			request.getRequestDispatcher("/WEB-INF/views/searchSuccess.jsp").forward(request, response); //jsp로 이동!(화면을 보여줌 응답을 하겠다.)

		UserDTO result = service.selectOne(userNo);	//service.selectOne을 호출한다.	// return 값이 UserDTO이다.
		if(result != null) {	// 만약 list 면 (result.size() != 0) 형태로 적어줘야 한다.
			request.setAttribute("udto", result);
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

//@WebServlet("/selectUser")
//
//public class SelectUserServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String userId = request.getParameter("userId");
//
//		try {
//			User user = new UserService().selectUser(userId);
//			
//		if(user != null) {
//	
//			RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/searchSuccess.jsp");
//			request.setAttribute("user", user);
//			view.forward(request, response);
//			
//		}else {
//			request.getRequestDispatcher("/WEB-INF/views/searchFail.jsp").forward(request, response);
//		}
//		
//		} catch (Exception e) {	
//			e.printStackTrace();

	




