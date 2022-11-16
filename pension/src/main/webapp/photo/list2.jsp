<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.PhotoDao"%>

<% 
PhotoDao pdao=new PhotoDao();
pdao.list(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section ul{
	display:inline-block;
	list-style-type:none;
	margin-left:-24px;}
	#zoom{
	position:absolute;
	visibility:hidden;
	}
	#background{
	position:absolute;
	left:0px;
	top:0px;
	width:100%;
	height:100%;
	background:rgba(240,240,240,0.6);
	visibility:hidden;
	z-index:2}
	#icon{
	position:absolute;
	margin-left:230px;
	z-index:1}
	#btn{
	text-align:right;}
</style>
<script>

	document.logined.submit();

	function zoom(my)
	{
		document.getElementById("background").style.visibility="visible";	
		document.getElementById("zoom").style.visibility="visible";
		document.getElementById("zoom_in").src=my;
		
//		var photo = '<c:out value='${my}'/>';
//		document.getElementById("zoom_out").src="img/"+photo;			
		
		center_img();
		
	}
	
	function center_img()
	{
		if(innerWidth>1000)
		{
			var w=(innerWidth-800)/2;
			document.getElementById("zoom").style.left=w+"px";
			document.getElementById("zoom").style.top=100+"px";			
		}
	}
	
	function hide_img(my)
	{
		document.getElementById("background").style.visibility="hidden";
		my.style.visibility="hidden";
	}
	
	window.onresize=center_img;
</script>

<div id="section">
<h2>사진첩</h2>
<hr>



<c:forEach items="${plist }" var="pdto">		<!-- 메인사진1, 아이디, 작성일 -->

<ul>
	
<c:if test="${pdto.cnt >= 2}">

	<li><div id="aa"><img src="../img/icon2.JPG" width="20" height="20" id="icon"></div></li>
</c:if>
	<li><img src="img/${pdto.img}" width="250" height="160" onclick="zoom(this.src)"></li>
	
	<li>&emsp;${pdto.userid } &emsp;&emsp;&emsp;&emsp;&emsp; ${pdto.writeday }</li>
		
</ul>









<div id="background">


<c:forEach items="${pdto.file }" var="my">		<!-- 서브사진 -->		

	<div id="zoom" onclick="hide_img(this)">
	<div id="btn">
		<input type="button" value="수정" onclick="location='update.jsp?id=${pdto.id}&fname=${my}'">
		<input type="button" value="삭제" onclick="location='delete.jsp?id=${pdto.id}&fname=${my}'">
	</div>
		<img id="zoom_in" width="800">
	</div>
	
	<div>
		<img width="250" height="160" id="zoom_out" src="img/${my}">
	</div>
	

	
</c:forEach>

</div>



</c:forEach>



</div>
<c:import url="../bottom.jsp"/>
