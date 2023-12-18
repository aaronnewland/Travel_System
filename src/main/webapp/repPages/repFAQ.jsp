<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="com.example.travel_system.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Monthly Sales Report</title>
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
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">Rep</span> Answer FAQ</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="repLandingPage2.jsp">Rep Homepage</a></li>
                    <li><a href='../logout.jsp'>Log out</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="tab">
            <a href="editCustomerReservations1.jsp" class="tablinks">Edit Customer Reservations</a>
            <a href="airportFlightList.jsp" class="tablinks">Airport Flight List</a>
            <a href="repAirportFunctions.jsp" class="tablinks">Airport, Aircraft, Flight Functions</a>
            <a href="repFAQ.jsp" class="tablinks active">Answer FAQ</a>
            <a href="waitList.jsp" class="tablinks">Waitlist</a>
            <a href="repMakeReservations.jsp" class="tablinks">Rep Make Reservations</a>
        </div>
    </div>
    <div class="container">
        <!-- Form for Updating FAQ -->
        <div class="form-section">
            <h2>Update FAQ Answer</h2>
            <form action="" method="post">
                <input type="number" name="qid" placeholder="QID" required>
                <input type="text" name="answer" placeholder="Answer" required>
                <input type="submit" value="Update Answer">
            </form>
        </div>

        <!-- FAQ Display -->
        <div class="form-section">
            <%
            String qidStr = request.getParameter("qid");
            String answer = request.getParameter("answer");

            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                ApplicationDB db = new ApplicationDB();
                con = db.getConnection();

                if (qidStr != null && !qidStr.isEmpty() && answer != null) {
                    int qid = Integer.parseInt(qidStr);

                    // Update the FAQ answer
                    String updateSQL = "UPDATE FAQ SET answer = ? WHERE qid = ?";
                    pstmt = con.prepareStatement(updateSQL);
                    pstmt.setString(1, answer);
                    pstmt.setInt(2, qid);
                    pstmt.executeUpdate(); // Execute update
                }

                // Fetch FAQs without answers
                String fetchSQL = "SELECT * FROM FAQ WHERE answer IS NULL OR answer = '';";
                pstmt = con.prepareStatement(fetchSQL);
                rs = pstmt.executeQuery();

                out.println("<h2>FAQs Without Answers</h2>");
                out.println("<table>");
                out.println("<tr><th>Question ID</th><th>Question</th><th>Answer</th></tr>");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("qid") + "</td>");
                    out.println("<td>" + rs.getString("question") + "</td>");
                    
                    if (rs.getString("answer") == null) {
                    	out.println("<td> Please input answer </td>");
                    } else {
                    out.println("<td>" + rs.getString("answer") + "</td>");
                    }
                    out.println("</tr>");
                }
                out.println("</table>");
            } catch (Exception e) {
                e.printStackTrace(); 
            } finally {
                
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
            %>
        </div>
    </div>
</body>
</html>
