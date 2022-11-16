package dao;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.colorchooser.ColorSelectionModel;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.PhotoDto;

public class PhotoDao2 {

	PreparedStatement pstmt;
	Connection conn;
	
	public PhotoDao2() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{
		String path=request.getRealPath("/photo/img");
		int size=1024*1024*10;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		Enumeration file=multi.getFileNames();
		
		String pwd=multi.getParameter("pwd");
		String userid;
		if(session.getAttribute("userid")==null)
		{
			userid="guest";
		}
		else
		{
			userid=session.getAttribute("userid").toString();
		}
		String fname="";
		while(file.hasMoreElements())
		{
			fname=fname+multi.getFilesystemName(file.nextElement().toString())+",";
		}
		String sql="insert into photo(fname, userid, pwd, writeday) values(?, ?, ?,now())";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, fname);
		pstmt.setString(2, userid);
		pstmt.setString(3, pwd);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("list.jsp");
	}
	
	public void list(HttpServletRequest request) throws Exception
	{
		String sql="select * from photo order by id desc";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		ArrayList<PhotoDto> plist=new ArrayList<PhotoDto>();
		while(rs.next())
		{
			PhotoDto pdto=new PhotoDto();
			pdto.setId(rs.getInt("id"));
			pdto.setUserid(rs.getString("userid"));
			pdto.setWriteday(rs.getString("writeday"));
			
			String[]file=rs.getString("fname").split(",");
			pdto.setFile(file);
			
			plist.add(pdto);
		}
		request.setAttribute("plist", plist);
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		
		
		if(request.getParameter("pwd")==null)
		{
			String sql="delete from photo where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
			String path=request.getRealPath("/photo/img");
			String fname=request.getParameter("fname");
			File file=new File(path+"/"+fname);
			if(file.exists())
				file.delete();
			
			close();
			response.sendRedirect("list.jsp");
		}
		else
		{
			String pwd=request.getParameter("pwd");
			String sql="select pwd from photo where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			String dbpwd=rs.getString("pwd");
			
			if(pwd.equals(dbpwd))
			{
				sql="delete from photo where id=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				
				String path=request.getRealPath("/photo/img");
				String fname=request.getParameter("fname");
				File file=new File(path+"/"+fname);
				if(file.exists())
					file.delete();
				
				close();
				response.sendRedirect("list.jsp");
			}
			else
			{
				close();
				response.sendRedirect("list.jsp");
			}
		}
		
	}
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
}
