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
            <a href="salesReport.jsp" class="tablinks active">Sales Report</a>
            <a href="reservationList.jsp" class="tablinks">Reservations</a>
            <a href="revenueGenerated.jsp" class="tablinks">Revenue</a>
            <a href="mostActiveFlightList.jsp" class="tablinks">Active Flights</a>
        </div>
    </div>

    <div class="container">
        <div class="form-section">
            <h2>Select Month for Sales Report</h2>
            <form action="" method="post">
                <label for="month">Month:</label>
                <select name="month" id="month">
                    <option value="1">January</option>
                    <option value="2">February</option>
                    <option value="3">March</option>
                    <option value="4">April</option>
                    <option value="5">May</option>
                    <option value="6">June</option>
                    <option value="7">July</option>
                    <option value="8">August</option>
                    <option value="9">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                    
                </select>
                <input type="submit" value="Generate Report">
            </form>
        </div>

        <%
            String selectedMonth = request.getParameter("month");
            if (selectedMonth != null && !selectedMonth.isEmpty()) {
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    ApplicationDB db = new ApplicationDB();
                    con = db.getConnection();

                    String SQLQuery = "SELECT count(tf.ticket_number) as total_customers, SUM(f.fare + f.booking_fee) as Total_revenue, SUM(f.booking_fee) as profit_from_booking " +
                        "FROM ticketed_flights tf " +
                        "JOIN flight f ON tf.f_id = f.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id " +
                        "LEFT JOIN business_first_ticket bft ON tf.ticket_number = bft.ticket_number AND tf.cust_id = bft.cust_id " +
                        "LEFT JOIN economy_ticket et ON tf.ticket_number = et.ticket_number AND tf.cust_id = et.cust_id " +
                        "WHERE MONTH(tf.purchase_date) = ?;";

                    pstmt = con.prepareStatement(SQLQuery);
                    pstmt.setInt(1, Integer.parseInt(selectedMonth));
                    rs = pstmt.executeQuery();
                   	
                    if (!rs.next()) {
                        out.println("<p>Match not found</p>");
                    } else {
                        
                        out.println("<table>");
                        out.println("<tr><th>Total Customers</th><th>Total Revenue</th><th>Profit from Booking</th></tr>");
                        do {
                            String total_customers = rs.getString("total_customers");
                            String total_revenue = rs.getString("Total_revenue");
                            String total_profit_from_booking = rs.getString("profit_from_booking");

                            out.println("<tr>");
                            out.println("<td>" + total_customers + "</td>");
                            out.println("<td>" + total_revenue + "</td>");
                            out.println("<td>" + total_profit_from_booking + "</td>");
                            out.println("</tr>");
                        } while (rs.next());
                        out.println("</table>");
                    
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                }
            }
        %>
    </div>
</body>
</html>
