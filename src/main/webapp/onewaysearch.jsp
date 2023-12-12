 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<%
    String departure = "ewr"; // Default departure value for demonstration
    String arrival = "lhr"; // Default arrival value for demonstration
    Integer connections = 3;
    
    // Establish database connection
    Class.forName("com.mysql.jdbc.Driver");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    // Prepare and execute the SQL query
    Statement st = con.createStatement();
    


    ResultSet rs = st.executeQuery("Call getflightpaths('ewr','lhr',4);");

    // Process the ResultSet (handle the retrieved data)
    while (rs.next()) {
        String arrival_city = rs.getString("arrival");
        String flightpath = rs.getString("flight_path") + "-> lhr";
        Double booking_fees = rs.getDouble("sum_of_booking_fees");
        Double sum_fares = rs.getDouble("sum_of_fares");
        String flight_ids = rs.getString("flight_ids");
        Double total_cost = rs.getDouble("total_cost");
        String airline_ids = rs.getString("airline_ids");
        String aircraft_ids = rs.getString("aircraft_ids");
        // Retrieve other values as needed and perform necessary operations
        // Example:
        out.println(arrival + "/" + arrival_city + " " + flightpath + booking_fees + " " + sum_fares + flight_ids + " " + total_cost + airline_ids + " " + aircraft_ids + "<br>");
        
        
    }
    

    // Close resources
    rs.close();
    st.close();
    con.close();
%>
</body>
</html> --%>


<!DOCTYPE html>
<html>
<head>
    <title>Flight Path Results</title>
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
	
    String departure = "ewr"; // Default departure value for demonstration
    String arrival = "lhr"; // Default arrival value for demonstration
	int numconnect = 3;
   	String departure_date = "2023-12-10";
   
    Class.forName("com.mysql.jdbc.Driver");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    Statement s2 = con.createStatement();
    
 /*   //pick out the ite_id number to add it to underneath the main results?
    ResultSet rs2 = s2.executeQuery("Select max(ite_id) from itinerary;"); rs2.first();
    int current_ite_id = rs2.getInt("ite_id"); */
    
    //getflightPaths(departing airport, arrival airport, number of connections)
    ResultSet rs = st.executeQuery("Call getflightpaths('" + departure + "','" + arrival + "'," + numconnect + ",'" + departure_date + "');");
    
   
    
    out.println("<table>");
    out.println("<tr><th>Arrival City</th><th>Booking Fees</th><th>Sum of Fares</th><th>Flight IDs</th><th>Total Cost</th><th>Airline IDs</th><th>Aircraft IDs</th><th>Duration in min</th></tr>");

    // Process the ResultSet and add rows to the table
    while (rs.next()) {
        String arrival_city = rs.getString("arrival");
        Double booking_fees = rs.getDouble("sum_of_booking_fees");
        Double sum_fares = rs.getDouble("sum_of_fares");
        String flight_ids = rs.getString("flight_ids");
        Double total_cost = rs.getDouble("total_cost");
        String airline_ids = rs.getString("airline_ids");
        String aircraft_ids = rs.getString("aircraft_ids");
        Integer total_duration = rs.getInt("total_duration");

        out.println("<tr>");
        out.println("<td>" + arrival_city + "</td>");
        out.println("<td>" + booking_fees + "</td>");
        out.println("<td>" + sum_fares + "</td>");
        out.println("<td>" + flight_ids + "</td>");
        out.println("<td>" + total_cost + "</td>");
        out.println("<td>" + airline_ids + "</td>");
        out.println("<td>" + aircraft_ids + "</td>");
        out.println("<td>" + total_duration + "</td>");
        out.println("</tr>");
        
        // execute a query that inserts ite_id, and string.split of f_id,airline_id,aircraft_id
       /*  s2.executeQuery("INSERT INTO itinerary()"); */
    }

    out.println("</table>");
    
    rs.close();
    st.close();
    con.close();
%>
</body>
</html>
