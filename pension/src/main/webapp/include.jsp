<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

	$(function()
	{
		$("#pkc").load("imsi.jsp");
		
	});
</script>
</head>
<body><!-- 현재문서에 다른문서내용을 포함시키는 방법 (1, 2번 방법을 주로 사용)-->

<!-- 1. include사용-->
<%@ include file="imsi.jsp" %>
<hr>

<!-- 2. jstl 코어태그 -->
<c:import url="imsi.jsp"/>
<hr>

<!-- 3. jsp  -->
<jsp:include page="imsi.jsp"/>
<hr>

<!-- 4. jquery-->
<div id="pkc"></div>

</body>
</html>