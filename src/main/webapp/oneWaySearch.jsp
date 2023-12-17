 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.sql.*"%>
 <%@ page import="java.util.*" %>
 <%@ page import="java.time.*" %>
 <%@ page import="java.time.format.DateTimeFormatter" %>
 <%@ page import="java.text.SimpleDateFormat" %>
 <%@ page import="java.util.Date" %>

 <%!
     public static <T> String joinList(List<T> list) {
         if (list == null || list.isEmpty()) {
            return ""; // Return an empty string for null or empty lists
         }

         StringBuilder sb = new StringBuilder();
         for (T element : list) {
             if (sb.length() > 0) {
                sb.append(",");
             }
            sb.append(element.toString());
         }
         return sb.toString();
     }
 %>

 <!DOCTYPE html>
<html>
<head>
    <title>Flight Path Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
        }
        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 5px 8px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>

<%
    String departure = request.getParameter("departure");
    String arrival = request.getParameter("destination");
	int numConnect = 4;

    String departure_date = request.getParameter("flightDate");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate departureDate = LocalDate.parse(departure_date, formatter);
    String flexOption = request.getParameter("tripType");

    String customerID = (String) session.getAttribute("customerIDGlobal");
    if (customerID.equals("0")) {
        customerID = request.getParameter("customerIDReservation");
    }
%>

<form action="oneWaySearch.jsp" method="POST">
    <div class="center">
        <label for="searchDropdown">Sort by flight criteria:</label>
        <select id="searchDropdown" name="criteria">
            <option value="total_cost">Price</option>
            <option value="depart_time">Departure Time</option>
            <option value="arrival_time">Arrival Time</option>
            <option value="total_duration">Flight Duration</option>
        </select>
        <div class="padLeft">
            <label for="ascordesc">Ascending or Descending:</label>
            <select id="ascordesc" name="howSort">
                <option value="ASC">Ascending</option>
                <option value="DESC">Descending</option>
            </select>
            <input type="submit" value="Filter">
        </div>
    </div>
    <input type="hidden" name="departure" value="<%= departure %>" />
    <input type="hidden" name="destination" value="<%= arrival %>" />
    <input type="hidden" name="flightDate" value="<%= departure_date %>" />
    <input type="hidden" name="tripType" value="<%= flexOption %>" />
</form>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();

            out.println("<table border='1'><tr><th>Airline ID</th><th>Aircraft ID</th><th>Flight ID</th><th>Departure Time</th><th>Arrival Time</th><th>Departure Airport</th><th>Arrival Airport</th><th>Day of Week</th><th>Is International</th><th>Fare</th><th>Booking Fee</th><th>Duration</th><th>Purchase Ticket</th></tr>");

            FlightPath flightPaths = new FlightPath();
            List<FlightPath> paths = flightPaths.findFlightPaths(departure, arrival, numConnect, con);
            for (FlightPath path : paths) {
                List<String> airlineIds = new ArrayList<>();
                List<Integer> aircraftIds = new ArrayList<>();
                List<Integer> flightIds = new ArrayList<>();
                List<Timestamp> departureTimes = new ArrayList<>();
                List<Timestamp> arrivalTimes = new ArrayList<>();
                List<String> departureAirports = new ArrayList<>();
                List<String> arrivalAirports = new ArrayList<>();
                List<String> daysOfWeek = new ArrayList<>();
                List<Boolean> areInternational = new ArrayList<>();
                double fare = 0;
                double bookingFee = 0;
                int duration = 0;

                boolean inDateRange = false;
                for (Flight flight : path.getFlightList()) {
                    LocalDate timestampDate = flight.getDepartureTime().toLocalDateTime().toLocalDate();
                    if (timestampDate.isEqual(departureDate)) {
                        inDateRange = true;
                        airlineIds.add(flight.getAirlineID());
                        aircraftIds.add(flight.getAircraftID());
                        flightIds.add(flight.getFlightID());
                        departureTimes.add(flight.getDepartureTime());
                        arrivalTimes.add(flight.getArrivalTime());
                        departureAirports.add(flight.getDepartureAirport());
                        arrivalAirports.add(flight.getArrivalAirport());
                        daysOfWeek.add(flight.getDayOfWeek());
                        areInternational.add(flight.isInternational());
                        fare += flight.getFare();
                        bookingFee += flight.getBookingFee();
                        duration += flight.getDuration();
                    }

                }

                if (inDateRange) {
                    out.println("<tr>");
                    out.println("<td>" + joinList(airlineIds) + "</td>");
                    out.println("<td>" + joinList(aircraftIds) + "</td>");
                    out.println("<td>" + joinList(flightIds) + "</td>");
                    out.println("<td>" + joinList(departureTimes) + "</td>");
                    out.println("<td>" + joinList(arrivalTimes) + "</td>");
                    out.println("<td>" + joinList(departureAirports) + "</td>");
                    out.println("<td>" + joinList(arrivalAirports) + "</td>");
                    out.println("<td>" + joinList(daysOfWeek) + "</td>");
                    out.println("<td>" + joinList(areInternational) + "</td>");
                    out.println("<td>" + fare + "</td>");
                    out.println("<td>" + bookingFee + "</td>");
                    out.println("<td>" + duration + "</td>");
                    out.println("<td>");
                    out.println("<form action='purchaseTicket.jsp' method='POST'>");
                    out.println("<input type='hidden' name='flightId' value='" + joinList(flightIds) + "'>");
                    out.println("<input type='hidden' name='airlineIds' value='" + joinList(airlineIds) + "'>");
                    out.println("<input type='hidden' name='aircraftIds' value='" + joinList(aircraftIds) + "'>");
                    out.println("<input type='hidden' name='customerID' value='" + customerID + "'>");
                    out.println("<input type='submit' value='Purchase'>");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }

            out.println("</table>");
            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    %>
</body>
</html>
