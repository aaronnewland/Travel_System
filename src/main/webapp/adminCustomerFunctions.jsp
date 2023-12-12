<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>ADMIN ADD EDIT DELETE</title>
    <style>
        table, th, td {
            border: 1px solid black;
        </head>
        <body>
        <%
            String first_name = "testpost first name"; // get parameter
            String mid_init = "";
            String last_name = "testpost last name";
            int cust_id;

            Connection con = null;
            PreparedStatement pstmt = null;
                ApplicationDB db = new ApplicationDB();
                con = db.getConnection();

                // Fetching the maximum cust_id
                st = con.createStatement();
                rs = st.executeQuery("SELECT MAX(id) FROM CUSTOMER");
                if (rs.next()) {
                    cust_id = rs.getInt(1) + 1;
                } else {
                    cust_id = 1; // default to 1 if the table is empty
                }

                // Use PreparedStatement for inserting data
                String insertSQL = "INSERT INTO CUSTOMER VALUES (?, ?, ?, ?)";
                pstmt = con.prepareStatement(insertSQL);
                pstmt.setInt(1, cust_id);
                pstmt.setString(2, first_name);
                pstmt.setString(3, last_name);
                pstmt.setString(4, mid_init);
                pstmt.executeUpdate();

                // Fetching data to display
                rs = st.executeQuery("SELECT * FROM CUSTOMER;");
                out.println("<table>");
                out.println("<tr><th>Question_No</th><th>Question</th><th>Answer</th>");
                out.println("<tr><th>ID</th><th>First Name</th><th>Last Name</th><th>Mid Init</th>");

                while (rs.next()) {
                    String id = rs.getString(1);
                    String fName = rs.getString(2);
                    String lName = rs.getString(3);
                    String mInit = rs.getString(4);

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + fName + "</td>");
                    out.println("<td>" + lName + "</td>");
                    out.println("<td>" + mInit + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
        %>
</body>
</html>
