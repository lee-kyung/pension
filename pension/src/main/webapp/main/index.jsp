<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.BoardDao" %>
<%@ page import="dao.GongjiDao" %>
<%@ page import="dao.TourDao" %>
<%
GongjiDao gdao=new GongjiDao();
gdao.getThree(request);

BoardDao bdao=new BoardDao();
bdao.getThree(request);

TourDao tdao= new TourDao();
tdao.getThree(request);
%>

<c:import url="../top.jsp"/> 	<!-- ../ : 상위폴더 -->
	
	<div id="third"><img src="../img/1-1.jpg" width="1100" height="400"></div>
	
	<div id="fourth">
		
		<div id="gongji">
		<b onclick="location='../gongji/list.jsp'">공지사항</a></b><p>
		<hr>
			<table>
			<c:forEach items="${glist }" var="gdto"> 
			<tr>
				<td><a href="../gongji/content.jsp?id=${gdto.id }">${gdto.title }</a></td>
				<td class="writeday">${gdto.writeday }</td>
			</tr>	
			</c:forEach>
			</table>
		</div>
		
		<div id="tour">
		<b onclick="location='../tour/list.jsp'">여행후기</b><p>
		<hr>
			<table>
			<c:forEach items="${tlist }" var="tdto"> 
			<tr>
				<td><a href="../tour/readnum.jsp?id=${tdto.id }">${tdto.title }</a></td>
				<td class="writeday">${tdto.writeday }</td>
			</tr>	
			</c:forEach>
			</table>
		</div>
		
		<div id="board">
		<b onclick="location='../board/list.jsp'">게시판</b><p>
		<hr>
			<table>
			<c:forEach items="${blist }" var="bdto"> 
			<tr>
				<td><a href="../board/readnum.jsp?id=${bdto.id }">${bdto.title }</a></td>
				<td class="writeday">${bdto.writeday }</td>
			</tr>	
			</c:forEach>
			</table>
		</div>
	</div>
<!-- 
	<div id="fifth">
	
		<div id="e1">이벤트1</div>
		<div id="e2">이벤트2</div>
		<div id="e3">이벤트3</div>
		<div id="e4">이벤트4</div>
		<div id="e5">이벤트5</div>
	</div>	
 -->
 	
<c:import url="../bottom.jsp"/>