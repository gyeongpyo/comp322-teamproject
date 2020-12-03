<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page language="java" import="java.text.*, java.sql.*"%>
        <%@ page language="java" import= "java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%

		String serverIP = "localhost";
		String strSID = "orcl";
		String portNum = "1521";
		String user = "university";
		String pass = "comp322";
		String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;

		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);

		String sql;
		ResultSetMetaData rsmd;
		int cnt;
		String id = request.getParameter("number");
		id = "123";
		%>
		
	<script type="text/javascript">

	function modi()
	{
		var x = document.getElementById("Rating11");
   		x.style.visibility =  "visible";
   		var y = document.getElementById("stars");
   		y.style.visibility =  "visible";
	}


</script>
<body>
	<%
	sql = "select Title, mType, runtime, Start_year, Num_of_votes, Director, "
			+ "Writer, Company, Descriptions" + " from movie" + " where movie.id = "+id;
	
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	String ans1;
	String ans2;
	String ans3;
	String ans4;
	String ans6;
	String ans7;
	String ans8;
	String ans9;
	String ans10;
	Date date = null;

	while (rs.next())
	{
		ans1 = rs.getString(1);
		ans2 = rs.getString(2);
		ans3 = rs.getString(3);
		ans4 = rs.getString(4);

		SimpleDateFormat sDate = new SimpleDateFormat("yyyy-mm-dd");
		try {
			date = sDate.parse(ans4);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SimpleDateFormat Ddate = new SimpleDateFormat("yyyy-mm-dd");
		// System.out.println(Ddate.format(date));

		ans6 = rs.getString(5);
		ans7 = rs.getString(6);
		ans8 = rs.getString(7);
		ans9 = rs.getString(8);
		ans10 = rs.getString(9);

		out.print("Title : " + ans1);
		out.println(" | Movie type : " + ans2);
		out.print("<br/>Runtime : " + ans3 + " minutes");
		out.println(" | Start Year : " + Ddate.format(date)); // 성공
		out.println("<br/>the number of vote : " + ans6);
		out.print("<br/>Director : " + ans7);
		out.println(" | Writer : " + ans8);
		out.println("<br/>company : " + ans9);
		out.println("<br/>Discription");
		out.println("<br/>"+ans10);
	}
	%>
	<h3>평점을 매기시겠습니까?</h3>
	<input type="button" id = "goToRating" onclick="modi()" value="점수매기기"/>
	<input type="button" id = "goBack" onclick = "" value = "이전 단계로"/>
	
	<form action="RatingProcess.jsp">
	<input type="text" id = "Rating11" name = "Rating11" style="visibility: hidden">
	<input type="submit" value="평점 남기기" id = "stars" style="visibility: hidden"/>
	</form>
</body>
</html>