<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Functions</title>
    <!-- CSS Styles -->
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
        /* Tab styles */
        .tab a {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
            font-size: 17px;
            text-decoration: none;
            color: #333;
            border-radius: 4px;
            margin-right: 5px;
        }
        .tab a:hover {
            background-color: #ddd;
        }
        .tab a.active {
            background-color: #50b3a2;
            color: white;
        }
        .form-section {
            background: #ffffff;
            padding: 20px;
            margin-top: 20px;
        }
        .form-section h2 {
            color: #50b3a2;
        }
        .form-section form {
            margin-top: 15px;
        }
        .form-section form input[type="text"], .form-section form input[type="submit"] {
            padding: 10px;
            margin: 5px;
        }
        .form-section form input[type="submit"] {
            background: #50b3a2;
            border: 0;
            color: white;
            cursor: pointer;
        }
        .form-section form input[type="submit"]:hover {
            background: #333;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #cccccc;
        }
        table th, table td {
            padding: 15px;
            text-align: left;
        }
        table tr:nth-child(even) {
            background: #f2f2f2;
        }
    </style>
</head>
<body>
  <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">ADMIN</span> Admin Customer Functions</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="adminLandingPage2.jsp">Admin Home Page</a></li>
                    <!-- Other navigation items -->
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="tab">
            <a href="adminCustomerFunctions.jsp" class="tablinks active">Customer Functions</a>
            <a href="CustomerRepFunctions.jsp" class="tablinks">Customer Rep Functions</a>
            <a href="salesReport.jsp" class="tablinks">Sales Report</a>
            <a href="reservationList.jsp" class="tablinks">Reservations</a>
            <a href="revenueGenerated.jsp" class="tablinks">Revenue</a>
            <a href="mostActiveFlightList.jsp" class="tablinks">Active Flights</a>
        </div>
    </div>

    <div class="container">
        <!-- Form for Adding a Customer -->
        <div class="form-section">
            <h2>Add Customer</h2>
            <form action="" method="post">
                <input type="text" name="first_name" placeholder="First Name" required>
                <input type="text" name="mid_init" placeholder="Middle Name">
                <input type="text" name="last_name" placeholder="Last Name" required>
                <input type="submit" value="Add Customer">
            </form>
        </div>

        <!-- Form for Editing a Customer -->
        <div class="form-section">
            <h2>Edit Customer</h2>
            <form action="" method="post">
                <input type="text" name="custIDtoEdit" placeholder="Customer ID" required>
                <input type="text" name="first_name" placeholder="First Name" required>
                <input type="text" name="mid_init" placeholder="Middle Name">
                <input type="text" name="last_name" placeholder="Last Name" required>
                <input type="submit" value="Edit Customer">
            </form>
        </div>

        <!-- Form for Deleting a Customer -->
        <div class="form-section">
            <h2>Delete Customer</h2>
            <form action="" method="post">
                <input type="text" name="custIDtoDelete" placeholder="Customer ID" required>
                <input type="submit" value="Delete Customer">
            </form>
        </div>

        <%  
            String firstName = request.getParameter("first_name");
            String midName = request.getParameter("mid_init");
            String lastName = request.getParameter("last_name");
            
            String custIDtoEdit_param = request.getParameter("custIDtoEdit");
            String custIDtoDelete_param = request.getParameter("custIDtoDelete");
            int cust_id;
            int custIDtoEdit = custIDtoEdit_param != null && !custIDtoEdit_param.isEmpty() ? Integer.parseInt(custIDtoEdit_param) : 0;
            int custIDtoDelete = custIDtoDelete_param != null && !custIDtoDelete_param.isEmpty() ? Integer.parseInt(custIDtoDelete_param) : 0;

            Connection con = null;
            PreparedStatement pstmt = null;
            Statement st = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                ApplicationDB db = new ApplicationDB();
                con = db.getConnection();

                // Perform update if custIDtoEdit has a value
                if (custIDtoEdit > 0) {
                    String updateSQL = "UPDATE CUSTOMER SET first_name = ?, last_name = ?, middle_name = ? WHERE id = ?";
                    pstmt = con.prepareStatement(updateSQL);
                    pstmt.setString(1, firstName);
                    pstmt.setString(2, lastName);
                    pstmt.setString(3, midName);
                    pstmt.setInt(4, custIDtoEdit);
                    pstmt.executeUpdate();
                }

                // Perform delete if custIDtoDelete has a value
                if (custIDtoDelete > 0) {
                    String deleteSQL = "DELETE FROM CUSTOMER WHERE id = ?";
                    pstmt = con.prepareStatement(deleteSQL);
                    pstmt.setInt(1, custIDtoDelete);
                    pstmt.executeUpdate();
                }

                // Insert a new customer
                if (firstName != null && !firstName.isEmpty() && custIDtoEdit == 0 && custIDtoDelete == 0) {
                    st = con.createStatement();
                    rs = st.executeQuery("SELECT MAX(id) FROM CUSTOMER");
                    if (rs.next()) {
                        cust_id = rs.getInt(1) + 1;
                    } else {
                        cust_id = 1; // default to 1 if the table is empty
                    }

                    String insertSQL = "INSERT INTO CUSTOMER(id, first_name, last_name, middle_name) VALUES (?, ?, ?, ?);";
                    pstmt = con.prepareStatement(insertSQL);
                    pstmt.setInt(1, cust_id);
                    pstmt.setString(2, firstName);
                    pstmt.setString(3, lastName);
                    pstmt.setString(4, midName);
                    pstmt.executeUpdate();
                }

                // Fetching data to display
                st = con.createStatement();
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
    </div>
</body>
</html>
