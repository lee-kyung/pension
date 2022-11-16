package dao;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.BoardDto;

public class BoardDao {

	PreparedStatement pstmt;
	Connection conn;
	
	public BoardDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void write_ok(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception
	{					// userid필드때문에 session이 필요함
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String pwd=request.getParameter("pwd");
		String content=request.getParameter("content");
		
		// 비밀번호 => 회원인 경우는 필요하지 않음, 비회원일 경우 비밀번호 작성
		
		// board 테이블의 userid는 로그인 한 경우 세션변수의 userid를 넣기
		// 로그인하지 않은 경우는 guest 값을 주기(회원일 경우 비밀번호 값이 null이여도 상관 없다.)
		String userid;
		if(session.getAttribute("userid")==null)	// 비회원인 경우
		{
			userid="guest";
		}
		else	// 회원인 경우 
		{
			userid=session.getAttribute("userid").toString();
		}
		
		String sql="insert into board(title, pwd, content, userid, writeday) values(?,?,?,?, now())";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, pwd);
		pstmt.setString(3, content);
		pstmt.setString(4, userid);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("list.jsp");
	}
	public void list(HttpServletRequest request) throws Exception
	{
		String sql="select * from board order by id desc";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		// 여러개의 dto를 담을 수 있는 arraylist 생성
		ArrayList<BoardDto> list=new ArrayList<BoardDto>();
		
		// rs에 있는 레코드를 dto에 저장 => arraylist에 담기
		while(rs.next())
		{
			BoardDto bdto=new BoardDto();
			bdto.setId(rs.getInt("id"));
			bdto.setTitle(rs.getString("title"));
			bdto.setUserid(rs.getString("userid"));
			bdto.setReadnum(rs.getInt("readnum"));
			bdto.setWriteday(rs.getString("writeday"));
		
			list.add(bdto);
		}
		
		// 내장객체 영역에 list저장
		request.setAttribute("list", list);
		
	}
	
	public void readnum(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String sql="update board set readnum=readnum+1 where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("content.jsp?id="+id);
	}
	
	public void content(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select * from board where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		BoardDto bdto=new BoardDto();
		bdto.setId(rs.getInt("id"));
		bdto.setTitle(rs.getString("title"));
		bdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		bdto.setUserid(rs.getString("userid"));
		bdto.setReadnum(rs.getInt("readnum"));
		bdto.setWriteday(rs.getString("writeday"));
		
		request.setAttribute("bdto", bdto);
	}
	public void delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{	
		// 회원이 삭제한 경우 id값만 가져온다
		if(request.getParameter("pwd")==null)
		{
			String id=request.getParameter("id");
			String sql="delete from board where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			close();
			response.sendRedirect("list.jsp");
		}
		
		// 비회원이 삭제한 경우 id, pwd값을 가져온다. 
		else
		{
			String id=request.getParameter("id");
			String pwd=request.getParameter("pwd");
			String sql="select pwd from board where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			String dbpwd=rs.getString("pwd");
			if(pwd.equals(dbpwd))
			{
				sql="delete from board where id=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				close();
				response.sendRedirect("list.jsp");
			}
			else
			{
				close();
				response.sendRedirect("content.jsp?id="+id);
			}
		}
	}
	
	public void update(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select * from board where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		BoardDto bdto=new BoardDto();
		bdto.setTitle(rs.getString("title"));
		bdto.setUserid(rs.getString("userid"));
		bdto.setContent(rs.getString("content"));
		bdto.setReadnum(rs.getInt("readnum"));
		bdto.setWriteday(rs.getString("writeday"));
		bdto.setId(rs.getInt("id"));
		
		request.setAttribute("bdto", bdto);
	}
	
	public void update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		String title=request.getParameter("title");
		String pwd=request.getParameter("pwd");
		String content=request.getParameter("content");
		
		// 회원인 경우
		if(request.getParameter("pwd")==null)
		{
			String sql="update board set title=?, content=? where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, id);
			pstmt.executeUpdate();
			close();
			response.sendRedirect("content.jsp?id="+id);
		}
		
		// 비회원인 경우
		else
		{
			String sql="select pwd from board where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			String dbpwd=rs.getString("pwd");
			
			if(pwd.equals(dbpwd))
			{
				sql="update board set title=?, content=? where id=?";
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
				close();
				response.sendRedirect("update.jsp?id="+id);
			}
			
		}
	}
	
	public void getThree(HttpServletRequest request) throws Exception
	{
			String sql="select * from board order by id desc limit 3";
			pstmt=conn.prepareStatement(sql);
			ResultSet rs=pstmt.executeQuery();
			ArrayList<BoardDto> blist=new ArrayList<BoardDto>();	
			while(rs.next()) 
			{
				BoardDto bdto=new BoardDto();
				bdto.setId(rs.getInt("id"));
				
				if(rs.getString("title").length()>13)
					bdto.setTitle(rs.getString("title").substring(0,11)+"···");
				
				else
					bdto.setTitle(rs.getString("title"));
				
				bdto.setWriteday(rs.getString("writeday"));

				blist.add(bdto);    	   
			}   	
			request.setAttribute("blist", blist);
	}	
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
}
