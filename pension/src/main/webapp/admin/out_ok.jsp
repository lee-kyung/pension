<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDao"%>
<%
AdminDao adao=new AdminDao();
adao.out_ok(request, response);
%>