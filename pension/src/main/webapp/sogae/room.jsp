<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="dao.AdminDao"%>
<%
AdminDao adao=new AdminDao();
adao.room_view(request);	// list
adao.room_update(request);	// rdto
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
	border-collapse:collapse;
	border-left:none;
	border-right:none;
	text-align:center;
	font-size:14px;
	margin-top:50px;}
	#section table td{
	height:50px;
	border-left:none;
	border-right:none;}
	#section table tr:first-child{
	font-size:15px;
	font-weight:600;}
	
	#section #ul li{
	display:inline-block;
	width:130px;}
	#section #ul li a{
	text-decoration:none;
	color:black;}
	
	#section #room{
	margin-top:100px;
	margin-bottom:100px;}
	#section #room{
	text-align:center;}
	#section #room li{
	list-style-type:none;}
	#section #room .aa{
	margin-left:550px;}
	#section #room .bb{
	margin-left:-550px;
	margin-top:-200px;}
</style>

<div id="section">
<h2>${rdto.bang }</h2>
<hr>
<ul id="ul">

<c:forEach items="${rlist }" var="rdto">
	<li><a href="room.jsp?id=${rdto.id }">${rdto.bang }</a></li>
</c:forEach>	

</ul>
<hr>


<table border="1" align="center">
	<tr>
		<td>객실명</td>
		<td>최소인원</td>
		<td>최대인원</td>
		<td>방 구조</td>
		<td>비용</td>
	</tr>
	<tr>
		<td>${rdto.bang}</td>
		<td>${rdto.min }</td>
		<td>${rdto.max }</td>
		<td>${rdto.type }</td>
		<td><fmt:formatNumber value="${rdto.price }" type="number"/></td>
	</tr>
	<tr height="100">
		<td><b>내용</b></td>
		<td colspan="4" align="left" style="padding-left:30px;">${rdto.content }</td>
	</tr>
</table>

<div id="room">
<ul>
	<li><img class="aa" src="../img/${rdto.bang }_01.jpg" width="500"></li>
	<li><img class="bb" src="../img/${rdto.bang }_02.jpg" width="500"></li>
	<li><img class="aa" src="../img/${rdto.bang }_03.jpg" width="500" style="padding-top:200px;"></li>
	<li><img class="bb" src="../img/${rdto.bang }_04.jpg" width="500"></li>
</ul>

</div>
</div>
<c:import url="../bottom.jsp"/>
