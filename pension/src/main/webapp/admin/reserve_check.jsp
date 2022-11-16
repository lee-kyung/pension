<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.AdminDao"%>
<%
AdminDao adao=new AdminDao();
adao.reserve_check(request);
%>
<c:import url="../top.jsp"/> 
<style>
	#section{
	width:1100px;
	margin:auto;
	margin-top:0px;}
	#section table{
	width:900px;
	text-align:center;
	font-size:14px;
	margin-top:50px;
	border-collapse:collapse;
	border-left:none;
	border-right:none;
	border-top-color:white;}
	#section table td{
	border-left:none;
	border-right:none;
	height:25px;}
	#section table tr:first-child{
	font-size:15px;
	font-weight:600;}
	#section table td:nth-child(5){
	width:80px;}
</style>

<div id="section">
<h2>예약현황</h2>
<hr>
<table align="center" border="1">
	<tr>	
		<td>예약자</td>
		<td>입실일</td>
		<td>퇴실일</td>
		<td>인 원</td>
		<td>숯 패키지</td>
		<td>BBQ</td>
		<td>결제금액</td>
		<td>객실명</td>
		<td>예약일</td>
		<td>상태</td>
	</tr>
	<c:forEach items="${rlist }" var="rdto">
	<tr>
		<td>${rdto.userid }</td>
		<td>${rdto.inday }</td>
		<td>${rdto.outday }</td>
		<td>${rdto.inwon }</td>
		<td>${rdto.charcoal }</td>
		<td>${rdto.bbq }</td>
		<td>${rdto.total }</td>
		<td>${rdto.bang }</td>
		<td>${rdto.writeday }</td>
		
	<c:if test="${rdto.state==0}">
		<td>예약완료</td>
	</c:if>
	<c:if test="${rdto.state==1}">
		<td><a href="reserve_cancel.jsp?id=${rdto.id }">예약취소중</a></td>
	</c:if>
	<c:if test="${rdto.state==2}">
		<td>취소완료</td>
	</c:if> 
	<c:if test="${rdto.state==3}">
		<td>사용완료</td>
	</c:if>
	
	</tr>
	</c:forEach>
</table>

</div>
<c:import url="../bottom.jsp"/>