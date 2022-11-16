<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;
	margin-bottom:100px;}
	#section table{
	margin-top:100px;
	font-size:14px;}
	
	#section table img{
	width:540px;
	height:350px;}
	#section table td{
	padding-bottom:50px;}
</style>

<div id="section">
<h2>주변 여행지</h2>
<hr>

<table>
	<tr>
		<td><img src="../img/beach.jpg"></td>
		<td><b>해수욕장</b><p>
			차타고 10분거리에 위치<p>
			대한민국을 대표하는 해수욕장으로 해수욕뿐만아니라 다양하고 독특한 먹을거리, 볼거리들이 있다.</td>
	</tr>
	
	<tr>
		<td align="right"><b>산토리니</b><p>
			차타고 20분거리에 위치<p>
			화산작용으로 형성된 아름다운 풍경과 화려한 밤 문화가 있는 곳이다.</td>
		<td><img src="../img/santorini.jpg"></td>
	</tr>
	
	<tr>
		<td><img src="../img/lake.jpg"></td>
		<td><b>호수</b><p>
			차타고 10분거리에 위치<p>
			수목, 잔디광장, 인공섬, 자연학습원, 어린이 놀이터 등 다양한 시설을 갖추고 있다.</td>
	</tr>

	<tr>
		<td align="right"><b>수목원</b><p>
			차타고 20분거리에 위치<p>
			약 5,000여 종의 식물을 관람할 수 있고 총 10만평의 면적으로 이루어져 있다.</td>
		<td><img src="../img/arboretum.jpg"></td>
	</tr>

	<tr>
	<td><img src="../img/cable.jpg"></td>
		<td><b>케이블카</b><p>
			차타고 10분거리에 위치<p>
			대한민국에서 가장 긴 케이블카로 관광명소 3위를 차지하였다.</td>
		
	</tr>

	<tr>
		<td align="right"><b>열기구</b><p>
			차타고 20분거리에 위치<p>
			비행시간은 대략 15분으로 한눈으로 도심을 즐길 수 있다.</td>
		<td><img src="../img/balloon.jpg"></td>
	</tr>
	
</table>

</div>
<c:import url="../bottom.jsp"/>