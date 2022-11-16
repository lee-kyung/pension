<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../top.jsp"/>	
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}

	#wel{
	font-family:fantasy;
	font-size:130px;
	margin-left:90px;}
	#ss{
	font-family:fantasy;
	font-size:80px;}
	#emp{
	height:100px;}
	.text1{
	font-size:13px;
	text-align:center;}
	#pic1{
	width:500px;}
	#name{
	text-align:right;
	font-weight:700;
	font-family:fantasy;
	font-size:50px;}
	table{
	width:1100px;}
	#size1{
	width:400px;}
	#size3{
	width:300px;}
	#pic2{
	width:300px;}
	#text2{
	font-size:20px;
	text-align:right;
	font-family:굴림체;}
	#pic3{
	width:400px;}
	#pic4{
	width:300px;}
	#pic5{
	width:300px;}
	#section table tr:last-child{
	height:700px;}
	

</style>

<div id="section">
<h2>펜션소개</h2>
<hr>
<span><img src="../img/a.png" id="pic1"></span>
<span id="wel">WELCOME</span><p>
<div class="text1">
	분주하고 지친 도시인에게 일상탈출을 위한 특별한 휴식처에 오신 것을 환영합니다. <p>
	모던하고 심플한 객실스타일로 힐링과 편안함을 제공합니다. <p>
	다양하고 특별한 부대시설이 준비되어 있습니다. <p>
	반려견과 함께 즐겁고 행복한 추억을 만들어가세요. <p>
</div>
<div id="emp"></div>
<div id="ss">SOMETHING SPECIAL</div>
<div id="name">
	이거석<img src="../img/gs.jpg" width="50"> 
	오태식<img src="../img/ts.jpg" width="50">
</div>

<table>
<tr>	
	<td id="size1"></td>
	<td></td>
	<td id="size3"><img src="../img/a1.jpg" id="pic2"></td>
</tr>
<tr>	
	<td><img src="../img/a2.jpg" id="pic3"></td>
	<td></td>
	<td></td>
</tr>
<tr>	
	<td></td>
	<td></td>
	<td><img src="../img/a3.jpg" id="pic4"></td>
</tr>
<tr>	
	<td><img src="../img/a4.jpg" id="pic5"></td>
	<td><img src="../img/a6.jpg" id="pic5"></td>
	<td><img src="../img/a5.jpg" id="pic5"></td>
</tr>
</table>


</div>
<c:import url="../bottom.jsp"/>    