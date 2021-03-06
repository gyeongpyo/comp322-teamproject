<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page language="java" import="java.text.*, java.sql.*"%>
        <%@ page language="java" import= "java.util.Date"%>
        <%@ page language="java" import= "km.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="./css/basic.css">
</head>
<%
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs;

		conn = Util.makeConnection();

		String sql;
		ResultSetMetaData rsmd;
		
		int cnt;
		String id = request.getParameter("movieID");
		String Acc;
		
		
		Acc = "Admin";
		//Acc = request.getParameter("UserID");
		//id = "123";
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
<nav class="navbar navbar-expand-lg navbar-light bg-light"  style="margin-bottom:30px">
  <a class="navbar-brand" href="LandingPage.jsp">KnuMovie</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarText">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
<%
	String userID = (String)session.getAttribute("userID");
	int membership =(int)session.getAttribute("membership_grade");
	
	if(membership == 3)  {
%>

        <a class="nav-link" href="UploadMoviePage.jsp">Upload <span class="sr-only">(current)</span></a>
      </li>
<%
		}
%>
      <li class="nav-item">
        <a class="nav-link" href="LandingPage.jsp">Search</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="MyPage.jsp">MyPage</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="Logout.jsp">Logout</a>
      </li>
    </ul>
  </div>
</nav>
<div class="box">
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
		
		out.println("<table class='table table-bordered'>");
		out.print("<tr><th>Title</th><td>"+  ans1 + "</td></tr>");
		out.print("<tr><th>Movie type</th><td>"+  ans2 + "</td></tr>");
		out.print("<tr><th>Runtime</th><td>"+  ans3 + "minutes" + "</td></tr>");
		out.print("<tr><th>Start Year</th><td>"+  Ddate.format(date) + "</td></tr>");
		out.print("<tr><th>The number of vote</th><td>"+  ans6 + "</td></tr>");
		out.print("<tr><th>Director</th><td>"+  ans7 + "</td></tr>");
		out.print("<tr><th>Company</th><td>"+  ans8 + "</td></tr>");
		out.print("<tr><th>Discription</th><td>"+  ans9 + "</td></tr>");
		out.println("</table>");
	}

%>

<%
	if((int)session.getAttribute("membership_grade") == 3)
	{
		out.println("<form action='ModifyMovieInfo.jsp' method='GET'>");
		out.println("<input type='hidden' value='" + id + "' name='movieID'/>");
		out.println("<div class='box'>");
		out.println("<input class='btn btn-primary' type='submit' value='MODIFY' id = 'stars'/>");
		out.println("<input class='btn btn-primary' type='button' id = 'goBack' value = 'GO BACK'/>");
		out.println("<div>");
		out.println("</form>");
	}
	else
	{
		out.println("<div class='box'>");
		out.println("<input class='btn btn-primary' type='button' id = 'goToRating' onclick='modi()' value='RATING'/>");
		out.println("<input class='btn btn-primary' type='button' id = 'goBack' value = 'GO BACK'/>");
		out.println("<div>");
		out.println("<form action='RatingProcess.jsp' method='POST'>");
		out.println("<input type='hidden' value='" + id + "' name='movieID'/>");
		out.println("<br>");
		out.println("<div class='box'>");
		out.println("<input class='form-control' type='text' id = 'Rating11' name = 'Rating11' style='visibility: hidden'><br>");
		out.println("<input class='btn btn-primary' type='submit' value='COMPLETE' id = 'stars' style='visibility: hidden'/>");
		out.println("<div>");
		out.println("</form>");
	}
	%>

</div>

</body>
</html>