<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>REP FAQ</title>
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
    Integer qid = 6; // received from the request parameter
    String answer = "akjfhskahf"; // the answer to update
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // Update the FAQ answer
        String updateSQL = "UPDATE FAQ SET answer = ? WHERE qid = ?";
        pstmt = con.prepareStatement(updateSQL);
        pstmt.setString(1, answer);
        pstmt.setInt(2, qid);
        pstmt.executeUpdate(); // Execute update

        // Fetch updated FAQs
        String fetchSQL = "SELECT * FROM FAQ;";
        pstmt = con.prepareStatement(fetchSQL);
        rs = pstmt.executeQuery();

        out.println("<h2>FAQ</h2>");
        out.println("<table>");
        out.println("<tr><th>Question ID</th><th>Question</th><th>Answer</th></tr>");

        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getInt("qid") + "</td>");
            out.println("<td>" + rs.getString("question") + "</td>");
            out.println("<td>" + rs.getString("answer") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
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
