<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Reservation List</title>
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
        out.println("<h2>Most active flights</h2>");
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
