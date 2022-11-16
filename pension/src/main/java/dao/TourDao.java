package dao;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.GongjiDto;
import dto.TourDto;

public class TourDao {

	PreparedStatement pstmt;
	Connection conn;
	
	public TourDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{
		String path=request.getRealPath("/tour/img");
		int size=1024*1024*10;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		// 여러개의 파일을 업로드 할 때 파일 이름을 가져온다
		Enumeration file=multi.getFileNames();
		// Enumeration은 자료저장소에서 데이터를 꺼내주는 역할을 하는 클래스 
		
		
		// 여러개의 파일이 존재
		// fname필드 => 파일1, 파일2, 파일3, ...
		String fname="";
		while(file.hasMoreElements())
		{			// hasmoreelements는 데이터를 꺼내기전에 더 꺼낼 데이터가 있는지 확인하는 메소드
			fname=fname+multi.getFilesystemName(file.nextElement().toString())+",";		// multi.getFilesystemName : 업로드한 파일이름을 가져온다
		}
			
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String userid=session.getAttribute("userid").toString();
		
		String sql="insert into tour(title, content, userid, fname, writeday) values(?,?,?,?,now())";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, userid);
		pstmt.setString(4, fname);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("list.jsp");
		
	}
	public void list(HttpServletRequest request) throws Exception
	{
		String sql="select *,substr(fname,1,instr(fname,',')-1) as img, length(fname)-length(replace(fname,',','')) as cnt from tour order by id desc";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		ArrayList<TourDto> list=new ArrayList<TourDto>();
		while(rs.next())
		{
			TourDto tdto=new TourDto();
			tdto.setId(rs.getInt("id"));
			tdto.setReadnum(rs.getInt("readnum"));
			tdto.setTitle(rs.getString("title"));
			tdto.setUserid(rs.getString("userid"));
			tdto.setWriteday(rs.getString("writeday"));
			tdto.setCnt(rs.getInt("cnt"));
			tdto.setImg(rs.getString("img"));
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
		tdto.setWriteday(rs.getString("writeday"));
		tdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		tdto.setId(rs.getInt("id"));
		
		// fname을 ','로 구분된 파일을 배열로 변경 후 dto에 file배열에 저장
		String[] file=rs.getString("fname").split(",");
		tdto.setFile(file);
		
		request.setAttribute("tdto", tdto);
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
		tdto.setId(rs.getInt("id"));
		tdto.setTitle(rs.getString("title"));
		tdto.setContent(rs.getString("content"));
		tdto.setReadnum(rs.getInt("readnum"));
		tdto.setWriteday(rs.getString("writeday"));		
		tdto.setUserid(rs.getString("Userid"));		
		tdto.setFile(rs.getString("fname").split(","));
		
		request.setAttribute("tdto", tdto);
		
	}
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String path=request.getRealPath("/tour/img");
		int size=1024*1024*10;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
	// 삭제할 파일 목록을 통해 파일을 삭제
		// 파일명1, 파일명2, 파일명3, ... 
		String[] del=multi.getParameter("del").split(",");
		
		for(int i=0; i<del.length; i++)
		{
			File file=new File(path+"/"+del[i]);
			if(file.exists())
				file.delete();
		}
		
	// 계속 보관할 파일
		String str=multi.getParameter("str");
	
	// 새로 업로드 되는 파일의 이름을 저장
		Enumeration file=multi.getFileNames();	// 업로드폼에 있는 input 태그의 이름목록
		
		String fname="";
		while(file.hasMoreElements())
		{
			fname=fname+multi.getFilesystemName(file.nextElement().toString())+",";
		}
		
	// null값 없애기
		fname=fname.replace("null", "");
	
	// 합치기
		fname=fname+str;
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String id=multi.getParameter("id");
		
		String sql="update tour set title=?, content=?, fname=? where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, fname);
		pstmt.setString(4, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("content.jsp?id="+id);
		
	}
	
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		// 삭제할 레코드와 관련된 그림파일 삭제하기
		String sql="select fname from tour where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		// 파일명1, 파일명2, 파일명3
		String[] fname=rs.getString("fname").split(",");
		String path=request.getRealPath("/tour/ing");
		
		for(int i=0; i<fname.length; i++)
		{
			File file=new File(path+"/"+fname[i]);
			if(file.exists())
				file.delete();
		}
		
		sql="delete from tour where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("list.jsp");
	}
	public void getThree(HttpServletRequest request) throws Exception
	{
		String sql="select * from tour order by id desc limit 3";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		ArrayList<TourDto> tlist=new ArrayList<TourDto>();	
		while(rs.next()) 
		{
			TourDto tdto=new TourDto();
			tdto.setId(rs.getInt("id"));

			if(rs.getString("title").length()>13)
				tdto.setTitle(rs.getString("title").substring(0,11)+"···");
			
			else
				tdto.setTitle(rs.getString("title"));
			
			tdto.setWriteday(rs.getString("writeday"));

			tlist.add(tdto);    	   
		}   	
		request.setAttribute("tlist", tlist);
	}
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
	
}
