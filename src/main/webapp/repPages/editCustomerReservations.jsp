<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.example.travel_system.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer Reservations</title>
    <style>
        /* Styles from the previous code block */
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
    </style>

    <script>
        function toggleInputFields() {
            var action = document.querySelector('input[name="action"]:checked').value;
            var newSeatNumberField = document.getElementById('newSeatNumberField');
            newSeatNumberField.style.display = (action === 'change_seat') ? 'block' : 'none';
        }
    </script>
</head>
<body onload="toggleInputFields()">
    <header>
        <!-- Header content -->
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">Customer Rep</span> Edit Reservations</h1>
            </div>
            <nav>
                <ul>
                    <li class="current"><a href="customerRepLandingPage">Customer Rep Home Page</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="form-section">
            <h2>Edit Ticket</h2>
            <form action="" method="post">
                <input type="number" name="ticket_number" placeholder="Ticket Number" required>

                <div id="newSeatNumberField">
                    <input type="number" name="new_seat_number" placeholder="New Seat Number">
                </div>

                <label><input type="radio" name="ticket_type" value="economy" checked> Economy Ticket</label>
                <label><input type="radio" name="ticket_type" value="business_first"> Business/First Class Ticket</label>

                <label><input type="radio" name="action" value="change_seat" checked onclick="toggleInputFields()"> Change Seat</label>
                <label><input type="radio" name="action" value="delete_ticket" onclick="toggleInputFields()"> Delete Ticket</label>

                <input type="submit" value="Submit">
            </form>
        </div>

       <%
            // Server-side code to handle the form submission and check ticket existence
            String ticketType = request.getParameter("ticket_type");
            String action = request.getParameter("action");
            String ticketNumberStr = request.getParameter("ticket_number");
            String newSeatNumberStr = request.getParameter("new_seat_number");

            if (ticketNumberStr != null && !ticketNumberStr.isEmpty()) {
                int ticketNumber = Integer.parseInt(ticketNumberStr);
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    ApplicationDB db = new ApplicationDB();
                    con = db.getConnection();

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
                        } else if ("change_seat".equals(action) && newSeatNumberStr != null && !newSeatNumberStr.isEmpty()) {
                            // Change seat
                            int newSeatNumber = Integer.parseInt(newSeatNumberStr);
                            String tableName = "economy".equals(ticketType) ? "economy_ticket" : "business_first_ticket";
                            pstmt = con.prepareStatement("UPDATE " + tableName + " SET seat_number = ? WHERE ticket_number = ?");
                            pstmt.setInt(1, newSeatNumber);
                            pstmt.setInt(2, ticketNumber);
                            pstmt.executeUpdate();
                            out.println("<p>Seat changed successfully.</p>");
                        }
                    }
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
            }
        %>
    </div>
</body>
</html>
