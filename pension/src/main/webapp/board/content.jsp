<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.BoardDao"%>
<% 
BoardDao bdao=new BoardDao();
bdao.content(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
	margin-top:50px;
	border-left:none;
	border-right:none;
	border-top-color:white;
	border-collapse:collapse;}
	#section table tr{
	height:40px;}	
	#section table td:first-child, #writeday{
	font-size:15px;
	font-weight:700;}
	#section table td:last-child, #readnum-size{
	font-size:14px;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table td{
	border-left:none;
	border-right:none;}
	#section table #content{
	width:100px;
	height:300px;}
	#section table #readnum-size{
	width:350px;}
	#section table #btn{
	text-align:right;
	padding-top:20px;
	border-bottom-color:white;}
	#section table input[type=button]{
	margin-top:10px;
	width:150px;
	height:40px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table #del{
	display:none;
	text-align:right;}
	#section table input[type=password]{
	width:120px;
	height:20px;
	outline:none;}
	#section table input[type=submit]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
</style>
<script>
function del_form()
	{
		document.getElementById("del").style.display="table-row";
	}
</script>
<div id="section">
<h2>게시글</h2>
<hr>
	<table align="center" border="1">
	
		<tr>
			<td>제목</td>
			<td colspan="3" >${bdto.title }</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td colspan="3" >${bdto.userid }</td>
		</tr>
		<tr>
			<td id="content">내용</td>
			<td colspan="3">${bdto.content }</td>
		</tr>
		<tr>
			<td>조회수</td>
			<td id="readnum-size">${bdto.readnum }</td>
			<td id="writeday">작성일</td>
			<td>${bdto.writeday }</td>
		</tr>
		<tr>
			<td colspan="4" id="btn">
				<input type="button" value="목록" onclick="location='list.jsp'">
				<!-- 보이는 경우 
					1. board테이블의 userid값이 guest인 경우
					2. board테이블의 userid와 세션의 userid가 같은 경우
					
					안보이는 경우
					1. board테이블의 userid값이 guest가 아닌경우
					2. board테이블의 userid와 세션의 userid가 다른 경우
				 -->
				
				<!-- 보이는 경우 -->
				<c:if test="${bdto.userid=='guest' || (bdto.userid==userid) || userid=='admin' }">
					<input type="button" value="수정" onclick="location='update.jsp?id=${bdto.id}'">
					
					<!-- guest일 경우 : 비번 입력 -->
					<c:if test="${bdto.userid=='guest' && userid !='admin'}">
						<input type="button" value="삭제" onclick="javascript:del_form()">
					</c:if>
					
					<!-- 회원일 경우 : 비번 입력x -->
					<c:if test="${bdto.userid==userid && userid != 'admin'}">
						<input type="button" value="삭제" onclick="location='delete.jsp?id=${bdto.id}'">
					</c:if>
					
					<!-- 관리자일 경우 : 비번 입력x -->
					<c:if test="${userid=='admin' }">
						<input type="button" value="삭제" onclick="location='delete.jsp?id=${bdto.id}'">
					</c:if>
					
				</c:if>		
			</td>
		</tr>
		
		<!-- 비회원이 삭제할 경우 비밀번호를 입력할 폼 -->
		<tr id="del">
			<td colspan="4">
				<form method="post" action="delete.jsp">
				<input type="hidden" name="id" value="${bdto.id }">
					<input type="password" name="pwd">
					<input type="submit" value="삭제">
				</form>
			</td>
		</tr>
	</table>

</div>
<c:import url="../bottom.jsp"/>