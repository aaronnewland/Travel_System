<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Aircraft Management</title>
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

    action = "add";
    airline_id = "bc"; 
    aircraft_id = 300;
    num_seats = 3000;
    
    Connection con = null;
    PreparedStatement pstmt = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // Add, edit, or delete aircraft based on the action
        if ("add".equals(action)) {
        	String insertSQL = "Insert into Airline VALUES (?);";
        	pstmt = con.prepareStatement(insertSQL);
        	pstmt.setString(1,airline_id);
        	pstmt.executeUpdate();
            insertSQL = "INSERT INTO Aircrafts (aircraft_id, num_seats, airline_id) VALUES (?, ?, ?)";
            pstmt = con.prepareStatement(insertSQL);
            pstmt.setInt(1, aircraft_id);
            pstmt.setInt(2, num_seats);
            pstmt.setString(3, airline_id);
            pstmt.executeUpdate();
        } else if ("edit".equals(action)) {
            String updateSQL = "UPDATE Aircrafts SET num_seats = ?, airline_id = ? WHERE aircraft_id = ?";
            pstmt = con.prepareStatement(updateSQL);
            pstmt.setInt(1, num_seats);
            pstmt.setString(2, airline_id);
            pstmt.setInt(3, aircraft_id);
            pstmt.executeUpdate();
        } else if ("delete".equals(action)) {
            String deleteSQL = "DELETE FROM Aircrafts WHERE aircraft_id = ?";
            pstmt = con.prepareStatement(deleteSQL);
            pstmt.setInt(1, aircraft_id);
            pstmt.executeUpdate();
        }

        // Fetching data to display
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
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace(); // Consider better error handling for production
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
</body>
</html>
