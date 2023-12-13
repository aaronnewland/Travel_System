<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Waiting List</title>
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
    Integer Fid = 1; // This should be retrieved from a request parameter
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();
        st = con.createStatement();

        String sqlQuery = "SELECT wl.wl_id, wl.f_id, wl.aircraft_id, wl.airline_id, wl.time_added, c.id as cust_id, c.first_name, c.middle_name, c.last_name FROM waitlist wl JOIN customer c on wl.cust_id = c.id WHERE wl.f_id = " + Fid + ";";
        rs = st.executeQuery(sqlQuery);
        out.println("<h2>Waiting List Details</h2>");
        out.println("<table>");
        out.println("<tr><th>Waitlist ID</th><th>Flight ID</th><th>Aircraft ID</th><th>Airline ID</th><th>Time Added</th><th>Customer ID</th><th>First Name</th><th>Middle Name</th><th>Last Name</th></tr>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("wl_id") + "</td>");
            out.println("<td>" + rs.getInt("f_id") + "</td>");
            out.println("<td>" + rs.getInt("aircraft_id") + "</td>");
            out.println("<td>" + rs.getString("airline_id") + "</td>");
            out.println("<td>" + rs.getTime("time_added").toString() + "</td>");
            out.println("<td>" + rs.getInt("cust_id") + "</td>");
            out.println("<td>" + rs.getString("first_name") + "</td>");
            out.println("<td>" + rs.getString("middle_name") + "</td>");
            out.println("<td>" + rs.getString("last_name") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace(); // Consider better error handling for production
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
