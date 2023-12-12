<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

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
    String post_term = "testpost";

    Connection con = null;
    PreparedStatement pstmt = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // Use PreparedStatement for inserting data
        String insertSQL = "INSERT INTO FAQ(question) VALUES (?)";
        pstmt = con.prepareStatement(insertSQL);
        pstmt.setString(1, post_term);
        pstmt.executeUpdate();

        // Fetching data
        st = con.createStatement();
        rs = st.executeQuery("SELECT * FROM FAQ;");
        out.println("<table>");
        out.println("<tr><th>Question_No</th><th>Question</th><th>Answer</th>");

        while (rs.next()) {
            String qid = rs.getString(1);
            String question = rs.getString(2);
            String answer = rs.getString(3);

            out.println("<tr>");
            out.println("<td>" + qid + "</td>");
            out.println("<td>" + question + "</td>");
            out.println("<td>" + answer + "</td>");
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
