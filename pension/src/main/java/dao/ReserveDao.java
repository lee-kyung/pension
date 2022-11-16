package dao;

import java.io.Closeable;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.ReserveDto;
import dto.RoomDto;

public class ReserveDao {

	PreparedStatement pstmt;
	Connection conn;
	
	public ReserveDao() throws Exception
	{
		Class.forName("com.mysql.jdbc.Driver");
		String db="jdbc:mysql://localhost:3306/pension";
		conn=DriverManager.getConnection(db,"root","1234");
	}
	
	public void getCalendar(HttpServletRequest request)
	{
		// 1일의 요일, 총 일수, 몇 주를 구해서 request영역에 저장
		int y,m;
		if(request.getParameter("y")==null)
		{
			// 현재 날짜 정보를 가져온다
			LocalDate today=LocalDate.now();
			y=today.getYear();			// 년
			m=today.getMonthValue();	// 월
		}
		else
		{
			y=Integer.parseInt(request.getParameter("y"));
			m=Integer.parseInt(request.getParameter("m"));
		}
		
		// 해당월의 1이에 대한 날짜객체를 생성
		LocalDate dday=LocalDate.of(y, m, 1);
		
		// 1일의 요일
		int yoil=dday.getDayOfWeek().getValue();	// 1 ~ 7:일요일
		if(yoil==7)
			yoil=0;
		
		// 해당월의 총 일수
		int chong=dday.lengthOfMonth();	 // 총 일수
		
		// 몇 주인가
		int ju=(int)Math.ceil((yoil+chong)/7.0);
		
		request.setAttribute("yoil", yoil);
		request.setAttribute("chong", chong);
		request.setAttribute("ju", ju);
		request.setAttribute("y", y);
		request.setAttribute("m", m);
	}
	
	public void getRoom(HttpServletRequest request) throws Exception
	{
		String sql="select * from room order by price asc";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs= pstmt.executeQuery();
		
		ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
		
		while(rs.next())
		{
			RoomDto rdto=new RoomDto();
			rdto.setId(rs.getInt("id"));
			rdto.setBang(rs.getString("bang"));
			rdto.setPrice(rs.getInt("price"));
			
			rlist.add(rdto);
		}
		
		request.setAttribute("rlist", rlist);
	}
	
	public void reserve_next(HttpServletRequest request) throws Exception
	{
		// jsp에 보내줘야 될 내용 => 년, 월, 일, 방의 정보
		int y=Integer.parseInt(request.getParameter("y"));
		int m=Integer.parseInt(request.getParameter("m"));
		int d=Integer.parseInt(request.getParameter("d"));
		String id=request.getParameter("id");
		
		// 입실일
		String ymd=y+"-"+m+"-"+d;
		
		// 방의 정보
		String sql="select * from room where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		RoomDto rdto=new RoomDto();
		rdto.setId(rs.getInt("id"));
		rdto.setBang(rs.getString("bang"));
		rdto.setMax(rs.getInt("max"));
		rdto.setMin(rs.getInt("min"));
		rdto.setPrice(rs.getInt("price"));
		rdto.setContent(rs.getString("content"));
		
		// request 영역에 필요한 값 담기
		request.setAttribute("ymd", ymd);
		request.setAttribute("rdto", rdto);
	}
	
	public void reserve_ok(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception
	{
		String inday=request.getParameter("inday");	// 2022-07-05
		int suk=Integer.parseInt(request.getParameter("suk"));
		String bang_id=request.getParameter("bang_id");
		String total=request.getParameter("total");
		String inwon=request.getParameter("inwon");
		String charcoal=request.getParameter("charcoal");
		String bbq=request.getParameter("bbq");
		String userid=session.getAttribute("userid").toString();
		
	// inday를 이용해서 outday를 구한다
		// inday를 정수로 변환
		String[] imsi=inday.split("-");
		int y=Integer.parseInt(imsi[0]);
		int m=Integer.parseInt(imsi[1]);
		int d=Integer.parseInt(imsi[2]);
		
		// 입실일 날짜 객체 만들기
		LocalDate dday=LocalDate.of(y, m, d);
		LocalDate outday=dday.plusDays(suk);
		
		String sql="insert into reserve(inday, outday, userid, bang_id, inwon, charcoal, bbq, total, writeday) ";
		sql=sql+" values(?,?,?,?,?,?,?,?,now())";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, inday);
		pstmt.setString(2, outday.toString());
		pstmt.setString(3, userid);
		pstmt.setString(4, bang_id);
		pstmt.setString(5, inwon);
		pstmt.setString(6, charcoal);
		pstmt.setString(7, bbq);
		pstmt.setString(8, total);
		
		pstmt.executeUpdate();
		close();
		response.sendRedirect("reserve_view.jsp");
	}
	
