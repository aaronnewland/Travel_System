 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>


<!DOCTYPE html>
<html>
<head>
    <title>Search FAQ</title>
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

//    String search_term = "apple"; //grab parameter instead of "apple"

    String search_term = request.getParameter("search_q");

    Class.forName("com.mysql.jdbc.Driver");
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement st = con.createStatement();
    Statement s2 = con.createStatement();
    
 
    ResultSet rs = st.executeQuery("select * from faq WHERE question like '%" + search_term + "%';");
    
   
    
    out.println("<table>");
    out.println("<tr><th>Question_No</th><th>Question</th><th>Answer</th>");

  
    while (rs.next()) {
        String qid = rs.getString(1);
        String question = rs.getString(2);
        String answer = rs.getString(3);
       
        out.println("<tr>");
        out.println("<td>" + qid + "</td>");
        out.println("<td>" + question+ "</td>");
        out.println("<td>" + answer + "</td>");
       
        out.println("</tr>");
        
    }

    out.println("</table>");
    
    rs.close();
    st.close();
    con.close();
%>
</body>
</html>