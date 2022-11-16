<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.GongjiDao"%>
<% 
GongjiDao gdao=new GongjiDao();
gdao.update(request, response);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:700px;
	margin-top:50px;}
	#section table #title, #content{
	font-weight:700;
	width:60px;
	text-align:center;
	font-size:15px;}
	#section table #text{
	font-size:14px;
	text-align:right;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table tr{
	height:40px;}
	#section table input[type=text]{
	width:98%;
	height:30px;
	outline:none;}
	#section table textarea{
	width:98%;
	height:200px;
	outline:none;
	resize:none;
	font-size:13px;}
	#section table input[type=submit], [type=button]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table #btn{
	text-align:right;}
</style>
<div id="section">
<h2>공지사항</h2>
<hr>
	<form method="post" action="update_ok.jsp">
	<input type="hidden" name="id" value="${gdto.id }">
		<table align="center">
			<tr>
				<td id="title">제목</td>
				<td><input type="text" name="title" value="${gdto.title }"></td>
			</tr>
			<tr>
				<td id="content">내용</td>
				<td><textarea name="content">${gdto.content }</textarea></td>
			</tr>
			<tr>
				<td colspan="2" id="text">
				<!-- c태그로 사용하는 법(체크) -->
				<c:if test="${gdto.gubun==1 }">
					<c:set var="gu" value="checked"/>
				</c:if>
				
					<input type="checkbox" name="gubun" value="1" ${gu }>
					이 글을 항상 첫페이지에 출력하고자하면 체크하세요
				</td>
			</tr>
			<tr>	
				<td colspan="2" id="btn">
					<input type="button" value="목록" onclick="location='list.jsp'">
					<input type="submit" value="저장">
				</td>
			</tr>
		</table>
	</form>
</div>

<c:import url="../bottom.jsp"/>