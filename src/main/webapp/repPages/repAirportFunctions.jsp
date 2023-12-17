<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="com.example.travel_system.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Rep Airport, Airline, Aircraft Functions</title>
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
                <h1><span class="highlight">Rep</span> Airport, Airline, Flight Functions</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="repLandingPage2.jsp">Rep Home Page</a></li>
                    <!-- Other navigation items -->
                </ul>
            </nav>
        </div>
    </header>

  <div class="container">
        <div class="tab">
            <a href="editCustomerReservations.jsp" class="tablinks">Customer Functions</a>
            <a href="airportFlightList.jsp" class="tablinks">Airport Flight List</a>
            <a href="repAirportFunctions.jsp" class="tablinks active">Airport, Aircraft, Flight Functions</a>
            <a href="repFAQ.jsp" class="tablinks">Answer FAQ</a>
            <a href="waitList.jsp" class="tablinks">Waitlist</a>
        </div>
    </div>

    <div class="container">
        <div class="form-section">
            <h2>Aircraft Operations</h2>
            <form action="" method="post">
                <input type="number" name="aircraft_id" placeholder="Aircraft ID" required>
                <input type="number" name="num_seats" placeholder="Number of Seats">
                <input type="text" name="airline_id" placeholder="Airline ID" required>

                <label><input type="radio" name="action" value="add" checked> Add</label>
                <label><input type="radio" name="action" value="edit"> Edit</label>
                <label><input type="radio" name="action" value="delete"> Delete</label>

                <input type="submit" value="Submit">
            </form>
        </div>

        <%
    String aircraft_id_param = request.getParameter("aircraft_id");
    String num_seats_param = request.getParameter("num_seats");
    String airline_id = request.getParameter("airline_id");
    String action = request.getParameter("action"); // "add", "edit", "delete"

    int aircraft_id = 0;
    int num_seats = 0;
    if (aircraft_id_param != null && !aircraft_id_param.isEmpty()) {
        aircraft_id = Integer.parseInt(aircraft_id_param);
    }
    if (num_seats_param != null && !num_seats_param.isEmpty()) {
        num_seats = Integer.parseInt(num_seats_param);
    }

    Connection con = null;
    PreparedStatement pstmt = null;
    Statement st = null;
    ResultSet rs = null;
    ResultSet rs2 = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // Check if airline ID exists
        pstmt = con.prepareStatement("SELECT id FROM airline WHERE id = ?");
        pstmt.setString(1, airline_id);
        rs2 = pstmt.executeQuery();

        if (!rs2.next()) {
            out.println("<p>Airline ID not found.</p>");
        } else {
           	try { 
            	if ("add".equals(action)) {
                String insertSQL = "INSERT INTO Aircrafts (aircraft_id, num_seats, airline_id) VALUES (?, ?, ?)";
                pstmt = con.prepareStatement(insertSQL);
                pstmt.setInt(1, aircraft_id);
                pstmt.setInt(2, num_seats);
                pstmt.setString(3, airline_id);
                pstmt.executeUpdate();
                out.println("Change successfully complete");
            	} else if ("edit".equals(action)) {
                String updateSQL = "UPDATE Aircrafts SET num_seats = ? WHERE aircraft_id = ? AND airline_id = ?";
                pstmt = con.prepareStatement(updateSQL);
                pstmt.setInt(1, num_seats);
                pstmt.setInt(2, aircraft_id);
                pstmt.setString(3, airline_id);
                pstmt.executeUpdate();
                out.println("Change successfully complete");
            	} else if ("delete".equals(action)) {
                String deleteSQL = "DELETE FROM Aircrafts WHERE aircraft_id = ?";
                pstmt = con.prepareStatement(deleteSQL);
                pstmt.setInt(1, aircraft_id);
                pstmt.executeUpdate();
                out.println("Change successfully complete");
            	}
           	 } catch (SQLException e) {out.println("<p> Failed to make make a change.");} 
        }

/*         // Display aircraft data
        st = con.createStatement();
        rs = st.executeQuery("SELECT * FROM Aircrafts;");
        out.println("<table>");
        out.println("<tr><th>Aircraft ID</th><th>Number of Seats</th><th>Airline ID</th></tr>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("aircraft_id") + "</td>");
            out.println("<td>" + rs.getInt("num_seats") + "</td>");
            out.println("<td>" + rs.getString("airline_id") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>"); */
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (rs2 != null) rs2.close();
            if (st != null) st.close();
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
