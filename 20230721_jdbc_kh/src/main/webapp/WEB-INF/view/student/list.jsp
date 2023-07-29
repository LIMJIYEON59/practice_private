<%@page import="kh.test.jdbckh.student.model.vo.StudentVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생 리스트</title>
</head>
<body>
	<h2>학생 리스트</h2>
	<%
	// JSP Tag -안에 java 문법
	// aaa를 꺼내면 controller의 "그냥속성값테스트"가 꺼내질거고 그것은 (String)모양일 것이다.
	String a = (String) request.getAttribute("aaa"); //오류 뜸 그래서 다운캐스팅? (String)적어줌
	String b = (String) request.getAttribute("bbb");
	int c = (int) request.getAttribute("ccc"); //int나 Integer 써도 됨
	// 아래 자료형은  List<StudentVo>이다.
	List<StudentVo> volist = (List<StudentVo>) request.getAttribute("studentList");
	%>

	<!-- ct+sh+/한 개씩 해야한다. -->
	<%-- <%= a %> --%>
	<%-- <%= b %> --%>
	<%-- <%= c %> --%>
	<%-- <%= volist %> --%>


	<table border="1">
		<tr>
			<td>학번</td>
			<td>이름</td>
		</tr>
		<%
		for (int i = 0; i < volist.size(); i++) {
			StudentVo vo = volist.get(i);
		%>
		<!-- tr-td들은 html코드들이라 < % 이거 안에 들어가면 안된다. 그래서 중괄호를 잘봐라 for문으로 다 돌리기 위해 < % 열고 닫히게 함 -->
		<!-- < % 안에는 자바코드 -->
		<!-- < %=표현식 -->

		<tr>
			<td><a href="<%=request.getContextPath()%>/student/get"><%=vo.getStudentNo()%></a></td>
			<td><%=vo.getStudentName()%></td>
			<td><%=vo.getEntranceDate()%></td>
		</tr>


		<%
		}
		%>
	</table>



</body>
</html>