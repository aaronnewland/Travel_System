<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }

        header {
            background: #50b3a2;
            color: white;
            padding-top: 30px;
            min-height: 70px;
            border-bottom: #e8491d 3px solid;
        }

        header a {
            color: #ffffff;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 16px;
        }

        header ul {
            padding: 0;
            margin: 0;
            list-style: none;
            overflow: hidden;
        }

        header li {
            float: left;
            display: inline;
            padding: 0 20px 0 20px;
        }

        header #branding {
            float: left;
        }

        header #branding h1 {
            margin: 0;
        }

        header nav {
            float: right;
            margin-top: 10px;
        }

        header .highlight, header .current a {
            color: #e8491d;
            font-weight: bold;
        }

        header a:hover {
            color: #ffffff;
            font-weight: bold;
        }

        .tab a {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
            font-size: 17px;
            text-decoration: none;
            color: #333;
            border-radius: 4px;
            margin-right: 5px;
        }

        .tab a:hover {
            background-color: #ddd;
        }

        .tab a.active {
            background-color: #50b3a2;
            color: white;
        }

        .form-section {
            background: #ffffff;
            padding: 20px;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        th, td {
            padding: 5px;
            text-align: left;
        }

        table tr:nth-child(even) {
            background: #f2f2f2;
        }

        .center {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">Customer</span> Dashboard</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="customerLandingPage2.jsp">Customer Home</a></li>
                    <li><a href='../logout.jsp'>Log out</a></li>
                </ul>
            </nav>
        </div>
    </header>

  <div class="container">
        <div class="tab">
          <!--  <a href="editCustomerReservations1.jsp" class="tablinks">Customer Functions</a>
            <a href="airportFlightList.jsp" class="tablinks">Airport Flight List</a> -->
            <a href="customerLandingPage2.jsp" class="tablinks">Home</a>
            <a href="customerFlightSearch.jsp" class="tablinks">Flight Search</a>
            <a href="cancelFlight.jsp" class="tablinks">Cancel a flight</a>
            <a href="postFAQ.jsp" class="tablinks">Ask a Question</a>
            <a href="searchFAQ.jsp" class="tablinks active">Search FAQ</a>
            <a href="upcomingAndPastFlights.jsp" class="tablinks">Past and Upcoming Itinerary</a>
        </div>
    </div>
    <br>
<div class="container">
        <!-- Search Form -->
        <form method="post" action=""> <!-- Changed to 'post' method -->
            <input type="text" name="searchQ" placeholder="Search FAQs">
            <input type="submit" value="Search">
        </form>
        <br>
  
        <%
            String search_term = request.getParameter("searchQ");
            if (search_term != null && !search_term.isEmpty()) {
                Class.forName("com.mysql.jdbc.Driver");
                ApplicationDB db = new ApplicationDB();
                Connection con = db.getConnection();

                // Using PreparedStatement to prevent SQL Injection
                String query = "SELECT * FROM FAQ WHERE question LIKE ?";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, "%" + search_term + "%");

                ResultSet rs = pstmt.executeQuery();

                out.println("<table>");
                out.println("<tr><th>Question_No</th><th>Question</th><th>Answer</th>");

                while (rs.next()) {
                    String qid = rs.getString(1);
                    String question = rs.getString(2);
                    String answer = rs.getString(3);

                    out.println("<tr>");
                    out.println("<td>" + qid + "</td>");
                    out.println("<td>" + question + "</td>");
                    if (rs.getString("answer") == null) {
                    	out.println("<td> Sorry, no answer yet. </td>");
                    } else {
                    out.println("<td>" + rs.getString("answer") + "</td>");
                    }
                    out.println("</tr>");
                }

                out.println("</table>");

                rs.close();
                pstmt.close();
                con.close();
            }
        %>
    </div>
</body>
</html>