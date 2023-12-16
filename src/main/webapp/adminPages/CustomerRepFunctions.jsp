<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>ADMIN - Manage Customer Service Representatives</title>
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
                <h1><span class="highlight">ADMIN</span> CSR Management</h1>
            </div>
            <nav>
                <ul>
                    <li class="current"><a href="adminLandingPage">Admin home page</a></li>
                    <!-- Add other navigation items here if needed -->
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <!-- Form for Adding a CSR -->
        <div class="form-section">
            <h2>Add Customer Service Representative</h2>
            <form action="" method="post">
                <input type="text" name="new_username" placeholder="Username" required>
                <input type="text" name="new_password" placeholder="Password" required>
                <input type="text" name="new_first_name" placeholder="First Name" required>
                <input type="text" name="new_mid_init" placeholder="Middle Name">
                <input type="text" name="new_last_name" placeholder="Last Name" required>
                <input type="submit" value="Add CSR">
            </form>
        </div>

        <!-- Form for Editing a CSR -->
        <div class="form-section">
            <h2>Edit Customer Service Representative</h2>
            <form action="" method="post">
                <input type="text" name="usernameToEdit" placeholder="Current Username" required>
                <input type="text" name="edit_new_username" placeholder="New Username">
                <input type="text" name="edit_new_password" placeholder="New Password">
                <input type="text" name="edit_new_first_name" placeholder="New First Name">
                <input type="text" name="edit_new_mid_init" placeholder="New Middle Name">
                <input type="text" name="edit_new_last_name" placeholder="New Last Name">
                <input type="submit" value="Edit CSR">
            </form>
        </div>

        <!-- Form for Deleting a CSR -->
        <div class="form-section">
            <h2>Delete Customer Service Representative</h2>
            <form action="" method="post">
                <input type="text" name="usernameToDelete" placeholder="Username" required>
                <input type="submit" value="Delete CSR">
            </form>
        </div>
		<%  
        boolean userExists = false;
    	String newUsername = request.getParameter("new_username");
   	 String newPassword = request.getParameter("new_password");
    String newFirstName = request.getParameter("new_first_name");
    String newMidInit = request.getParameter("new_mid_init");
    String newLastName = request.getParameter("new_last_name");

    String usernameToEdit = request.getParameter("usernameToEdit");
    String editNewUsername = request.getParameter("edit_new_username");
    String editNewPassword = request.getParameter("edit_new_password");
    String editNewFirstName = request.getParameter("edit_new_first_name");
    String editNewMidInit = request.getParameter("edit_new_mid_init");
    String editNewLastName = request.getParameter("edit_new_last_name");

    String usernameToDelete = request.getParameter("usernameToDelete");

    Connection con = null;
    PreparedStatement pstmt = null;
    Statement st = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        ApplicationDB db = new ApplicationDB();
        con = db.getConnection();

        // Check if the user is trying to edit a CSR
        if (usernameToEdit != null && !usernameToEdit.isEmpty()) {
            // Fetch current details of the CSR
            String fetchCurrentDetailsSQL = "SELECT username, password, fName, mName, lName FROM users WHERE username = ?";
            pstmt = con.prepareStatement(fetchCurrentDetailsSQL);
            pstmt.setString(1, usernameToEdit);
            rs = pstmt.executeQuery();

            String currentUsername = "";
            String currentPassword = "";
            String currentFirstName = "";
            String currentMidInit = "";
            String currentLastName = "";

            if (rs.next()) {
                currentUsername = rs.getString("username");
                currentPassword = rs.getString("password");
                currentFirstName = rs.getString("fName");
                currentMidInit = rs.getString("mName");
                currentLastName = rs.getString("lName");
            }

            // Use existing details if new ones are not provided

            // Update the CSR with new details
            String updateSQL = "UPDATE users SET username = ?, password = ?, fName = ?, mName = ?, lName = ? WHERE username = ?";
            pstmt = con.prepareStatement(updateSQL);
            pstmt.setString(1, editNewUsername.isEmpty() ? currentUsername : editNewUsername);
            pstmt.setString(2, editNewPassword.isEmpty() ? currentPassword : editNewPassword);
            pstmt.setString(3, editNewFirstName.isEmpty() ? currentFirstName : editNewFirstName);
            pstmt.setString(4, editNewMidInit.isEmpty() ? currentMidInit : editNewMidInit);
            pstmt.setString(5, editNewLastName.isEmpty() ? currentLastName : editNewLastName);
            pstmt.setString(6, usernameToEdit);
            pstmt.executeUpdate();
        }

        // Perform delete if usernameToDelete is provided
        if (usernameToDelete != null && !usernameToDelete.isEmpty()) {
            String deleteSQL = "DELETE FROM users WHERE username = ?";
            pstmt = con.prepareStatement(deleteSQL);
            pstmt.setString(1, usernameToDelete);
            pstmt.executeUpdate();
        }
        
        // Check if the username for new CSR already exists
        if (newUsername != null && !newUsername.isEmpty()) {
            pstmt = con.prepareStatement("SELECT username FROM users WHERE username = ?");
            pstmt.setString(1, newUsername);
            rs = pstmt.executeQuery();
            userExists = rs.next();
        }

        // Insert a new CSR only if username does not exist
        if (!userExists && newUsername != null && !newUsername.isEmpty()) {
            String insertSQL = "INSERT INTO users(username, password, fName, mName, lName, access) VALUES (?, ?, ?, ?, ?, 'rep');";
            pstmt = con.prepareStatement(insertSQL);
            pstmt.setString(1, newUsername);
            pstmt.setString(2, newPassword);
            pstmt.setString(3, newFirstName);
            pstmt.setString(4, newMidInit);
            pstmt.setString(5, newLastName);
            pstmt.executeUpdate();
        } else if (userExists) {
            out.println("<p>Username unavailable</p>");
        }

        // Fetching data to display
        st = con.createStatement();
        rs = st.executeQuery("SELECT * FROM users;");
        out.println("<table>");
        out.println("<tr><th>Username</th><th>First Name</th><th>Middle Name</th><th>Last Name</th>");
/* 
        while (rs.next()) {
            String username = rs.getString("username");
            String fName = rs.getString("fName");
            String mInit = rs.getString("mName");
            String lName = rs.getString("lName");

            out.println("<tr>");
            out.println("<td>" + username + "</td>");
            out.println("<td>" + fName + "</td>");
            out.println("<td>" + mInit + "</td>");
            out.println("<td>" + lName + "</td>");
            out.println("</tr>");
        }
        out.println("</table>"); */
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
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
