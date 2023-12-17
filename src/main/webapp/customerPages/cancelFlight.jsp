<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cancel Flight Page</title>
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
    <script>
        function confirmCancellation() {
            return confirm('Are you sure you want to cancel this flight?');
        }
    </script>
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
                    <!-- Additional navigation items -->
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
            <a href="cancelFlight.jsp" class="tablinks active">Cancel a flight</a>
            <a href="postFAQ.jsp" class="tablinks">Ask a Question</a>
            <a href="searchFAQ.jsp" class="tablinks">Search FAQ</a>
            <a href="upcomingAndPastFlights.jsp" class="tablinks">Past and Upcoming Itinerary</a>
        </div>
    </div>
    <br>
<div class="container">
       
 
        <%
            Class.forName("com.mysql.jdbc.Driver");
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String customerIDGlobal = (String) session.getAttribute("customerIDGlobal");
            int Custid = Integer.parseInt(customerIDGlobal);
            Custid = 1;
            
            String ticketToCancel = request.getParameter("ticket_number");
            if (ticketToCancel != null && !ticketToCancel.isEmpty()) {
                // Perform the cancellation
                String deleteSQL = "DELETE FROM ticketed_flights WHERE ticket_number = ?";
                pstmt = con.prepareStatement(deleteSQL);
                pstmt.setString(1, ticketToCancel);
                int affectedRows = pstmt.executeUpdate();
                if (affectedRows > 0) {
                    out.println("<p>Flight cancelled successfully.</p>");
                } else {
                    out.println("<p>Error cancelling flight.</p>");
                }
            }

            // Query for upcoming flights
            String sqlQuery = "SELECT * FROM ticketed_flights JOIN flight f using (f_id,aircraft_id,airline_id) WHERE cust_id = ? AND departure_time > NOW() ORDER BY departure_time ASC;";
            pstmt = con.prepareStatement(sqlQuery);
            pstmt.setInt(1, Custid);
            rs = pstmt.executeQuery();

            out.println("<h2>Upcoming Flights</h2>");
            out.println("<table>");
            out.println("<tr><th>Ticket Number</th><th>Flight ID</th><th>Departure City</th><th>Arrival City</th><th>Departure Time</th><th>Arrival Time</th><th>Is Paid</th><th>Action</th></tr>");
            while (rs.next()) {
                String ticket_number = rs.getString("ticket_number");
                String f_id = rs.getString("f_id");
                String departure_time = rs.getString("departure_time");
                String arrival_time = rs.getString("arrival_time");
                int is_paid = rs.getInt("is_paid");
                String departCity = rs.getString("departure_apt");
                String arrivalCity = rs.getString("arrival_apt");

                out.println("<tr>");
                out.println("<td>" + ticket_number + "</td>");
                out.println("<td>" + f_id + "</td>");
                out.println("<td>" + departCity + "</td>");
                out.println("<td>" + arrivalCity + "</td>");
                out.println("<td>" + departure_time + "</td>");
                out.println("<td>" + arrival_time + "</td>");
                out.println("<td>" + (is_paid == 1 ? "Paid" : "Not Paid") + "</td>");

                if (is_paid == 1) {
                	out.println("<td><form method='post' action=''><input type='hidden' name='ticket_number' value='" + ticket_number + "'><input type='submit' value='Cancel' onclick='return confirmCancellation();'></form></td>");
                } else {
                    out.println("<td>Contact customer service to pay cancellation fee</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>");

            rs.close();
            pstmt.close();
            con.close();
        %>
    </div>
</body>
</html>