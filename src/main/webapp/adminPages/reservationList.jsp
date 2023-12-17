<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Reservation List</title>
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
    <script>
        function toggleAirlineIdTextbox() {
            var fIdRadio = document.querySelector('input[name="searchType"][value="fId"]');
            var airlineIdTextbox = document.getElementById('airlineIdTextbox');
            airlineIdTextbox.style.display = fIdRadio.checked ? 'block' : 'none';
        }
    </script>
</head>
<body onload="toggleAirlineIdTextbox()">
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">ADMIN</span> Reservation List</h1>
            </div>
            <nav>
                <ul>
                    <li class="current"><a href="adminLandingPage">Admin home page</a></li>
                    <!-- Additional navigation items if needed -->
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="form-section">
            <h2>Search Reservations</h2>
            <form action="" method="post" onchange="toggleAirlineIdTextbox()">
                <label><input type="radio" name="searchType" value="custId" checked> Customer ID</label>
                <label><input type="radio" name="searchType" value="fId"> Flight ID</label>
                <input type="text" name="searchValue" placeholder="Enter ID" required>
                <div id="airlineIdTextbox" style="display:none;">
                    <input type="text" name="airlineId" placeholder="Airline ID">
                </div>
                <input type="submit" value="Search">
            </form>
<%
    String searchType = request.getParameter("searchType");
    String searchValue = request.getParameter("searchValue");
    String airlineId = request.getParameter("airlineId");

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        String sqlQuery = "";
        if ("fId".equals(searchType)) {
            sqlQuery = "SELECT tf.ticket_number, f.airline_id, f.aircraft_id, f.f_id, f.departure_time, f.arrival_time, f.departure_apt, f.arrival_apt, (f.fare + f.booking_fee) AS fare " +
                       "FROM flight f, ticketed_flights tf " +
                       "WHERE f.f_id = tf.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id AND f.airline_id = ? AND f.f_id = ? ORDER BY f.departure_time ASC";
            pstmt = con.prepareStatement(sqlQuery);
            pstmt.setString(1, airlineId);
            pstmt.setInt(2, Integer.parseInt(searchValue));
        } else if ("custId".equals(searchType)) {
            sqlQuery = "SELECT tf.ticket_number, f.airline_id, f.aircraft_id, f.f_id, f.departure_time, f.arrival_time, f.departure_apt, f.arrival_apt, (f.fare + f.booking_fee) AS fare " +
                       "FROM flight f, ticketed_flights tf " +
                       "WHERE f.f_id = tf.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id AND tf.cust_id = ? ORDER by f.departure_time ASC";
            pstmt = con.prepareStatement(sqlQuery);
            pstmt.setInt(1, Integer.parseInt(searchValue));
        }
        rs = pstmt.executeQuery();
     // Table Display
        out.println("<h2>Flight Path Results for " + searchType + " " + searchValue + "</h2>");
        out.println("<table>");
        out.println("<tr><th>Ticket Number</th><th>Airline ID</th><th>Aircraft ID</th><th>Flight ID</th><th>Departure Time</th><th>Arrival Time</th><th>Departure Airport</th><th>Arrival Airport</th><th>Fare</th></tr>");
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("ticket_number") + "</td>");
            out.println("<td>" + rs.getString("airline_id") + "</td>");
            out.println("<td>" + rs.getString("aircraft_id") + "</td>");
            out.println("<td>" + rs.getString("f_id") + "</td>");
            out.println("<td>" + rs.getString("departure_time") + "</td>");
            out.println("<td>" + rs.getString("arrival_time") + "</td>");
            out.println("<td>" + rs.getString("departure_apt") + "</td>");
            out.println("<td>" + rs.getString("arrival_apt") + "</td>");
            out.println("<td>" + rs.getDouble("fare") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    }
%>
</div>
</div>
</body>
</html>
