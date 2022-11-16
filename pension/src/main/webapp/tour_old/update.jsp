<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.TourDao_old"%>
<%
TourDao_old tdao=new TourDao_old();
tdao.update(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:1000px;
	border-left:none;
	border-right:none;
	border-top-color:white;
	border-collapse:collapse;
	font-size:14px;}
	#section table td{
	border-left:none;
	border-right:none;
	height:40px;}
	#section table td:first-child, #readnum, #content{
	text-align:center;
	font-size:15px;
	font-weight:700;
	width:70px;}
	#section table #btn{
	text-align:right;}
	#section table #userid-size{
	width:450px;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table input[type=button], [type=submit]{
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table input[type=text]{
	width:98%;
	height:30px;
	outline:none;}
	#section table textarea{
	width:98%;
	height:85%;
	outline:none;
	resize:none;}
	#section table input[type=file]{
	display:none;}
	#section table img{
	margin-top:10px;}
	#section table label div{
	margin-top:10px;
	margin-bottom:10px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	cursor: pointer;
	display: flex;				/*flex가 있어야 상하좌우정렬이 가능??*/
	align-items: center;		/*상하정렬*/
	justify-content: center;	/*좌우정렬*/
	font-size:13px;}
</style>

<div id="section">
<h2>여행후기</h2>
<hr>
<form method="post" action="update_ok.jsp" enctype="multipart/form-data">
<input type="hidden" name="fname2" value="${tdto.fname }"}>
<input type="hidden" name="id" value="${tdto.id }">
<table align="center" border="1">
	<tr>
		<td>제목</td>
		<td colspan="3">
			<input type="text" name="title" value="${tdto.title }">
		</td>
	</tr>
	<tr>
		<td>작성자</td>
		<td id="userid-size">${tdto.userid }</td>
		<td id="readnum">조회수</td>
		<td>${tdto.readnum }</td>
	</tr>
	<tr>
		<td>사진</td>
		<td>
			<img src="img/${tdto.fname }" width="450">
			<label for="file"><div>첨부파일</div></label>
			<input type="file" name="fname" id="file">
		</td>
		<td id="content">내용</td>
		<td>
			<textarea name="content">${tdto.content }</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="4" id="btn">
			<input type="button" value="목록" onclick="location='list.jsp'">
			<input type="submit" value="수정">
		</td>
	</tr>
</table>
</form>
</div>
<c:import url="../bottom.jsp"/>