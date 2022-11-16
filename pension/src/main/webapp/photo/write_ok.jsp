<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.PhotoDao"%>
<%
PhotoDao pdao=new PhotoDao();
pdao.write_ok(request, response, session);
%>