<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<%@ page import="dao.AdminDao" %>
<%
AdminDao adao=new AdminDao();
adao.room_view(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#content_layer{
	position:absolute;}
	#section table{
	width:900px;
	font-size:14px;
	text-align:center;
	margin-top:30px;
	border-collapse:collapse;
	border-left:none;
	border-right:none;
	border-top-color:white;}
	#section table td{
	border-left:none;
	border-right:none;}
	#section table td{
	height:30px;}
	#section table tr:first-child{
	font-size:15px;
	font-weight:600;}
	#section table tr:last-child{
	text-align:right;
	border-bottom-color:white;}
	#section table td:first-child{
	width:250px;}
	#section table .btn{
	width:99%;
	height:98%;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	cursor:pointer;}
	#section table #btn{
	margin-top:10px;
	width:150px;
	height:50px;
	background:#FFFFD2;
	border:1px solid #FFFF48;
	cursor:pointer;}
</style>
<script>
	var k=0;
	
	function content_view(id)
	{
		var top=event.pageY;
		var left=event.pageX;
		
		var chk=new XMLHttpRequest();
		chk.open("get","content_view.jsp?id="+id);
		chk.send();
		chk.onreadystatechange=function()
		{
			if(chk.readyState==4)
			{
				document.getElementById("content_layer").innerHTML=chk.responseText;
				// db에 있는 content를 받기 위해서 chk.responseText 필요
				// innerHTML은 content_view.jsp에서 작성한 style을 받기 위해서 필요 
				
				document.getElementById("content_layer").style.top=top+"px";
				document.getElementById("content_layer").style.left=left+"px";
				k=1;
			}
		}
		if(k==0)
			document.getElementById("content_layer").style.display="block";
	}
	
	function content_hide()
	{
		if(k==1)
		{
			document.getElementById("content_layer").style.display="none";
			k=0;
		}
		
	}

</script>
<div id="content_layer"></div>
<div id="section">
<h2>방 정보</h2>
<hr>
<table border="1" align="center">
	<tr>
		<td>방 이름</td>
		<td>최소인원</td>
		<td>최대인원</td>
		<td>1박 가격</td>
		<td>상 태</td>
		<td colspan="2"></td>
	</tr>
	
	<c:forEach items="${rlist }" var="rdto">
	<tr>				<!-- id값이 필요하기 때문에 매개변수로 전달 (필요한 이유:db를 불러와야하기때문에) -->
		<td onmouseover="content_view(${rdto.id})" onmouseout="content_hide()">${rdto.bang }</td>
		<td>${rdto.min }</td>
		<td>${rdto.max }</td>
		<td><fmt:formatNumber value="${rdto.price }"/></td>
		
		<c:if test="${rdto.state==0 }">
		<td>정상운영</td>
		</c:if>
		
		<c:if test="${rdto.state==1 }">
		<td>공사중</td>
		</c:if>
		
		<td><input type="button" value="수정" class="btn" onclick="location='room_update.jsp?id=${rdto.id}'"></td>
		<td><input type="button" value="삭제" class="btn" onclick="if(confirm('삭제하시겠습니까?')) location='room_delete.jsp?id=${rdto.id}'"></td>
	</tr>
	</c:forEach>
	
	<tr>
		<td colspan="7">
			<input type="button" value="객실추가" id="btn" onclick="location='room_input.jsp'">	
		</td>
	</tr>
	

</table>

</div>
<script>

</script>
<c:import url="../bottom.jsp"/>