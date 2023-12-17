<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>PURCHASE TICKET</title>
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
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Statement st = null;
    int current_ticket_number = 1;

    String[] flightIDs = request.getParameter("flightId").split(",");
    int[] f_ids = new int[flightIDs.length];

    String[] aircraftIDs = request.getParameter("aircraftIds").split(",");
    int[] aircraft_ids = new int[aircraftIDs.length];

    for (int i = 0; i < flightIDs.length; i++) {
        f_ids[i] = Integer.parseInt(flightIDs[i]);
        aircraft_ids[i] = Integer.parseInt(aircraftIDs[i]);
    }

    String[] airline_ids = request.getParameter("airlineIds").split(",");

    int cust_id = Integer.parseInt(request.getParameter("customerID"));
    int ticketed_passengers = 0;
    int numSeats = 0;
    String sqlQuery = "";
    String updateSQL = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // gets the max ticket number
        st = con.createStatement();
        rs = st.executeQuery("SELECT MAX(ticket_number) FROM ticketed_flights");
        if (rs.next()) {
            current_ticket_number = rs.getInt(1) + 1;
        } else {
            current_ticket_number = 1; // default to 1 if the table is empty
        }

        for (int i = 0; i < flightIDs.length; i++) {
            sqlQuery = "select COUNT(ticket_number) from ticketed_flights where f_id= ? and aircraft_id = ? and airline_id = ?; ";
            pstmt = con.prepareStatement(sqlQuery);
            pstmt.setInt(1,f_ids[i]);
            pstmt.setInt(2,aircraft_ids[i]);
            pstmt.setString(3,airline_ids[i]);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                ticketed_passengers = rs.getInt(1); // Retrieves the first column of the current row in the ResultSet
            };

            sqlQuery = "SELECT num_seats FROM Aircrafts WHERE aircraft_id = ? AND airline_id = ?;";
            pstmt = con.prepareStatement(sqlQuery);
            pstmt.setInt(1, aircraft_ids[i]);
            pstmt.setString(2, airline_ids[i]);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                numSeats = rs.getInt(1);

            }


            if (ticketed_passengers+1 > numSeats) {
                updateSQL = "Insert INTO waitlist(f_id,aircraft_id,airline_id,time_added,cust_id) VALUES (?,?,?,NOW(),?);";
                pstmt = con.prepareStatement(updateSQL);
                pstmt.setInt(1, f_ids[i]);
                pstmt.setInt(2, aircraft_ids[i]);
                pstmt.setString(3, airline_ids[i]);
                pstmt.setInt(4,cust_id);
                pstmt.executeUpdate(); // Execute update


            } else {

                // INSERT A TICKETED CUSTOMER
                updateSQL = "Insert INTO ticketed_flights(ticket_number,f_id,cust_id,aircraft_id,airline_id,purchase_date) VALUES(?,?,?,?,?,NOW());";
                pstmt = con.prepareStatement(updateSQL);
                pstmt.setInt(1, current_ticket_number);
                pstmt.setInt(2, f_ids[i]);
                pstmt.setInt(3, cust_id);
                pstmt.setInt(4,aircraft_ids[i]);
                pstmt.setString(5,airline_ids[i]);
                pstmt.executeUpdate(); // Execute update
                out.println("Successfully booked flight number " + f_ids[i] + " on ticket number " + current_ticket_number + ".");
            }
        }


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
