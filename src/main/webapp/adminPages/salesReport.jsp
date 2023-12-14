<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
	<h1>SALES REPORT</h1>
    <title>Sales Report</title>
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
    // Get month for sales report from admin landing page
    int month = Integer.parseInt(request.getParameter("monthYearSelected").substring(5));

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();
        st = con.createStatement();

        rs = st.executeQuery("SELECT count(tf.ticket_number) as total_customers, SUM(f.fare + f.booking_fee) as Total_revenue, SUM(f.booking_fee) as profit_from_booking " +
            "FROM ticketed_flights tf " +
            "JOIN flight f ON tf.f_id = f.f_id AND f.airline_id = tf.airline_id AND f.aircraft_id = tf.aircraft_id " +
            "LEFT JOIN business_first_ticket bft ON tf.ticket_number = bft.ticket_number AND tf.cust_id = bft.cust_id " +
            "LEFT JOIN economy_ticket et ON tf.ticket_number = et.ticket_number AND tf.cust_id = et.cust_id " +
            "WHERE MONTH(tf.purchase_date) = " + month + ";");

        out.println("<table>");
        out.println("<tr><th>Total Customers</th><th>Total Revenue</th><th>Profit from Booking</th></tr>");

        while (rs.next()) {
            String total_customers = rs.getString("total_customers");
            String total_revenue = rs.getString("Total_revenue");
            String total_profit_from_booking = rs.getString("profit_from_booking");

            out.println("<tr>");
            out.println("<td>" + total_customers + "</td>");
            out.println("<td>" + total_revenue + "</td>");
            out.println("<td>" + total_profit_from_booking + "</td>");
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
