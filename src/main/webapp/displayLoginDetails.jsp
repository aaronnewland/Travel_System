<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.ApplicationDB"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Title</title>
</head>
<body>
    <% try {

        //Get the database connection
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        //Create a SQL statement
        Statement stmt = con.createStatement();
        //Get the selected radio button from the index.jsp
        String uname = request.getParameter("username");
        String pword = request.getParameter("password");

        out.println(uname);
        out.println(pword);

//        //Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
//        String str = "SELECT * FROM " + entity;
//        //Run the query against the database.
//        ResultSet result = stmt.executeQuery(str);
    %>

<%--    <table>--%>
<%--        <tr>--%>
<%--            <td>Name</td>--%>
<%--            <td>--%>
<%--                <%if (entity.equals("beers"))--%>
<%--                    out.print("Manufacturer");--%>
<%--                else--%>
<%--                    out.print("Address");--%>
<%--                %>--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--        <%--%>
<%--          
<%--            while (result.next()) { %>--%>
<%--        <tr>--%>
<%--            <td><%= result.getString("name") %></td>--%>
<%--            <td>--%>
<%--                <% if (entity.equals("beers")){ %>--%>
<%--                <%= result.getString("manf")%>--%>
<%--                <% }else{ %>--%>
<%--                <%= result.getString("addr")%>--%>
<%--                <% } %>--%>
<%--            </td>--%>
<%--        </tr>--%>


<%--        <% }--%>
<%--            //close the connection.--%>
<%--            db.closeConnection(con);--%>
<%--        %>--%>
<%--    </table>--%>


    <%} catch (Exception e) {
        out.print(e);
    }%>
</body>
</html>


