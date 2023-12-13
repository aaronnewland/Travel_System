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
	Integer Custid = 1; // get parameter for customer ID
	Integer Fid = 1; // get parameter for flight ID, set to null by default
    // Determine search type based on the parameter received
    String searchType = (Fid != null) ? "f_id" : "cust_id";
    Integer searchValue = (Fid != null) ? Fid : Custid;
    searchType = "f_id";
    searchValue = 1;
    		
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();
        st = con.createStatement();

        String sqlQuery = "SELECT tf.ticket_number, f.airline_id, f.aircraft_id, f.f_id, f.departure_time, f.arrival_time, f.departure_apt, f.arrival_apt, (f.fare + f.booking_fee) AS fare " +
                          "FROM flight f, ticketed_flights tf " +
                          "WHERE f.f_id = tf.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id " +
                          "AND tf." + searchType + " = " + searchValue + " " +
                          "ORDER BY f.departure_time ASC;";

        rs = st.executeQuery(sqlQuery);
        out.println("<h2>Flight Path Results</h2>");
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
        e.printStackTrace();  // For simplicity, printing stack trace. Consider logging this properly.
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
