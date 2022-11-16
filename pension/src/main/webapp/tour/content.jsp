<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.TourDao"%>
<% 
TourDao tdao=new TourDao();
tdao.content(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
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
	#section table #writeday-size{
	width:400px;}
	#section table #content{
	height:250px;}
	#section table #btn{
	text-align:right;}
	#section table #userid-size{
	width:500px;}
	#section table tr:last-child{
	border-bottom-color:white;}
	#section table input[type=button]{
	margin-top:20px;
	width:100px;
	height:30px;
	background:#FFFFD2;
	border:1px solid #FFFF48;}
	#section table img{
	padding-top:10px;
	padding-bottom:10px;}
	#zoom_id {
     position:absolute;
     visibility:hidden;}
     #mo{
     position:absolute;
     left:0px;
     top:0px;
     width:100%;
     height:100%;
     visibility:hidden;
     background:rgba(240,240,240,0.6);}
     
</style>
<script>
	function zoom(my)
	{   
		// 배경창 보이기
		document.getElementById("mo").style.visibility="visible";
		
		// 사진 보이기
		document.getElementById("zoom_id").style.visibility="visible";
		document.getElementById("zoom_img").src=my;
		center_img();
	}
	function center_img()
	 {	// 브라우저의 가로가 1000px이상인 경우에만 동작
		 if(innerWidth>1000) 
		 {	 
		 // 그림을 브라우저의 가로기준으로 중앙에 배치
			var w=(innerWidth-800)/2;
		 	document.getElementById("zoom_id").style.left=w+"px";
		 	
		 	document.getElementById("zoom_id").style.top=100+"px";
		 }
	 }
	function hide_img(my)
	{	
		// 배경창 닫기
		document.getElementById("mo").style.visibility="hidden";
		
		// 사진 닫기
		my.style.visibility="hidden";
	}
	
	// 브라우저 크기에 따라 적용
	window.onresize=center_img;
	
</script>
<div id="mo">
	<div id="zoom_id" onclick="hide_img(this)">
		<img id="zoom_img" width="800">
	</div>
</div>
<div id="section">
<h2>여행후기</h2>
<hr>
<table align="center" border="1">
	<tr>
		<td>제목</td>
		<td colspan="3">${tdto.title }</td>
	</tr>
	<tr>
		<td>작성자</td>
		<td id="userid-size" colspan="3">${tdto.userid }</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td id="writeday-size">${tdto.writeday }</td>
		<td id="readnum">조회수</td>
		<td>${tdto.readnum }</td>
	</tr>
	
	<tr>
		<td id="content">내용</td>
		<td colspan="3">${tdto.content }</td>		
	</tr>
	<tr>
		<td>사진</td>
		<td colspan="3"> <!-- tdto.file => 배열 -->	
			
			<c:forEach items="${tdto.file}" var="my">
			<c:if test="${my != 'null'}">
				<img src="img/${my}" width="200" onclick="zoom(this.src)">
			</c:if>	
			</c:forEach>	
			
		</td>
	</tr>
	<tr>
		<td colspan="4" id="btn">
			<input type="button" value="목록" onclick="location='list.jsp'">
		<!-- 회원본인의 글일 경우 -->
		<c:if test="${userid==tdto.userid || userid=='admin'}">
			<input type="button" value="수정" onclick="location='update.jsp?id=${tdto.id}&fname=${tdto.fname }'">
			<input type="button" value="삭제" onclick="location='delete.jsp?id=${tdto.id}&fname=${tdto.fname}'">
		</c:if>
		</td>
	</tr>
</table>
</div>
<c:import url="../bottom.jsp"/>