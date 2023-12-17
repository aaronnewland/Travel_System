<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.example.travel_system.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer Reservations</title>
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

        .form-section {
            background: #ffffff;
            padding: 20px;
            margin-top: 20px;
        }

        .form-section h2 {
            color: #50b3a2;
        }

        .form-section form {
            margin-top: 15px;
        }

        .form-section form input[type="text"], .form-section form input[type="number"], .form-section form input[type="submit"], .form-section form input[type="radio"] {
            padding: 10px;
            margin: 5px;
        }

        .form-section form input[type="submit"] {
            background: #50b3a2;
            border: 0;
            color: white;
            cursor: pointer;
        }

        .form-section form input[type="submit"]:hover {
            background: #333;
        }

        /* New Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            min-width: 400px;
            border-radius: 5px 5px 0 0;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
        }

        table thead tr {
            background-color: #009879;
            color: white;
            text-align: left;
        }

        table th, table td {
            padding: 12px 15px;
        }

        table tbody tr {
            border-bottom: 1px solid #dddddd;
        }

        table tbody tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }

        table tbody tr:last-of-type {
            border-bottom: 2px solid #009879;
        }

        table tbody tr.active-row {
            font-weight: bold;
            color: #009879;
        }
    </style>

   <script>
        function toggleInputFields() {
            var action = document.querySelector('input[name="action"]:checked').value;
            var newSeatNumberField = document.getElementById('newSeatNumberField');
            var classChangeOptions = document.getElementById('classChangeOptions');
            var paidCheckbox = document.getElementById('paidCheckbox');

            newSeatNumberField.style.display = (action === 'change_seat') ? 'block' : 'none';
            classChangeOptions.style.display = (action === 'changeClass') ? 'block' : 'none';
            paidCheckbox.style.display = (action === 'is_Paid') ? 'block' : 'none';
        }
    </script>
</head>
<body onload="toggleInputFields()">
    <header>
        <!-- Header content -->
    </header>

    <div class="container">
        <div class="form-section">
            <h2>Edit Ticket</h2>
            <form action="" method="post">
                <!-- Form fields -->
                <input type="number" name="ticket_number" placeholder="Ticket Number" required>
                <div id="newSeatNumberField" style="display:none;">
                    <input type="number" name="new_seat_number" placeholder="New Seat Number">
                </div>

                <!-- Class Change Options (initially hidden) -->
                <div id="classChangeOptions" style="display:none;">
                    <label><input type="radio" name="new_class" value="economy"> Economy</label>
                    <label><input type="radio" name="new_class" value="business"> Business</label>
                    <label><input type="radio" name="new_class" value="first_class"> First Class</label>
                </div>

                <!-- Paid Checkbox (initially hidden) -->
                <div id="paidCheckbox" style="display:none;">
                    <label><input type="checkbox" name="is_paid" value="yes"> Paid for Cancellation</label>
                </div>

                <!-- Action Radio Buttons -->
                <label><input type="radio" name="action" value="change_seat" onclick="toggleInputFields()"> Change Seat</label>
                <label><input type="radio" name="action" value="delete_ticket" onclick="toggleInputFields()"> Delete Ticket</label>
                <label><input type="radio" name="action" value="is_Paid" onclick="toggleInputFields()"> Pay for cancellation (for Economy only)</label>
                <label><input type="radio" name="action" value="changeClass" onclick="toggleInputFields()"> Change class</label>
                <input type="submit" value="Submit">
            </form>
        </div>
       <%
            // Server-side code to handle the form submission and check ticket existence
            int custId = 0;
            String ticketNumberStr = request.getParameter("ticket_number");
            String action = request.getParameter("action");
            String custId_param = request.getParameter("customerIDEdit");
            
            if (custId_param != null && !custId_param.isEmpty()) { custId = Integer.parseInt(custId_param); }
            
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            PreparedStatement pstmt2 = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                ApplicationDB db = new ApplicationDB();
                con = db.getConnection();

                if (ticketNumberStr != null && !ticketNumberStr.isEmpty()) {
                    int ticketNumber = Integer.parseInt(ticketNumberStr);

                    // Check if ticket exists
                    pstmt = con.prepareStatement("SELECT * FROM ticketed_flights WHERE ticket_number = ?");
                    pstmt.setInt(1, ticketNumber);
                    rs = pstmt.executeQuery();

                    if (!rs.next()) {
                        out.println("<p>No ticket number found.</p>");
                    } else {
                        if ("delete_ticket".equals(action)) {
                            // Delete ticket
                            pstmt = con.prepareStatement("DELETE FROM ticketed_flights WHERE ticket_number = ?");
                            pstmt.setInt(1, ticketNumber);
                            pstmt.executeUpdate();
                            out.println("<p>Ticket deleted successfully.</p>");
                        } else if ("change_seat".equals(action)) {
                            String newSeatNumberStr = request.getParameter("new_seat_number");
                            int newSeatNumber = Integer.parseInt(newSeatNumberStr);
                            pstmt = con.prepareStatement("UPDATE ticketed_flights SET seat_num = ? WHERE ticket_number = ?");
                            pstmt.setInt(1, newSeatNumber);
                            pstmt.setInt(2, ticketNumber);
                            pstmt.executeUpdate();
                            out.println("<p>Seat changed successfully.</p>");
                        } else if ("changeClass".equals(action)) {
                            String newClass = request.getParameter("new_class");
                            pstmt = con.prepareStatement("UPDATE ticketed_flights SET class = ? WHERE ticket_number = ?");
                            pstmt.setString(1, newClass);
                            pstmt.setInt(2, ticketNumber);
                            pstmt.executeUpdate();
                            out.println("<p>Class changed successfully.</p>");
                        } else if ("is_Paid".equals(action)) {
                            String isPaid = request.getParameter("is_paid") != null ? "1" : "0";
                            pstmt = con.prepareStatement("UPDATE ticketed_flights SET is_paid = ? WHERE ticket_number = ?");
                            pstmt.setString(1, isPaid);
                            pstmt.setInt(2, ticketNumber);
                            pstmt.executeUpdate();
                            out.println("<p>Cancellation payment status updated.</p>");
                        }
                    }
                }

                // Display current tickets for customer
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

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error during operation: " + e.getMessage() + "</p>");
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