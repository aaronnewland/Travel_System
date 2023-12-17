<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*"%>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Page</title>
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

        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        th, td {
            padding: 5px;
            text-align: left;
        }

        table tr:nth-child(even) {
            background: #f2f2f2;
        }

        .center {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div id="branding">
                <h1><span class="highlight">Customer</span> Dashboard</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="customerLandingPage2.jsp">Customer Home</a></li>
           
                </ul>
            </nav>
        </div>
    </header>

<div class="container">
        <div class="tab">
          <!--  <a href="editCustomerReservations1.jsp" class="tablinks">Customer Functions</a>
            <a href="airportFlightList.jsp" class="tablinks">Airport Flight List</a> -->
            <a href="customerLandingPage2.jsp" class="tablinks">Home</a>
             <a href="customerFlightSearch.jsp" class="tablinks active">Flight Search</a>
            <a href="cancelFlight.jsp" class="tablinks">Cancel a flight</a>
            <a href="postFAQ.jsp" class="tablinks">Ask a Question</a>
            <a href="searchFAQ.jsp" class="tablinks">Search FAQ</a>
            <a href="upcomingAndPastFlights.jsp" class="tablinks">Past and Upcoming Itinerary</a>
        </div>
    </div>

<body>
     <h3>
        <center>Search For Flights</center>
      </h3>
    <div class="center">
      <form action="../oneWaySearch.jsp" method="POST">
        <div class="center">
          Search a flight (specific date):
          <div class="center">
            <input type="radio" id="oneWaySpecific" name="tripType" value="oneWaySpecific" checked>
            <label for="oneWaySpecific">One Way</label>
            <input type="radio" id="roundTripSpecific" name="tripType" value="roundTripSpecific">
            <label for="roundTripSpecific">Round Trip</label>
          </div>
        </div>
        <div class="center">
          <div class="center">
            Search a flight (flexible dates within 3 days):
            <div class="center">
              <input type="radio" id="oneWayFlex" name="tripType" value="oneWayFlex">
              <label for="oneWayFlex">One Way</label>
              <input type="radio" id="roundTripFlex" name="tripType" value="roundTripFlex">
              <label for="roundTripFlex">Round Trip</label>
            </div>
          </div>
        </div>
        <div class="center">
          <div class="center">
            Seat Type:
            <div class="center">
              <input type="radio" id="economy" name="seatType" value="economy" checked>
              <label for="economy">Economy</label>
              <input type="radio" id="business" name="seatType" value="business">
              <label for="business">Business</label>
              <input type="radio" id="first" name="seatType" value="first">
              <label for="first">First Class</label>
            </div>
          </div>
        </div>
        <div class="center padTop">
          <label for="departure">Departure Airport: </label>
          <input type="text" id="departure" name="departure"/>
          <div class="padLeft">
            <label for="destination">Destination Airport: </label>
            <input type="text" id="destination" name="destination"/>
          </div>
        </div>
        <div class="center">
          <label for="flightDate">Desired date: </label>
          <input type="date" id="flightDate" name="flightDate" min="<%= LocalDate.now().toString() %>" value="<%= LocalDate.now() %>"/>
          <label for="flightReturnDate">Desired Return date: </label>
          <input type="date" id="flightReturnDate" name="flightReturnDate" min="<%= LocalDate.now().toString() %>" value="<%= LocalDate.now() %>"/>
        </div>
        <div class="center padTop header">
          <input type="submit" value="Search Flights"/>
        </div>
      </form>
    </div>
</body>
</html>
