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
    String first_name = "testpost first name"; // get parameter
    String mid_init = "";
    String last_name = "testpost last name";
    int cust_id;
    int passed_cust_id=1;
	
    Connection con = null;
    PreparedStatement pstmt = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
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
        
        // EDIT A CUSTOMER WHERE
        
        

        // Fetching data to display
        rs = st.executeQuery("SELECT * FROM CUSTOMER;");
        out.println("<table>");
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
    } catch (Exception e) {
        e.printStackTrace(); // For simplicity, printing stack trace. Consider logging this properly.
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
