<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.GongjiDao"%>
<% 
GongjiDao gdao=new GongjiDao();
gdao.list(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#a1, #name, #writeday{
	font-size:14px;
	font-weight:100;
	text-align:center;}
	#section table{
	width:900px;
	margin-top:50px;
	border-left:none;
	border-right:none;
	border-top-color:white;
	border-collapse:collapse;}
	
	/*collapse와 radius는 충돌하기 때문에 외곽선을 둥글게 표시하고 싶다면 아래와 같이 하자*/
/*	border-radius: 10px;
    border-style: hidden;
	box-shadow: 0 0 0 1px red;}
*/	
	#section table a{
	text-decoration:none;
	color:black;}
	#section table td{
	border-left:none;
	border-right:none;}
	#section table #title{
	width:400px;
	padding-left:20px;}
	#section table #img{
	width:20px;}
	#section table tr:first-child{
	font-size:15px;
	font-weight:700;}
	#section table .name, .writeday{
	text-align:center;}
	#section table tr{
	height:40px;}
	#section table input[type=button]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table #btn{
	text-align:right;
	border-bottom-color:white;}
	#aaa{
	background:rgba(255, 205, 18, 0.1);}
</style>

<div id="section">
<h2>공지사항</h2>
<hr>
	<table align="center" border="1">
		<tr>
			<td colspan="2" id="title">제목</td>
			<td class="name">작성자</td>
			<td class="writeday">작성일</td>
		</tr>
	
<!-- 배경색을 넣기위해 추가한 내용
	<c:forEach items="${list }" var="gdto">
		<c:if test="${gdto.gubun==1 }">
		<tr id="aaa">
			<td id="img">
			<c:if test="${gdto.gubun==1 }">
				<img src="../img/gg.png" width="20">
			</c:if>	
			</td>
			<td>
				<a id="a1" href="content.jsp?id=${gdto.id }">${gdto.title }</a>
			</td>
			<td id="name">관리자</td>
			<td id="writeday">${gdto.writeday }</td>
		</tr>
		</c:if>
	</c:forEach>

	<c:forEach items="${list }" var="gdto">
	<c:if test="${gdto.gubun!=1 }">
		<tr>
			<td id="img">
			<c:if test="${gdto.gubun==1 }">
				<img src="../img/gg.png" width="20">
			</c:if>	
			</td>
			<td>
				<a id="a1" href="content.jsp?id=${gdto.id }">${gdto.title }</a>
			</td>
			<td id="name">관리자</td>
			<td id="writeday">${gdto.writeday }</td>
		</tr>
		</c:if>
	</c:forEach>
-->		
	<c:forEach items="${list }" var="gdto">
		<tr>
			<td id="img">
			<c:if test="${gdto.gubun==1 }">
				<img src="../img/gg.png" width="20">
			</c:if>	
			</td>
			<td>
				<a id="a1" href="content.jsp?id=${gdto.id }">${gdto.title }</a>
			</td>
			<td id="name">관리자</td>
			<td id="writeday">${gdto.writeday }</td>
		</tr>
	</c:forEach>
	
	<c:if test="${userid=='admin' }">
		<tr>
			<td colspan="4" id="btn">
				<input type="button" value="작성" onclick="location='write.jsp'">
			</td>
		</tr>
	</c:if>
	</table>
</div>

<c:import url="../bottom.jsp"/>