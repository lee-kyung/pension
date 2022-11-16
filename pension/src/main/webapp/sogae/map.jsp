<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;
	margin-bottom:100px;
	font-size:14px;}
	#section img{
	margin-top:100px;
	width:500px;}
	#section li{
	display:inline-block;}
	#section #text{
	position:absolute;
	margin-top:400px;
	margin-left:50px;}
</style>

<div id="section">
<h2>오시는 길</h2>
<hr>

<ul>
	<li>
		<img src="../img/map_01.jpg">
	</li>
	<li id="text">
		<b>!! 오시는 길 !!</b><p>
		<br>
		※ 차량을 이용한 경우 <p>

		강원도 속초시 우리동 이쁜리 100번지<p>
		<br>
		※ 대중교통을 이용한 경우<p>

		이거 타고 저거 타고 몇번버스 타고 알아서 어쩌구 저쩌구 올라오시면 됩니당<p>
	</li>
</ul>

</div>

<c:import url="../bottom.jsp"/>