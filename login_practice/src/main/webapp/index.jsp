<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="/join"><h1>회원가입: 절대위치 context path 누락됨 -사용불가</h1></a>
<a href="./join"><h1>회원가입: 상대위치 엄청 불편함</h1></a>
<a href="<%=request.getContextPath() %>/join00"><h1>회원가입</h1></a>
</body>
</html>