<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
</head>
<body>
<h2>회원 정보 조회(회원 번호 검색)</h2>
<form action="${pageContext.request.contextPath }/selectUser" method="get">
		<input type="text" name="userNo" >
		<button type="submit"> 조회</button>
</form>
</body>
</html>

