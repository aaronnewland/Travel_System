<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="com.example.travel_system.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Sales Report</title>
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
                <h1><span class="highlight">ADMIN</span> Sales Report</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="adminLandingPage">Admin Home Page</a></li>
                    <!-- Other navigation items -->
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="tab">
            <a href="adminCustomerFunctions.jsp" class="tablinks">Customer Functions</a>
            <a href="salesReport.jsp" class="tablinks">Sales Report</a>
            <a href="reservationList.jsp" class="tablinks">Reservations</a>
            <a href="revenueGenerated.jsp" class="tablinks">Revenue</a>
            <a href="mostActiveFlightList.jsp" class="tablinks active">Active Flights</a>
        </div>
    </div>
<%
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();
        st = con.createStatement();

        String sqlQuery = "SELECT COUNT(*) AS tickets_sold, f_id, aircraft_id, airline_id " +
                          "FROM ticketed_flights " +
                          "GROUP BY f_id, aircraft_id, airline_id " +
                          "ORDER BY tickets_sold DESC;";

        rs = st.executeQuery(sqlQuery);
        out.println("<h2>Most Active Flights</h2>");
        out.println("<table>");
        out.println("<tr><th>Flight ID</th><th>Airline ID</th><th>Aircraft ID</th><th>Total Tickets Sold</th></tr>");

        while (rs.next()) {
            int ticketsSold = rs.getInt("tickets_sold");
            String fId = rs.getString("f_id");
            String aircraftId = rs.getString("aircraft_id");
            String airlineId = rs.getString("airline_id");

            out.println("<tr>");
            out.println("<td>" + fId + "</td>");
            out.println("<td>" + airlineId + "</td>");
            out.println("<td>" + aircraftId + "</td>");
            out.println("<td>" + ticketsSold + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace();  // Print the stack trace for debugging
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (con != null) con.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
</body>
</html>
