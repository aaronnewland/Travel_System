<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Revenue Report</title>
    <!-- CSS Styles -->
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
        /* Tab styles */
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
        .form-section h2 {
            color: #50b3a2;
        }
        .form-section form {
            margin-top: 15px;
        }
        .form-section form input[type="text"], .form-section form input[type="submit"] {
            padding: 10px;
            margin: 5px;
        }
        .form-section form input[type="submit"] {
            background: #50b3a2;
            border: 0;
            color: white;
            cursor: pointer;
        }
        .form-section form input[type="submit"]:hover {
            background: #333;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #cccccc;
        }
        table th, table td {
            padding: 15px;
            text-align: left;
        }
        table tr:nth-child(even) {
            background: #f2f2f2;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">Revenue Report</span></h1>
            </div>
            <nav>
                <ul>
                    <li><a href="adminLandingPage">Home</a></li>
                    <!-- Additional navigation items if needed -->
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="tab">
            <a href="adminCustomerFunctions.jsp" class="tablinks">Customer Functions</a>
            <a href="salesReport.jsp" class="tablinks">Sales Report</a>
            <a href="reservationList.jsp" class="tablinks">Reservations</a>
            <a href="revenueGenerated.jsp" class="tablinks active">Revenue</a>
            <a href="mostActiveFlightList.jsp" class="tablinks">Active Flights</a>
        </div>
    </div>
     
    <div class="container">
        <div class="form-section">
            <h2>Filter Revenue</h2>
            <form action="" method="post">
                <label><input type="radio" name="filterType" id="flightIDRadio" value="flight" checked onchange="toggleFlightIDTextbox()"> Flight ID</label>
                <label><input type="radio" name="filterType" value="airline" onchange="toggleFlightIDTextbox()"> Airline ID</label>
                <label><input type="radio" name="filterType" value="customer" onchange="toggleFlightIDTextbox()"> Customer ID</label>
                <input type="text" name="filterValue" placeholder="Enter ID" required>
                <div id="flightIDTextbox" style="display:none;">
                    <input type="text" name="airlineID" placeholder="Airline ID">
                </div>
                <input type="submit" value="Search">
            </form>
        </div>
     

        <%  
    String filterType = request.getParameter("filterType");
    String filterValue = request.getParameter("filterValue");
    String airlineID = request.getParameter("airlineID");

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        String sqlQuery = "";
        if ("flight".equals(filterType)) {
            sqlQuery = "SELECT SUM(f.fare + f.booking_fee) AS revenue FROM flight f WHERE f.f_id = ? AND f.airline_id = ?;";
            pstmt = con.prepareStatement(sqlQuery);
            pstmt.setInt(1, Integer.parseInt(filterValue));
            pstmt.setString(2, airlineID);
        } else if ("airline".equals(filterType)) {
            sqlQuery = "SELECT SUM(f.fare + f.booking_fee) AS revenue FROM flight f WHERE f.airline_id = ?;";
            pstmt = con.prepareStatement(sqlQuery);
            pstmt.setString(1, filterValue);
        } else if ("customer".equals(filterType)) {
            sqlQuery = "SELECT SUM(f.fare + f.booking_fee) AS revenue FROM ticketed_flights tf JOIN flight f ON tf.f_id = f.f_id WHERE tf.cust_id = ?;";
            pstmt = con.prepareStatement(sqlQuery);
            pstmt.setInt(1, Integer.parseInt(filterValue));
        }

        rs = pstmt.executeQuery();

        if (rs.next()) {
            String revenue = rs.getString("revenue");
            if (revenue != null) {
                out.println("<table>");
                out.println("<tr><th>ID Type</th><th>ID</th><th>Revenue Generated</th></tr>");
                out.println("<tr>");
                out.println("<td>" + filterType + "</td>");
                out.println("<td>" + filterValue + "</td>");
                out.println("<td>" + revenue + "</td>");
                out.println("</tr>");
                out.println("</table>");
            } else {
                out.println("<p>Match not found.</p>");
            }
        } else {
            out.println("<p>Match not found.</p>");
        }
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
</body>
</html>
