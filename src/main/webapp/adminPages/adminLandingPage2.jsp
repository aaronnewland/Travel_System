<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Page</title>
    <style>
        /* Existing styles */
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
        .tab {
            overflow: hidden;
            border: 1px solid #cccccc;
            background-color: #f2f2f2;
        }

        .tab a {
            padding: 14px 16px;
            margin-right: 5px;
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            text-decoration: none;
            transition: 0.3s;
            font-size: 17px;
            color: #333;
            border-radius: 4px;
        }

        .tab a:hover {
            background-color: #ddd;
        }

        .tab a.active {
            background-color: #50b3a2;
            color: white;
        }

    </style>
</head>
<body>
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">ADMIN</span> Dashboard</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="adminLandingPage">Home</a></li>
                    <!-- Other navigation items if needed -->
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="tab">
            <a href="adminCustomerFunctions.jsp" class="tablinks">Customer Functions</a>
            <a href="salesReport.jsp" class="tablinks">Sales Report</a>
            <a href="reservationList.jsp" class="tablinks">Reservations</a>
            <a href="revenueGenerated.jsp" class="tablinks active">Revenue</a>
            <a href="mostActiveFlightList.jsp" class="tablinks">Active Flights</a>
        </div>

    </div>
</body>
</html>
