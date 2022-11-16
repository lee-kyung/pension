package dao;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.BoardDto;
import dto.GongjiDto;

public class GongjiDao {
	
	PreparedStatement pstmt;
	Connection conn;
	
	public GongjiDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		
		String gubun;
		if(request.getParameter("gubun")==null)
			gubun="0";
		else
			gubun=request.getParameter("gubun");
		
		String sql="insert into gongji(title, content, gubun, writeday) values(?,?,?,now())";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, gubun);
		
		pstmt.executeUpdate();
		close();
		response.sendRedirect("list.jsp");
	}
	
	public void list(HttpServletRequest request) throws Exception
	{
		String sql="select * from gongji order by gubun desc, id desc";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<GongjiDto> list=new ArrayList<GongjiDto>();
		
		while(rs.next())
		{
			GongjiDto gdto=new GongjiDto();
			gdto.setTitle(rs.getString("title"));
			gdto.setId(rs.getInt("id"));
			gdto.setWriteday(rs.getString("writeday"));
			gdto.setGubun(rs.getInt("gubun"));
			
			list.add(gdto);
		}
		request.setAttribute("list", list);
		
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select * from gongji where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		GongjiDto gdto=new GongjiDto();
		gdto.setTitle(rs.getString("title"));
		gdto.setId(rs.getInt("id"));
		gdto.setContent(rs.getString("content").replace("\r\n", "<br"));
		gdto.setWriteday(rs.getString("writeday"));
		gdto.setGubun(rs.getInt("gubun"));
		
		request.setAttribute("gdto", gdto);	
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String sql="delete from gongji where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("list.jsp");
	}
	
	public void update(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select * from gongji where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		GongjiDto gdto=new GongjiDto();
		gdto.setTitle(rs.getString("title"));
		gdto.setGubun(rs.getInt("gubun"));
		gdto.setContent(rs.getString("content"));
		gdto.setId(rs.getInt("id"));
		
		request.setAttribute("gdto", gdto);
	}
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String gubun;
		if(request.getParameter("gubun")==null)
			gubun="0";
		else
			gubun=request.getParameter("gubun");
		
		String sql="update gongji set title=?, content=?, gubun=? where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, gubun);
		pstmt.setString(4, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void getThree(HttpServletRequest request) throws Exception
	{
		String sql="select * from gongji order by id desc limit 3";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		ArrayList<GongjiDto> glist=new ArrayList<GongjiDto>();	
		while(rs.next()) 
		{
			GongjiDto gdto=new GongjiDto();
			gdto.setId(rs.getInt("id"));
			
			if(rs.getString("title").length()>13)
				gdto.setTitle(rs.getString("title").substring(0,11)+"···");
			
			else
				gdto.setTitle(rs.getString("title"));
			
			gdto.setWriteday(rs.getString("writeday"));

			glist.add(gdto);    	   
		}   	
		request.setAttribute("glist", glist);
	}
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
}
