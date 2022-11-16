package dao;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.http.HttpRequest;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import dto.MemberDto;
import dto.ReserveDto;
import dto.RoomDto;

public class AdminDao {

	PreparedStatement pstmt;
	Connection conn;
	
	public AdminDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	// room 테이블의 내용을 읽어와서 출력
	public void room_view(HttpServletRequest request) throws Exception
	{
		String sql="select * from room order by price asc";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
		
		while(rs.next())
		{
			RoomDto rdto=new RoomDto();
			rdto.setId(rs.getInt("id"));
			rdto.setBang(rs.getString("bang"));
			rdto.setMax(rs.getInt("max"));
			rdto.setMin(rs.getInt("min"));
			rdto.setPrice(rs.getInt("price"));
			rdto.setState(rs.getInt("state"));
			
			rlist.add(rdto);
		}
		
		request.setAttribute("rlist", rlist);
	}
	
	public String content_view(JspWriter out, HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select content from room where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		// ajax를 호출한 javascript로 전달됨 (리턴하지 않고 사용)
		// out.print(rs.getString("content"));
		
		// 위의 것을 꾸미고 싶다면 리턴해서 content_view.jsp에서 꾸미기.
		return rs.getString("content");
	}
	
	public String type_view(JspWriter out, HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select type from room where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();

		return rs.getString("type");
	}

	public void reserve_check(HttpServletRequest request) throws Exception
	{
		String sql="select r2.*, r1.bang from room as r1, reserve as r2 ";
		// room은 r1, reserve는 r2 
		// r2(reserve)는 내용 전부를, r1(room)은 bang만 가져오기(방이름때문에 필요)
		
		sql=sql+" where r2.bang_id=r1.id order by r2.state asc";
		// r2(reserve)의 bang_id와 r1(room)의 id는 동일하다. 
		
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
		while(rs.next())
		{
			String[]imsi=rs.getString("outday").split("-");
			int y=Integer.parseInt(imsi[0]);
			int m=Integer.parseInt(imsi[1]);
			int d=Integer.parseInt(imsi[2]);
			
			LocalDate today=LocalDate.now();
			LocalDate dday=LocalDate.of(y, m, d);
			
			ReserveDto rdto=new ReserveDto();
			rdto.setId(rs.getInt("id"));
			rdto.setInday(rs.getString("inday"));
			rdto.setOutday(rs.getString("outday"));
			rdto.setUserid(rs.getString("userid"));
			rdto.setInwon(rs.getInt("inwon"));
			rdto.setCharcoal(rs.getInt("charcoal"));
			rdto.setBbq(rs.getInt("bbq"));
			rdto.setWriteday(rs.getString("writeday"));
			
			if(today.isBefore(dday))
				rdto.setState(rs.getInt("state"));
			else
				rdto.setState(3);
			
			rdto.setTotal(rs.getInt("total"));
			rdto.setBang(rs.getString("bang"));
			
			rlist.add(rdto);
		}
		request.setAttribute("rlist", rlist);
	}
	
	// state를 2로 변경(예약취소중(1) -> 취소완료(2))
	public void reserve_cancel(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String sql="update reserve set state=2 where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("reserve_check.jsp");
	}
	
	public void member_check(HttpServletRequest request) throws Exception
	{
		String sql="select * from member order by state asc, name asc";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs= pstmt.executeQuery();
		ArrayList<MemberDto> mlist=new ArrayList<MemberDto>();
		while(rs.next())
		{
			MemberDto mdto=new MemberDto();
			mdto.setId(rs.getInt("id"));
			mdto.setUserid(rs.getString("userid"));
			mdto.setName(rs.getString("name"));
			mdto.setState(rs.getInt("state"));
			mdto.setPhone(rs.getString("phone"));
			
			mlist.add(mdto);
		}
		request.setAttribute("mlist", mlist);
	}
	
	public void out_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String sql="update member set state=2 where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("member_check.jsp");
	}
	
	public void room_input_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String bang=request.getParameter("bang");
		String min=request.getParameter("min");
		String max=request.getParameter("max");
		String price=request.getParameter("price");
		String content=request.getParameter("content");
		String type=request.getParameter("type");
		String sql="insert into room(bang, min, max, price, content, type) values(?,?,?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, bang);
		pstmt.setString(2, min);
		pstmt.setString(3, max);
		pstmt.setString(4, price);
		pstmt.setString(5, content);
		pstmt.setString(6, type);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("room_view.jsp");
	}
	
	public void bang_check(HttpServletRequest request, JspWriter out) throws Exception
	{
		String bang=request.getParameter("bang");
		String sql="select count(*) as cnt from room where bang=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, bang);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		out.print(rs.getString("cnt"));
	}
	
	public void room_delete(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String sql="delete from room where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("room_view.jsp");
	}
	
	public void room_update(HttpServletRequest request) throws Exception
	{
		String id=request.getParameter("id");
		String sql="select * from room where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		RoomDto rdto=new RoomDto();
		rdto.setBang(rs.getString("bang"));
		rdto.setContent(rs.getString("content").replace("\r\n", "<br>"));
		rdto.setId(rs.getInt("id"));
		rdto.setMax(rs.getInt("max"));
		rdto.setMin(rs.getInt("min"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setType(rs.getString("type"));
		
		request.setAttribute("rdto", rdto);
		
	}
	
	public void room_update_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String bang=request.getParameter("bang");
		String min=request.getParameter("min");
		String max=request.getParameter("max");
		String price=request.getParameter("price");
		String content=request.getParameter("content");
		String type=request.getParameter("type");
		String id=request.getParameter("id");
		
		String sql="update room set bang=?, min=?, max=?, price=?, content=?, type=? where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, bang);
		pstmt.setString(2, min);
		pstmt.setString(3, max);
		pstmt.setString(4, price);
		pstmt.setString(5, content);
		pstmt.setString(6, type);
		pstmt.setString(7, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("room_view.jsp");
	}
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
}