	public void reserve_view(HttpSession session, HttpServletRequest request) throws Exception
	{
		// 예약현황을 통해 들어왔을 때는 예약했던 현황들을 다 보여줘야 되기 때문에 ck값을 줘서 구분한다. 
		
		String chuga="";
		// 예약하기에서 reserve_view로 들어오는 경우 
		if(request.getParameter("ck")==null)	
			chuga="limit 1";
		// 예약하기에서 예약후 예약취소후 다시 들어오는 경우 
		else if(!request.getParameter("ck").equals("1"))	
			chuga="limit 1";
			
		String sql="select r2.*, r1.bang from room as r1, reserve as r2 where r2.userid=? ";
		sql=sql+" and r1.id=r2.bang_id order by id desc " +chuga;
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, session.getAttribute("userid").toString());
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<ReserveDto> rlist=new ArrayList<ReserveDto>();
		
		// chuga가 없다면 예약하는 한건만 보여주지만 chuga가 된다면 모든 현황들을 보여줘야 되기 때문에 while문을 사용
		while(rs.next())
		{
			ReserveDto rdto=new ReserveDto();
			rdto.setId(rs.getInt("id"));
			rdto.setInday(rs.getString("inday"));
			rdto.setOutday(rs.getString("outday"));
			rdto.setBang_id(rs.getInt("bang_id"));
			rdto.setCharcoal(rs.getInt("charcoal"));
			rdto.setBbq(rs.getInt("bbq"));
			rdto.setTotal(rs.getInt("total"));
			rdto.setWriteday(rs.getString("writeday"));
			rdto.setBang(rs.getString("bang"));
			rdto.setState(rs.getInt("state"));
			
			rlist.add(rdto);
		}
		
		request.setAttribute("rlist", rlist);
		request.setAttribute("ck", request.getParameter("ck"));	// location에 사용하기위해서 
	}
	
	//  당일예약 못하도록 숨기기
	public void getcheck(String y, String m, String d, HttpServletRequest request)
	{
		int yy=Integer.parseInt(y);
		int mm=Integer.parseInt(m);
		int dd=Integer.parseInt(d);
		
		LocalDate today=LocalDate.now();	// 오늘 날짜
		LocalDate dday=LocalDate.of(yy, mm, dd);
		
		System.out.println("today="+today);
		System.out.println("dday="+dday);
		
		if(today.isBefore(dday))	// 같은날
		{
			request.setAttribute("tt", "1");	
		}
		else
		{
			request.setAttribute("tt", "0");
		}
	}
	
	// 방이 비워져있는지
	public void getEmpty(String dday, String bang_id, HttpServletRequest request) throws Exception
	{
		// 년월일과 bang의 id를 이용하여 예약 가능여부를 확인
		String sql="select count(*) as cnt from reserve ";
		sql=sql+" where inday <=? and ?<outday and bang_id=?";
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, dday);
		pstmt.setString(2, dday);
		pstmt.setString(3, bang_id);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		
		request.setAttribute("cnt", rs.getString("cnt"));	// 0 or 1
	}
	
	// 몇 박이 가능한지를 체크
	public void getSuk(HttpServletRequest request) throws Exception
	{
		String ymd=request.getAttribute("ymd").toString();
		RoomDto rdto=(RoomDto)request.getAttribute("rdto");
		
		// ymd를 localdate로 변경
		String[] imsi=ymd.split("-");
		int y=Integer.parseInt(imsi[0]);
		int m=Integer.parseInt(imsi[1]);
		int d=Integer.parseInt(imsi[2]);	// 2022-07-28
		LocalDate dday=LocalDate.of(y, m, d);	// 내가 입실할 날짜의 객체가 생성
		
		int chk=0;
		for(int i=1; i<=5; i++)
		{
			chk++;
			
			LocalDate xday=dday.plusDays(i);	// 2022-07-29
			String sql="select * from reserve where inday <=? and ?<outday and bang_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, xday.toString());
			pstmt.setString(2, xday.toString());
			pstmt.setInt(3, rdto.getId());
			
			ResultSet rs=pstmt.executeQuery();
			
			if(rs.next())
				break;
		}
		
		request.setAttribute("chk", chk);
	}
	
	public void getprev(HttpServletRequest request)
	{
		LocalDate today=LocalDate.now();	// 오늘날짜
		int y,m;
		if(request.getParameter("y")==null)	// reserve.jsp를 제일처음부를때는 null값이다.
			y=today.getYear();
		else
			y=Integer.parseInt(request.getParameter("y"));
		if(request.getParameter("m")==null)
			m=today.getMonthValue();
		else
			m=Integer.parseInt(request.getParameter("m"));
		
		LocalDate xday=LocalDate.of(today.getYear(), today.getMonthValue(), 1);	// 오늘기준 1일의 날짜
		LocalDate dday=LocalDate.of(y, m, 1);	// 현재 달력기준 1일의 날짜
		if(xday.isBefore(dday))	// 오늘 기준보다 달력의 기준이 이전일 경우(같을 경우도 포함)
			request.setAttribute("prev", "1");
		else
			request.setAttribute("prev", "0");
	}
	
	public void state_change(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String id=request.getParameter("id");
		String state=request.getParameter("state");
		String sql="update reserve set state=? where id=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, state);
		pstmt.setString(2, id);
		pstmt.executeUpdate();
		close();
		response.sendRedirect("reserve_view.jsp?ck="+request.getParameter("ck"));
	}
	
	
	public void close() throws Exception
	{
		pstmt.close();
		conn.close();
	}
}
