<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Search FAQ</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }

        header {
            background: #50b3a2;
            color: white;
            padding-top: 30px;
            min-height: 70px;
            border-bottom: #e8491d 3px solid;
        }

        header a {
            color: #ffffff;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 16px;
        }

        header ul {
            padding: 0;
            margin: 0;
            list-style: none;
            overflow: hidden;
        }

        header li {
            float: left;
            display: inline;
            padding: 0 20px 0 20px;
        }

        header #branding {
            float: left;
        }

        header #branding h1 {
            margin: 0;
        }

        header nav {
            float: right;
            margin-top: 10px;
        }

        header .highlight, header .current a {
            color: #e8491d;
            font-weight: bold;
        }

        header a:hover {
            color: #ffffff;
            font-weight: bold;
        }

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
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">ADMIN</span> Search FAQ</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="adminLandingPage">Admin Home Page</a></li>
                    <!-- Add other navigation items as needed -->
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <%
            String search_term = request.getParameter("searchQ");

            Class.forName("com.mysql.jdbc.Driver");
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM FAQ WHERE question LIKE '%" + search_term + "%';");

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

            rs.close();
            st.close();
            con.close();
        %>
    </div>
</body>
</html>
