<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Flight Path Results</title>
    <style>
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
<%
    Class.forName("com.mysql.jdbc.Driver");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    Integer Custid = 1; //get parameter
    
    // Flights departing before the current datetime
    ResultSet rsBefore = st.executeQuery("SELECT * FROM flight f, ticketed_flights tf WHERE f.f_id = tf.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id AND cust_id = " + Custid + " AND departure_time < NOW() ORDER BY departure_time ASC;");
    
    out.println("<h2>Flights Departing Before Current Datetime</h2>");
    out.println("<table>");
    out.println("<tr><th>Airline ID</th><th>Aircraft ID</th><th>Flight IDs</th><th>Departure Time</th><th>Arrival Time</th><th>Departure Airport</th><th>Arrival Airport</th><th>Fare</th></tr>");
    while (rsBefore.next()) {
        String airline_id = rsBefore.getString("airline_id");
        String aircraft_id = rsBefore.getString("aircraft_id");
        String f_id = rsBefore.getString("f_id");
        String departure_time = rsBefore.getString("departure_time");
        String arrival_time = rsBefore.getString("arrival_time");
        String departure_apt = rsBefore.getString("departure_apt");
        String arrival_apt = rsBefore.getString("arrival_apt");
        Double fare = rsBefore.getDouble("fare"); // Assuming the fare is in a column named "fare"

        out.println("<tr>");
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
    ResultSet rsAfter = st.executeQuery("SELECT * FROM flight f, ticketed_flights tf WHERE f.f_id = tf.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id AND cust_id = " + Custid + " AND departure_time < NOW() ORDER BY departure_time ASC;");

    out.println("<h2>Flights Departing After Current Datetime</h2>");
    out.println("<table>");
    out.println("<tr><th>Airline ID</th><th>Aircraft ID</th><th>Flight IDs</th><th>Departure Time</th><th>Arrival Time</th><th>Departure Airport</th><th>Arrival Airport</th><th>Fare</th></tr>");
    while (rsAfter.next()) {
        // Assuming same column names as in rsBefore
        String airline_id = rsAfter.getString("airline_id");
        String aircraft_id = rsAfter.getString("aircraft_id");
        String f_id = rsAfter.getString("f_id");
        String departure_time = rsAfter.getString("departure_time");
        String arrival_time = rsAfter.getString("arrival_time");
        String departure_apt = rsAfter.getString("departure_apt");
        String arrival_apt = rsAfter.getString("arrival_apt");
        Double fare = rsAfter.getDouble("fare");

        out.println("<tr>");
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
</body>
</html>
