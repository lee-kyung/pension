// member_input.jsp

/*
function userid_check(userid)
{
	var chk=new XMLHttpRequest();  
	chk.open("get", "userid_check.jsp?userid="+userid);
	chk.send();
	
	chk.onreadystatechange=function()
	{
		if(chk.readyState==4)
		{
			// 사용가능하면 0, 불가능 1
			if(chk.responseText.trim()=="0")
			{
				document.getElementById("err").innerText="사용 가능한 아이디";
				document.getElementById("err").style.color="blue";
				
			}
			else
			{
				document.getElementById("err").innerText="사용 불가능한 아이디";
				document.getElementById("err").style.color="red";
			}
		}	
	}
}
*/