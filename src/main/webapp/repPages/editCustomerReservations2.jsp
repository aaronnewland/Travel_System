<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="com.example.travel_system.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Rep Edit Customer Reservations</title>
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
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">Rep</span> Edit Customer Reservations</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="repLandingPage2.jsp">Rep Home Page</a></li>
                    <li><a href='../logout.jsp'>Log out</a></li>
                
                </ul>
            </nav>
        </div>
    </header>

   <div class="container">
        <div class="tab">
            <a href="editCustomerReservations1.jsp" class="tablinks active">Edit Customer Reservations</a>
            <a href="airportFlightList.jsp" class="tablinks">Airport Flight List</a>
            <a href="repAirportFunctions.jsp" class="tablinks">Airport, Aircraft, Flight Functions</a>
            <a href="repFAQ.jsp" class="tablinks">Answer FAQ</a>
            <a href="waitList.jsp" class="tablinks">Waitlist</a>
            <a href="repMakeReservations.jsp" class="tablinks">Rep Make Reservations</a>
        </div>
    </div>

<div class="container">
        <!-- Delete Ticket Form -->
        <div class="form-section">
            <h2>Delete Ticket</h2>
            <form action="" method="post">
                <input type="hidden" name="action" value="delete_ticket">
                Ticket Number: <input type="text" name="ticket_number" required>
                <input type="submit" value="Delete Ticket">
            </form>
        </div>

        <!-- Change Seat Number Form -->
        <div class="form-section">
            <h2>Change Seat Number</h2>
            <form action="" method="post">
                <input type="hidden" name="action" value="change_seat">
                New Seat Number: <input type="text" name="new_seat_number" required>
                Ticket Number: <input type="text" name="ticket_number" required>
                <input type="submit" value="Change Seat">
            </form>
        </div>

    
        <div class="form-section">
            <h2>Change Class</h2>
            <form action="" method="post">
                <input type="hidden" name="action" value="change_class">
                <label><input type="radio" name="new_class" value="economy" required> Economy</label>
                <label><input type="radio" name="new_class" value="business" required> Business</label>
                <label><input type="radio" name="new_class" value="first" required> First</label>
                Ticket Number: <input type="text" name="ticket_number" required>
                <input type="submit" value="Change Class">
            </form>
        </div>


        <div class="form-section">
            <h2>Cancellation Fee Paid</h2>
            <form action="" method="post">
                <input type="hidden" name="action" value="update_is_paid">
                <label><input type="checkbox" name="is_paid"> Cancellation Fee Paid</label>
                Ticket Number: <input type="text" name="ticket_number" required>
                <input type="submit" value="Update Status">
            </form>
        </div>
    </div>

    <%
    		String custId_param = request.getParameter("customerID");
    		int custId = 0;
    		if (custId_param != null && !custId_param.isEmpty()) { 
        	custId = Integer.parseInt(custId_param); 
    		}





		if (custId_param != null && !custId_param.isEmpty()) { custId = Integer.parseInt(custId_param); }

        // Process form submission
        String action = request.getParameter("action");
        String ticketNumberStr = request.getParameter("ticket_number");
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PreparedStatement pstmt2 = null;

        try {
        	
        	 Class.forName("com.mysql.jdbc.Driver");
             ApplicationDB db = new ApplicationDB();
             con = db.getConnection();
             int ticketNumber = 0;
              
        	pstmt2 = con.prepareStatement("select * from ticketed_flights where cust_id = ?;");
            pstmt2.setInt(1, custId);
            rs = pstmt2.executeQuery();
            out.println("<h2>Current Tickets for Customer ID " + custId + "</h2>");
            out.println("<table>");
            out.println("<tr><th>Ticket Number</th><th>Airline ID</th><th>Aircraft ID</th><th>Flight ID</th><th>Cancellation fee</th><th>Class</th><th>Seat Number</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("ticket_number") + "</td>");
                out.println("<td>" + rs.getString("airline_id") + "</td>");
                out.println("<td>" + rs.getString("aircraft_id") + "</td>");
                out.println("<td>" + rs.getString("f_id") + "</td>");
                if (!"economy".equals(rs.getString("class"))) {
                    out.println("<td> Cancellation included </td>");
                } else {
                    out.println("<td>" + rs.getString("is_paid") + "</td>");
                }
                out.println("<td>" + rs.getString("class") + "</td>");
                out.println("<td>" + rs.getString("seat_num") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");

          
            
            // Parse ticket number if provided
            if (ticketNumberStr != null && !ticketNumberStr.isEmpty()) {
                ticketNumber = Integer.parseInt(ticketNumberStr);
            }

            // Check action type and execute corresponding SQL query
            if ("delete_ticket".equals(action) && ticketNumber > 0) {
                pstmt = con.prepareStatement("DELETE FROM ticketed_flights WHERE ticket_number = ?");
                pstmt.setInt(1, ticketNumber);
                pstmt.executeUpdate();
                out.println("<p>Ticket deleted successfully.</p>");
            } else if ("change_seat".equals(action) && ticketNumber > 0) {
                String newSeatNumberStr = request.getParameter("new_seat_number");
                pstmt = con.prepareStatement("UPDATE ticketed_flights SET seat_num = ? WHERE ticket_number = ?");
                pstmt.setString(1, newSeatNumberStr);
                pstmt.setInt(2, ticketNumber);
                pstmt.executeUpdate();
                out.println("<p>Seat number updated successfully.</p>");
            } else if ("change_class".equals(action) && ticketNumber > 0) {
                String newClass = request.getParameter("new_class");
                pstmt = con.prepareStatement("UPDATE ticketed_flights SET class = ? WHERE ticket_number = ?");
                pstmt.setString(1, newClass);
                pstmt.setInt(2, ticketNumber);
                pstmt.executeUpdate();
                out.println("<p>Class updated successfully.</p>");
            } else if ("update_is_paid".equals(action) && ticketNumber > 0) {
                String isPaid = request.getParameter("is_paid") != null ? "1" : "0";
                pstmt = con.prepareStatement("UPDATE ticketed_flights SET is_paid = ? WHERE ticket_number = ?");
                pstmt.setString(1, isPaid);
                pstmt.setInt(2, ticketNumber);
                pstmt.executeUpdate();
                out.println("<p>Cancellation payment status updated.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
</html>