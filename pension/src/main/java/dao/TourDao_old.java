package dao;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.TourDto;

public class TourDao_old {
	
	PreparedStatement pstmt;
	Connection conn;
	
	public TourDao_old() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{
		// 파일 업로드 객체생성
		String path=request.getRealPath("/tour/img");
		int size=1024*1024*10;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String fname=multi.getFilesystemName("fname");
		String userid=session.getAttribute("userid").toString();
		
		String sql="insert into tour(title, content, fname, userid, writeday) values(?,?,?,?, now())";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, fname);
		pstmt.setString(4, userid);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("list.jsp");
	}
	
	public void list(HttpServletRequest request) throws Exception 
	{
		String sql="select * from tour order by id desc";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<TourDto> list=new ArrayList<TourDto>();
		while(rs.next())
		{
			TourDto tdto=new TourDto();
			tdto.setId(rs.getInt("id"));	// readnum으로 넘어가기 위해서 id값이 필요하다. 
			tdto.setFname(rs.getString("fname"));
			tdto.setTitle(rs.getString("title"));
			tdto.setReadnum(rs.getInt("readnum"));
			tdto.setUserid(rs.getString("userid"));
			tdto.setWriteday(rs.getString("writeday"));
			
		
			list.add(tdto);
		}
		request.setAttribute("list", list);
	}
	
	public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String sql="update tour set readnum=readnum+1 where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select * from tour where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		TourDto tdto=new TourDto();
		tdto.setTitle(rs.getString("title"));
		tdto.setUserid(rs.getString("userid"));
		tdto.setReadnum(rs.getInt("readnum"));
		tdto.setFname(rs.getString("fname"));
		tdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		tdto.setId(rs.getInt("id"));
		request.setAttribute("tdto", tdto);
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String sql="delete from tour where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		String path=request.getRealPath("/tour/img");
		String fname=request.getParameter("fname");
		File file=new File(path+"/"+fname);
		if(file.exists())
			file.delete();
		
		close();
		response.sendRedirect("list.jsp");
	}
	
	public void update(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select * from tour where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		TourDto tdto=new TourDto();
		tdto.setTitle(rs.getString("title"));
		tdto.setUserid(rs.getString("userid"));
		tdto.setReadnum(rs.getInt("readnum"));
		tdto.setFname(rs.getString("fname"));
		tdto.setContent(rs.getString("content"));
		tdto.setId(rs.getInt("id"));
		request.setAttribute("tdto", tdto);
	}
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String path=request.getRealPath("/tour/img");
		int size=1024*1024*10;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		String id=multi.getParameter("id");
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String fname=multi.getFilesystemName("fname");
		String fname2=multi.getParameter("fname2"); // 기존의 그림파일명
		
		if(fname==null)
		{
			String sql="update tour set title=?, content=? where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, id);
			pstmt.executeUpdate();
			close();
			response.sendRedirect("content.jsp?id="+id);
		}
		else
		{
			String sql="update tour set title=?, content=?, fname=? where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, fname);
			pstmt.setString(4, id);
			
			File file=new File(path+"/"+fname2);
			if(file.exists())
				file.delete();
			
			pstmt.executeUpdate();
			close();
			response.sendRedirect("content.jsp?id="+id);
		}
		
	}
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
}
