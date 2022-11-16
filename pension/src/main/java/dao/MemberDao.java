package dao;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import dto.MemberDto;

public class MemberDao {
	
	PreparedStatement pstmt;
	Connection conn;
	
	public MemberDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void userid_check(HttpServletRequest request, JspWriter out) throws Exception
	{
		String userid=request.getParameter("userid");
		String sql="select count(*) as cnt from member where userid=?";
			// cnt가 0이면 없다는 뜻, 1은 해당 아이디가 존재한다는 뜻 
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		out.print(rs.getString("cnt"));
	}
	
	public void member_input_ok(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String userid=request.getParameter("userid");
		String name=request.getParameter("name");
		String pwd=request.getParameter("pwd");
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		String sql="insert into member(userid, name, pwd, email, phone, writeday) values(?,?,?,?,?, now())";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, name);
		pstmt.setString(3, pwd);
		pstmt.setString(4, email);
		pstmt.setString(5, phone);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("login.jsp");	
	}
	
	public void login_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception
	{
		String userid=request.getParameter("userid");
		String pwd=request.getParameter("pwd");
		String sql="select * from member where userid=? and pwd=? and state=0";
		// state=1인 경우는 탈퇴회원이기때문에 state=0을 작성해서 회원만 로그인할 수 있도록 작성
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, pwd);
		ResultSet rs=pstmt.executeQuery();
		
		if(rs.next())	// 레코드가 있다 : 회원
		{
			// 세션변수를 생성
			session.setAttribute("userid", rs.getString("userid"));
			session.setAttribute("name", rs.getString("name"));
			rs.close();
			close();
			response.sendRedirect("../main/index.jsp");
		}
		else	// 레코드가 없다 : 비회원
		{
			rs.close();
			close();
			session.setAttribute("chk", "5"); // 로그인 실패시 값을 줘서 차이를 둔다. 단순 링크를 통해 들어왔을 때는 null이다.
			response.sendRedirect("login.jsp");	
		}												
	}
	
	public void logout(HttpSession session, HttpServletResponse response) throws Exception
	{
		session.invalidate();
		response.sendRedirect("../main/index.jsp");
	}
	
	public void member_info(HttpSession session, HttpServletRequest request) throws Exception
	{
		// session 객체에서 사용자 아이디 저장
		String userid=session.getAttribute("userid").toString();
		
		String sql="select * from member where userid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		ResultSet rs=pstmt.executeQuery();
		rs.next();

		// 1. ResultSet을 리턴, jsp에서 rs로 출력 => request영역에 저장, jsp에서는 el표현식으로 출력
		// jsp에서 필요한 내용을 전부 request로 각각 생성도 가능	(방법1)		<jsp에 작성방법>
//		request.setAttribute("userid", rs.getString("userid"));		${userid}
//		request.setAttribute("name", rs.getString("name"));			${name}
//		request.setAttribute("email", rs.getString("email"));		${email}
//		request.setAttribute("phone", rs.getString("phone"));		${phone}
		
		// 2. 필요한 값을 하나씩 request영역에 저장 => dto에 한꺼번에 저장
		// jsp에서 필요한 내용을 하나의 객체로 만들어서 사용 (dto)	(방법2)
		MemberDto mdto=new MemberDto();
		mdto.setUserid(rs.getString("userid"));
		mdto.setName(rs.getString("name"));
		mdto.setEmail(rs.getString("email"));
		mdto.setPhone(rs.getString("phone"));
		
		request.setAttribute("mdto", mdto);
	}
	public void pwd_change_ok(HttpServletRequest request, HttpSession session,HttpServletResponse response) throws Exception
	{
		String old_pwd=request.getParameter("old_pwd");
		String pwd=request.getParameter("pwd");
		
		String sql="select pwd from member where userid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, session.getAttribute("userid").toString());
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		String dbpwd=rs.getString("pwd");
		if(old_pwd.equals(dbpwd))
		{
			sql="update member set pwd=? where userid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, session.getAttribute("userid").toString());
			pstmt.executeUpdate();
			
			// 비밀번호 변경하고 다시 로그인을 해야하기 때문에 로그아웃을 시키고 login.jsp로 이동
			session.invalidate(); 
			close();
			response.sendRedirect("../member/login.jsp");
		}
		else
		{
			close();
			response.sendRedirect("../member/pwd_change.jsp?chk=1");
		}
	}
	
	public void member_update(HttpSession session, HttpServletRequest request) throws Exception
	{
		String userid=session.getAttribute("userid").toString();
		String sql="select * from member where userid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		MemberDto mdto=new MemberDto();	// 아이디와 이름은 세션변수에 있기때문에 따로 작성하지 않아도 된다. 
		
		mdto.setEmail(rs.getString("email"));
		mdto.setPhone(rs.getString("phone"));
		
		request.setAttribute("mdto", mdto);
		
	}
	
	public void member_update_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception
	{
		String userid=session.getAttribute("userid").toString();
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		String sql="update member set email=?, phone=? where userid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, phone);
		pstmt.setString(3, userid);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("../member/member_info.jsp");
	}
	
	public void userid_search(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");
		String sql="select userid from member where name=? and phone=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, phone);
		ResultSet rs=pstmt.executeQuery();
		
		// 이름, 전화번호가 일치하다면
		if(rs.next())
		{				
			session.setAttribute("imsiuser", rs.getString("userid"));
			session.setAttribute("chk", "1");
			close();
			response.sendRedirect("login.jsp");
		}
		
		// 불일치하다면
		else
		{
			session.setAttribute("chk", "2");
			close();
			response.sendRedirect("login.jsp");
		}
	}
	
	public void pwd_search(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception
	{
		request.setCharacterEncoding("utf-8");
		String name=request.getParameter("name");
		String userid=request.getParameter("userid");
		String phone=request.getParameter("phone");
		String sql="select pwd from member where name=? and userid=? and phone=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setString(2, userid);
		pstmt.setString(3, phone);
		ResultSet rs=pstmt.executeQuery();
		if(rs.next())
		{
			session.setAttribute("pwd", rs.getString("pwd"));
			session.setAttribute("chk", "3");
			close();
			response.sendRedirect("login.jsp");
		}
		else
		{
			session.setAttribute("chk", "4");
			close();
			response.sendRedirect("login.jsp");
		}
	}
	
	// 회원탈퇴 (state필드의 값을 1로 변경:탈퇴	// 0: 회원)
	public void member_out(HttpSession session, HttpServletResponse response) throws Exception
	{
		String userid=session.getAttribute("userid").toString();
		String sql="update member set state=1 where userid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.executeUpdate();
		close();
		
		// 로그인 -> 로그아웃 상태변경
		session.invalidate();
		
		response.sendRedirect("../main/index.jsp");
	}
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close(); 
	}
}
