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
                    <!-- Additional navigation items -->
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="tab">
           <!--  <a href="editCustomerReservations1.jsp" class="tablinks">Customer Functions</a>
            <a href="airportFlightList.jsp" class="tablinks">Airport Flight List</a>
            <a href=search.jsp" class="tablinks">Airport, Aircraft, Flight Functions</a> -->
            <a href="postFAQjsp" class="tablinks">Ask a Question</a>
            <a href="searchFAQ.jsp" class="tablinks">Search FAQ</a>
            <a href="upcomingAndPastFlights.jsp" class="tablinks active">Past and Upcoming Itinerary</a>
        </div>
    </div>

    <div class="container">
<%
    Class.forName("com.mysql.jdbc.Driver");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    String customerIDGlobal = (String) session.getAttribute("customerIDGlobal");
    String Custid = customerIDGlobal;
    Custid="2";
    // Flights departing before the current datetime
    ResultSet rsBefore = st.executeQuery("SELECT * FROM flight f, ticketed_flights tf WHERE f.f_id = tf.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id AND cust_id = " + Custid + " AND departure_time < NOW() ORDER BY departure_time ASC;");
    
    out.println("<h2>Flights Departing Before Current Datetime</h2>");
    out.println("<table>");
    out.println("<tr><th>Ticket_number</th><th>Airline ID</th><th>Aircraft ID</th><th>Flight IDs</th><th>Departure Time</th><th>Arrival Time</th><th>Departure Airport</th><th>Arrival Airport</th><th>Fare</th></tr>");
    while (rsBefore.next()) {
    	String ticket_number = rsBefore.getString("ticket_number");
        String airline_id = rsBefore.getString("airline_id");
        String aircraft_id = rsBefore.getString("aircraft_id");
        String f_id = rsBefore.getString("f_id");
        String departure_time = rsBefore.getString("departure_time");
        String arrival_time = rsBefore.getString("arrival_time");
        String departure_apt = rsBefore.getString("departure_apt");
        String arrival_apt = rsBefore.getString("arrival_apt");
        Double fare = rsBefore.getDouble(10)+rsBefore.getDouble(11);

        out.println("<tr>");
        out.println("<td>" + ticket_number + "</td>");
        out.println("<td>" + airline_id + "</td>");
        out.println("<td>" + aircraft_id + "</td>");
        out.println("<td>" + f_id + "</td>");
        out.println("<td>" + departure_time + "</td>");
        out.println("<td>" + arrival_time + "</td>");
        out.println("<td>" + departure_apt + "</td>");
        out.println("<td>" + arrival_apt + "</td>");
        out.println("<td>" + fare + "</td>");
        out.println("</tr>");
    }
    out.println("</table>");

    // Flights departing after the current datetime
    ResultSet rsAfter = st.executeQuery("SELECT * FROM flight f, ticketed_flights tf WHERE f.f_id = tf.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id AND cust_id = " + Custid + " AND departure_time > NOW() ORDER BY departure_time ASC;");

    out.println("<h2>Flights Departing After Current Datetime</h2>");
    out.println("<table>");
    out.println("<tr><th>Ticket_number</th><th>Airline ID</th><th>Aircraft ID</th><th>Flight IDs</th><th>Departure Time</th><th>Arrival Time</th><th>Departure Airport</th><th>Arrival Airport</th><th>Fare</th></tr>");
    while (rsAfter.next()) {
        // Assuming same column names as in rsBefore
        String ticket_number = rsAfter.getString("ticket_number");
        String airline_id = rsAfter.getString("airline_id");
        String aircraft_id = rsAfter.getString("aircraft_id");
        String f_id = rsAfter.getString("f_id");
        String departure_time = rsAfter.getString("departure_time");
        String arrival_time = rsAfter.getString("arrival_time");
        String departure_apt = rsAfter.getString("departure_apt");
        String arrival_apt = rsAfter.getString("arrival_apt");
        Double fare = rsAfter.getDouble(10)+rsAfter.getDouble(11);

        out.println("<tr>");
        out.println("<td>" + ticket_number + "</td>");
        out.println("<td>" + airline_id + "</td>");
        out.println("<td>" + aircraft_id + "</td>");
        out.println("<td>" + f_id + "</td>");
        out.println("<td>" + departure_time + "</td>");
        out.println("<td>" + arrival_time + "</td>");
        out.println("<td>" + departure_apt + "</td>");
        out.println("<td>" + arrival_apt + "</td>");
        out.println("<td>" + fare + "</td>");
        out.println("</tr>");
    }
    out.println("</table>");

    rsBefore.close();
    rsAfter.close();
    st.close();
    con.close();
%>
</div>
</body>
</html>
