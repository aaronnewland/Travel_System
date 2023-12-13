<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Flight Information</title>
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
    String apt_id = "ewr"; // received from the request parameter
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        String sqlQuery = "SELECT * FROM flight WHERE departure_apt = ? OR arrival_apt = ?;";
        pstmt = con.prepareStatement(sqlQuery);
        pstmt.setString(1, apt_id); // Set the parameter
        pstmt.setString(2, apt_id); // Set the parameter again for the second placeholder
        rs = pstmt.executeQuery();
        		
        out.println("<h2>Flight Details for " + apt_id.toUpperCase() + "</h2>");
        out.println("<table>");
        out.println("<tr><th>Airline ID</th><th>Aircraft ID</th><th>Flight ID</th><th>Departure Time</th><th>Arrival Time</th><th>Departure Airport</th><th>Arrival Airport</th><th>Day of Week</th><th>Is International</th><th>Fare</th><th>Booking Fee</th></tr>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("airline_id") + "</td>");
            out.println("<td>" + rs.getInt("aircraft_id") + "</td>");
            out.println("<td>" + rs.getInt("f_id") + "</td>");
            out.println("<td>" + rs.getTimestamp("departure_time") + "</td>");
            out.println("<td>" + rs.getTimestamp("arrival_time") + "</td>");
            out.println("<td>" + rs.getString("departure_apt") + "</td>");
            out.println("<td>" + rs.getString("arrival_apt") + "</td>");
            out.println("<td>" + rs.getString("day_of_week") + "</td>");
            out.println("<td>" + rs.getBoolean("is_international") + "</td>");
            out.println("<td>" + rs.getFloat("fare") + "</td>");
            out.println("<td>" + rs.getFloat("booking_fee") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace(); // Consider better error handling for production
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
</body>
</html>
