<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer Reservations</title>
</head>
<body>
    <%
        // Assuming these parameters are passed to the JSP
        int ticket_number = Integer.parseInt(request.getParameter("ticket_number"));
        int new_seat_number = Integer.parseInt(request.getParameter("new_seat_number"));
        boolean delete_ticket = Boolean.parseBoolean(request.getParameter("delete_ticket"));
        boolean change_seat = Boolean.parseBoolean(request.getParameter("change_seat"));
        boolean is_paid = Boolean.parseBoolean(request.getParameter("paid"));
		boolean is_economy = Boolean.parseBoolean(request.getParameter("is_economy"));
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
		
        
        //testing parameters 
        ticket_number = 22;
        new_seat_number = 25;
        
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            ApplicationDB db = new ApplicationDB();
            con = db.getConnection();

            if (delete_ticket) {
                // Delete ticket
                pstmt = con.prepareStatement("DELETE FROM ticketed_flights WHERE ticket_number = ?");
                pstmt.setInt(1, ticket_number);
                pstmt.executeUpdate();
            }
            
            
            if (is_paid) {
            	 pstmt = con.prepareStatement("UPDATE economy_ticket SET is_paid = ? WHERE ticket_number = ?");
                 pstmt.setBoolean(1,is_paid);
                 pstmt.setInt(2, ticket_number);
                 pstmt.executeUpdate();	
            }
            

             if (!is_economy) {
                    pstmt = con.prepareStatement("UPDATE business_first_ticket SET seat_number = ? WHERE ticket_number = ?");
                    pstmt.setInt(1, new_seat_number);
                    pstmt.setInt(2, ticket_number);
                    pstmt.executeUpdate();
            } else {
                    pstmt = con.prepareStatement("UPDATE economy_ticket SET seat_number = ? WHERE ticket_number = ?");
                    pstmt.setInt(1, new_seat_number);
                    pstmt.setInt(2, ticket_number);
                    pstmt.executeUpdate();
            } 

                // Update is_paid in economy_ticket
               

                // Update is_first in business_first_ticket
                /* pstmt = con.prepareStatement("UPDATE business_first_ticket SET is_first = ? WHERE ticket_number = ?");
                pstmt.setBoolean(1, is_first);
                pstmt.setInt(2, ticket_number);
                pstmt.executeUpdate();
            } */

            out.println("<p>Operation completed successfully.</p>");

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
</body>
</html>
