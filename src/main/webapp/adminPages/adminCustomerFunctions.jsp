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
    String first_name = request.getParameter("first_name");
    String mid_init = request.getParameter("mid_init");
    String last_name = request.getParameter("last_name");
    String passed_cust_id_param = request.getParameter("passed_cust_id");
    String custIDtoDelete_param = request.getParameter("custIDtoDelete");
    int cust_id;
    int passed_cust_id = passed_cust_id_param != null && !passed_cust_id_param.isEmpty() ? Integer.parseInt(passed_cust_id_param) : 0;
    int cust_id_to_delete = custIDtoDelete_param != null && !custIDtoDelete_param.isEmpty() ? Integer.parseInt(custIDtoDelete_param) : 0;

    Connection con = null;
    PreparedStatement pstmt = null;
    Statement st = null;
    ResultSet rs = null;
    
    //testCODE
   first_name = "a";
    mid_init="b";
    last_name="c";
    passed_cust_id = 103;
    //cust_id_to_delete = 112;
    
	/* passed_cust_id=999; */
	/* cust_id_to_delete=104;  */
    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // Perform update if passed_cust_id has a value
        if (passed_cust_id > 0) {
            String updateSQL = "UPDATE CUSTOMER SET first_name = ?, last_name = ?, middle_name = ? WHERE id = ?";
            pstmt = con.prepareStatement(updateSQL);
            pstmt.setString(1, first_name);
            pstmt.setString(2, last_name);
            pstmt.setString(3, mid_init);
            pstmt.setInt(4, passed_cust_id);
            pstmt.executeUpdate();
        }

        // Perform delete if custIDtoDelete has a value
        if (cust_id_to_delete > 0) {
            String deleteSQL = "DELETE FROM CUSTOMER WHERE id = ?";
            pstmt = con.prepareStatement(deleteSQL);
            pstmt.setInt(1, cust_id_to_delete);
            pstmt.executeUpdate();
        }

        // Fetching the maximum cust_id for a new customer entry
        st = con.createStatement();
        rs = st.executeQuery("SELECT MAX(id) FROM CUSTOMER");
        if (rs.next()) {
            cust_id = rs.getInt(1) + 1;
        } else {
            cust_id = 1; // default to 1 if the table is empty
        }
        /* out.println(cust_id); */

        // Insert a new customer
        String insertSQL = "INSERT INTO CUSTOMER(id,first_name,last_name,middle_name) VALUES (?, ?, ?, ?);";
        pstmt = con.prepareStatement(insertSQL);
        pstmt.setInt(1, cust_id);
        pstmt.setString(2, first_name);
        pstmt.setString(3, last_name);
        pstmt.setString(4, mid_init);
        pstmt.executeUpdate();

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
