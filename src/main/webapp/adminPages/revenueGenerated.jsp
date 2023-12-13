<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <h1>Revenue Report</h1>
    <title>Revenue Report</title>
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
    String filterType = request.getParameter("filterType"); // "flight", "airline", or "customer"
    String filterValue = request.getParameter("filterValue"); // f_id, airline_id, or customer_id
    filterType = "flight";
    filterValue = "1";

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();
        st = con.createStatement();

        String sqlQuery = "";
        if ("flight".equals(filterType)) {
            sqlQuery = "SELECT SUM(f.fare + f.booking_fee) AS revenue FROM flight f WHERE f.f_id = " + filterValue + ";";
        } else if ("airline".equals(filterType)) {
            sqlQuery = "SELECT SUM(f.fare + f.booking_fee) AS revenue FROM flight f WHERE f.airline_id = '" + filterValue + "';";
        } else if ("customer".equals(filterType)) {
            sqlQuery = "SELECT SUM(f.fare + f.booking_fee) AS revenue FROM ticketed_flights tf JOIN flight f ON tf.f_id = f.f_id WHERE tf.cust_id = " + filterValue + ";";
        }

        rs = st.executeQuery(sqlQuery);
        out.println("<table>");
        out.println("<tr><th>Type</th><th>Value</th><th>Revenue Generated</th></tr>");

        if (rs.next()) {
            String revenue = rs.getString("revenue");
            out.println("<tr>");
            out.println("<td>" + filterType + "</td>");
            out.println("<td>" + filterValue + "</td>");
            out.println("<td>" + revenue + "</td>");
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
