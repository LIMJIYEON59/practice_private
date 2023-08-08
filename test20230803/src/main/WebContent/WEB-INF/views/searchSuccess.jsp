<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>회원정보</h2>
<table>
	<tr>
		<td>회원번호</td>
		<td>회원아이디</td>
		<td>회원이름</td>
		<td>회원나이</td>
	</tr>
	<tr>
		<td>${udto.userNo }</td> <!-- (sevlet파일)넘겨준 값이 udto, (DTO에서) 필드명 가져오기 -->
		<td>${udto.userId }</td>
		<td>${udto.userName }</td>
		<td>${udto.userAge }</td>
	</tr>
</table>
<a href="${pageContext.request.contextPath }/">메인페이지로 돌아가기</a>  <!-- 경로 작성 -->	<!-- 위에서 뿌린 후 다시 main으로 가고싶을 때 이렇게 적어준다. -->
</body>
</html>