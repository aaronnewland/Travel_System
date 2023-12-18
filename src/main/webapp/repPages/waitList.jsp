<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="com.example.travel_system.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Waitlist</title>
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
                <h1><span class="highlight">Rep</span> Waitlist Search</h1>
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
            <a href="repFAQ.jsp" class="tablinks">Answer FAQ</a>
            <a href="waitList.jsp" class="tablinks active">Waitlist</a>
            <a href="repMakeReservations.jsp" class="tablinks">Rep Make Reservations</a>
        </div>
    </div>

    <div class="container">
       
        <div class="form-section">
            <h2>View Waiting List</h2>
            <form action="" method="post">
                <input type="number" name="fid" placeholder="Flight ID" required>
                <input type="text" name="airlineID" placeholder="Airline ID" required>
                <input type="submit" value="View List">
            </form>
        </div>

        
        <div class="form-section">
            <%
            String airlineID = request.getParameter("airlineID");
            String fidStr = request.getParameter("fid");
            if (fidStr != null && !fidStr.isEmpty()) {
                int fid = Integer.parseInt(fidStr);

                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    ApplicationDB db = new ApplicationDB();
                    con = db.getConnection();

                    String sqlQuery = "SELECT wl.wl_id, wl.f_id, wl.aircraft_id, wl.airline_id, wl.time_added, c.id as cust_id, c.first_name, c.middle_name, c.last_name FROM waitlist wl JOIN customer c ON wl.cust_id = c.id WHERE wl.f_id = ? AND wl.airline_id = ?";
                    pstmt = con.prepareStatement(sqlQuery);
                    pstmt.setInt(1, fid);
                    pstmt.setString(2, airlineID);
                    rs = pstmt.executeQuery();

                    out.println("<h2>Waiting List Details for Flight ID: " + fid + " Airline ID: " + airlineID + "</h2>");
                    out.println("<table>");
                    out.println("<tr><th>Waitlist ID</th><th>Flight ID</th><th>Aircraft ID</th><th>Airline ID</th><th>Time Added</th><th>Customer ID</th><th>First Name</th><th>Middle Name</th><th>Last Name</th></tr>");

                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("wl_id") + "</td>");
                        out.println("<td>" + rs.getInt("f_id") + "</td>");
                        out.println("<td>" + rs.getInt("aircraft_id") + "</td>");
                        out.println("<td>" + rs.getString("airline_id") + "</td>");
                        out.println("<td>" + rs.getTime("time_added").toString() + "</td>");
                        out.println("<td>" + rs.getInt("cust_id") + "</td>");
                        out.println("<td>" + rs.getString("first_name") + "</td>");
                        out.println("<td>" + rs.getString("middle_name") + "</td>");
                        out.println("<td>" + rs.getString("last_name") + "</td>");
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
            }
            %>
        </div>
    </div>
</body>
</html>
