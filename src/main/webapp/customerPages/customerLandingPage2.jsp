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
                    <li><a href="repLandingPage2.jsp">Customer Home</a></li>
                    <!-- Additional navigation items -->
                </ul>
            </nav>
        </div>
    </header>

   <div class="container">
        <div class="tab">
          <!--  <a href="editCustomerReservations1.jsp" class="tablinks">Customer Functions</a>
            <a href="airportFlightList.jsp" class="tablinks">Airport Flight List</a> -->
            <a href="customerLandingPage2.jsp" class="tablinks active">Home</a>
            <a href="cancelFlight.jsp" class="tablinks">Cancel a flight</a>
            <a href="postFAQ.jsp" class="tablinks">Ask a Question</a>
            <a href="searchFAQ.jsp" class="tablinks">Search FAQ</a>
            <a href="upcomingAndPastFlights.jsp" class="tablinks">Past and Upcoming Itinerary</a>
        </div>
    </div>
    
    <hr>
    <hr>
    <div class="center">
      <%--   <% 
                if (session.getAttribute("user") == null) {
            %>
            You are not logged in<br/>
            <a href="../login.jsp">Please Login</a>
            <% --%>  <!-- } else { -->
                <!-- out.println("Welcome " + session.getAttribute("user") + "!<br>");
                out.println("<a href='../logout.jsp'>Log out</a><br><br>");

                String customerIDGlobal = (String) session.getAttribute("customerIDGlobal");
                int Custid = Integer.parseInt(customerIDGlobal);  -->
               <%
                int Custid = 1;

                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    ApplicationDB db = new ApplicationDB();
                    con = db.getConnection();

                    String sqlQuery = "select * from waitlist wl join flight f using (f_id,aircraft_id,airline_id) where wl.cust_id = ?;";
                    pstmt = con.prepareStatement(sqlQuery);
                    pstmt.setInt(1, Custid);
                    rs = pstmt.executeQuery();

                    out.println("<table>");
                    out.println("Currently on the waiting list for the following flights. Purchase is available for flights with available seats");
                    		
                    out.println("<tr><th>Flight ID</th><th>Aircraft ID</th><th>Airline ID</th><th>Time Added</th><th>Departure City</th><th>Arrival City</th><th>Action</th></tr>");

                    while (rs.next()) {
                        int f_id = rs.getInt("f_id");
                        int aircraft_id = rs.getInt("aircraft_id");
                        String airline_id = rs.getString("airline_id");
                        String timeAdded = rs.getString("time_added");
                        String departCity = rs.getString("departure_apt");
                        String arrivalCity = rs.getString("arrival_apt");

                        // Check if seats are available
                        String ticketCountQuery = "SELECT COUNT(ticket_number) FROM ticketed_flights WHERE f_id= ? AND aircraft_id = ? AND airline_id = ?;";
                        pstmt = con.prepareStatement(ticketCountQuery);
                        pstmt.setInt(1, f_id);
                        pstmt.setInt(2, aircraft_id);
                        pstmt.setString(3, airline_id);
                        ResultSet ticketRs = pstmt.executeQuery();
                        int ticketed_passengers = 0;
                        if (ticketRs.next()) {
                            ticketed_passengers = ticketRs.getInt(1);
                        }

                        String seatCountQuery = "SELECT num_seats FROM Aircrafts WHERE aircraft_id = ? AND airline_id = ?;";
                        pstmt = con.prepareStatement(seatCountQuery);
                        pstmt.setInt(1, aircraft_id);
                        pstmt.setString(2, airline_id);
                        ResultSet seatRs = pstmt.executeQuery();
                        int numSeats = 0;
                        if (seatRs.next()) {
                            numSeats = seatRs.getInt(1);
                        }

                        out.println("<tr>");
                        out.println("<td>" + f_id + "</td>");
                        out.println("<td>" + aircraft_id + "</td>");
                        out.println("<td>" + airline_id + "</td>");
                        out.println("<td>" + timeAdded + "</td>");
                        out.println("<td>" + departCity + "</td>");
                        out.println("<td>" + arrivalCity + "</td>");

                        // Show purchase button if seats are available
                        if (ticketed_passengers < numSeats) {
                            out.println("<td><form method='post' action='purchaseTicket.jsp'><input type='hidden' name='f_id' value='" + f_id + "'>" 
                                        + "<input type='hidden' name='aircraft_id' value='" + aircraft_id + "'>"
                                        + "<input type='hidden' name='airline_id' value='" + airline_id + "'>"
                                        + "<input type='submit' value='Purchase'></form></td>");
                        } else {
                            out.println("<td>Full</td>");
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
</body>
</html>
