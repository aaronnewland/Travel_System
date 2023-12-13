<%@ page contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<%
    String userid = request.getParameter("username");
    String pwd = request.getParameter("password");
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement st;
    try {
        st = con.createStatement();
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    ResultSet rs;
    try {
        rs = st.executeQuery("SELECT * FROM users WHERE username='" + userid + "' AND BINARY password='" + pwd
                + "'");
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    try {
        if (rs.next()) {
            session.setAttribute("user", userid); // the username will be stored in the session
            String access = rs.getString("access");
            out.println("welcome " + userid);
            out.println("<a href='logout.jsp'>Log out</a>");
            if ("user".equals(access)) {
                ResultSet rs2 = st.executeQuery("SELECT * FROM customer WHERE username='" + userid + "'");

                if (rs2.next()) {
                    session.setAttribute("customerIDGlobal", rs2.getString("id"));
                }


                response.sendRedirect(request.getContextPath() + "/customerPages/customerLandingPage.jsp");
            } else if ("admin".equals(access)) {
                response.sendRedirect(request.getContextPath() + "/adminPages/adminLandingPage.jsp");
            } else if ("rep".equals(access)) {
                response.sendRedirect(request.getContextPath() + "/repPages/repLandingPage.jsp");
            }
        } else {
            out.println("Invalid password <a href='login.jsp'>try again</a>");
        }
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>
</body>
</html>

