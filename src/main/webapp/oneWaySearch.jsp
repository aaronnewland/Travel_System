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

    String return_date = request.getParameter("flightReturnDate");

    String flexOption = request.getParameter("tripType");

    String customerID = (String) session.getAttribute("customerIDGlobal");
    if (customerID.equals("0")) {
        customerID = request.getParameter("customerIDReservation");
    }

    String roundTripFlightID = request.getParameter("flightId");
    String roundTripAirlineID = request.getParameter("airlineIds");
    String roundTripAircraftID = request.getParameter("aircraftIds");
    String roundTripCustomerID = request.getParameter("customerID");
    boolean terminate = false;
    String roundTripTerminate = request.getParameter("roundTripTerminate");
    if (!(roundTripTerminate == null || roundTripTerminate.isEmpty())) {
        if (roundTripTerminate.equalsIgnoreCase("true")) {
            terminate = true;
        }
    }

    String seatType = request.getParameter("seatType");

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
        </div>
    </div>
    <div class="center">
        <label for="filterType"> Filter By </label>
        <select id="filterType" name="filterType">
            <option value="greaterPrice">> Price</option>
            <option value="lessPrice">< Price</option>
            <option value="greaterNumStops">> Number of Stops</option>
            <option value="lessNumStops">< Number of Stops</option>
            <option value="airline">Airline (e.g. AA, UA)</option>
            <option value="greaterTakeOffTime">> Take-Off-Time (HH:MM)</option>
            <option value="lessTakeOffTime">< Take-Off-Time (HH:MM)</option>
            <option value="greaterArrivalTime">> Arrival Time (HH:MM)</option>
            <option value="lessArrivalTime">< Arrival Time (HH:MM)</option>
        </select>
        <label for="filterBy">Enter Value</label>
        <input type="text" id="filterBy" name="filterBy"/>
    </div>
    <div class="center">
        <input type="submit" value="Update"/>
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

            boolean flex = false;
            if (flexOption.equalsIgnoreCase("oneWayFlex") || flexOption.equalsIgnoreCase("roundTripFlex")) flex = true;

            List<FlightPath> paths = flightPaths.findFlightPaths(departure, arrival, numConnect, flex, departureDate, con);

            String filter = request.getParameter("filterType");
            String filterVal = request.getParameter("filterBy");



            String orderBy = request.getParameter("criteria");
            String ascdesc = request.getParameter("howSort");

            if (orderBy == null || orderBy.isEmpty()) { orderBy = "depart_time"; }
            if (ascdesc == null || ascdesc.isEmpty()) { ascdesc = "ASC"; }


            String finalOrderBy = orderBy;
            String finalAscdesc = ascdesc;
            Collections.sort(paths, (o1, o2) -> {
                switch (finalOrderBy) {
                    case "total_cost":
                        return finalAscdesc.equalsIgnoreCase("ASC") ? Double.compare(o1.getFare(), o2.getFare())
                                : Double.compare(o2.getFare(), o1.getFare());
                    case "depart_time":
                        return finalAscdesc.equalsIgnoreCase("ASC") ? o1.getDepartureTimes().get(0).compareTo(o2.getDepartureTimes().get(0))
                                : o2.getDepartureTimes().get(0).compareTo(o1.getDepartureTimes().get(0));
                    case "arrival_time":
                        return finalAscdesc.equalsIgnoreCase("ASC") ? o1.getArrivalTimes().get(o1.getArrivalTimes().size() - 1).compareTo(o2.getArrivalTimes().get(o2.getArrivalTimes().size() - 1))
                                : o2.getArrivalTimes().get(o2.getArrivalTimes().size() - 1).compareTo(o1.getArrivalTimes().get(o1.getArrivalTimes().size() - 1));
                    case "total_duration":
                        return finalAscdesc.equalsIgnoreCase("ASC") ? Integer.compare(o1.getDuration(), o2.getDuration())
                                : Integer.compare(o2.getDuration(), o1.getDuration());
                }
                return 0;
            });

            if (!(filterVal == null || filterVal.isEmpty()) && !(filter == null || filter.isEmpty())) {
                Iterator<FlightPath> iterator = paths.iterator();
                DateTimeFormatter hourMinuteFormatter = DateTimeFormatter.ofPattern("HH:mm");
                while (iterator.hasNext()) {
                    FlightPath path = iterator.next();
                    boolean remove = false;

                        switch (filter) {
                            case "greaterPrice":
                                double price = Double.parseDouble(filterVal);
                                if (path.getFare() < price) remove = true;
                                break;
                            case "lessPrice":
                                price = Double.parseDouble(filterVal);
                                if (path.getFare() > price) remove = true;
                                break;
                            case "greaterNumStops":
                                int numberStops = path.getArrivalAirports().size();
                                int desiredStops = Integer.parseInt(filterVal);
                                if (desiredStops > numberStops) remove = true;
                                break;
                            case "lessNumStops":
                                numberStops = path.getArrivalAirports().size();
                                desiredStops = Integer.parseInt(filterVal);
                                if (desiredStops < numberStops) remove = true;
                                break;
                            case "airline":
                                for (Flight flight : path.getFlightList()) {
                                    if (!filterVal.equalsIgnoreCase(flight.getAirlineID())) {
                                        remove = true;
                                        break;
                                    }
                                }
                                break;
                            case "greaterTakeOffTime":
                                LocalTime time = LocalTime.parse(filterVal, hourMinuteFormatter);
                                // get take off time of first flight to compare
                                LocalTime takeOffTime = path.getDepartureTimes().get(0).toLocalDateTime().toLocalTime();
                                String tempTime = takeOffTime.format(hourMinuteFormatter);
                                takeOffTime = LocalTime.parse(tempTime, hourMinuteFormatter);
                                if (!takeOffTime.isAfter(time)) remove = true;
                                break;
                            case "lessTakeOffTime":
                                time = LocalTime.parse(filterVal, hourMinuteFormatter);
                                // get take off time of first flight to compare
                                takeOffTime = path.getDepartureTimes().get(0).toLocalDateTime().toLocalTime();
                                tempTime = takeOffTime.format(hourMinuteFormatter);
                                takeOffTime = LocalTime.parse(tempTime, hourMinuteFormatter);
                                out.println(takeOffTime);
                                if (!takeOffTime.isBefore(time)) remove = true;
                                break;
                            case "greaterArrivalTime":
                                time = LocalTime.parse(filterVal, hourMinuteFormatter);
                                // get arrival time of last flight to compare
                                LocalTime arrivalTime = path.getArrivalTimes().get(path.getFlightList().size() - 1).toLocalDateTime().toLocalTime();
                                tempTime = arrivalTime.format(hourMinuteFormatter);
                                arrivalTime = LocalTime.parse(tempTime, hourMinuteFormatter);
                                if (!arrivalTime.isAfter(time)) remove = true;
                                break;
                            case "lessArrivalTime":
                                time = LocalTime.parse(filterVal, hourMinuteFormatter);
                                // get arrival time of last flight to compare
                                arrivalTime = path.getArrivalTimes().get(path.getFlightList().size() - 1).toLocalDateTime().toLocalTime();
                                tempTime = arrivalTime.format(hourMinuteFormatter);
                                arrivalTime = LocalTime.parse(tempTime, hourMinuteFormatter);
                                if (!arrivalTime.isBefore(time)) remove = true;
                                break;
                            default:
                                break;
                        }

                    if (remove) iterator.remove();
                }
            }

            for (FlightPath path : paths) {
                LocalDate timestampDate = path.getDepartureTimes().get(0).toLocalDateTime().toLocalDate();
                if (((flexOption.equalsIgnoreCase("oneWaySpecific") && timestampDate.isEqual(departureDate)) || flexOption.equalsIgnoreCase("oneWayFlex")) ||
                    ((flexOption.equalsIgnoreCase("roundTripSpecific") && timestampDate.isEqual(departureDate)) || flexOption.equalsIgnoreCase("roundTripFlex"))) {
                    out.println("<tr>");
                    out.println("<td>" + joinList(path.getAirlineIds()) + "</td>");
                    out.println("<td>" + joinList(path.getAircraftIds()) + "</td>");
                    out.println("<td>" + joinList(path.getFlightIds()) + "</td>");
                    out.println("<td>" + joinList(path.getDepartureTimes()) + "</td>");
                    out.println("<td>" + joinList(path.getArrivalTimes()) + "</td>");
                    out.println("<td>" + joinList(path.getDepartureAirports()) + "</td>");
                    out.println("<td>" + joinList(path.getArrivalAirports()) + "</td>");
                    out.println("<td>" + joinList(path.getDaysOfWeek()) + "</td>");
                    out.println("<td>" + joinList(path.getAreInternational()) + "</td>");
                    out.println("<td>" + path.getFare() + "</td>");
                    out.println("<td>" + path.getBookingFee() + "</td>");
                    out.println("<td>" + path.getDuration() + "</td>");
                    out.println("<td>");
                    if (flexOption.equalsIgnoreCase("oneWaySpecific") || flexOption.equalsIgnoreCase("oneWayFlex")) {
                        out.println("<form action='purchaseTicket.jsp' method='POST'>");
                        out.println("<input type='hidden' name='flightId' value='" + joinList(path.getFlightIds()) + "'>");
                        out.println("<input type='hidden' name='airlineIds' value='" + joinList(path.getAirlineIds()) + "'>");
                        out.println("<input type='hidden' name='aircraftIds' value='" + joinList(path.getAircraftIds()) + "'>");
                        out.println("<input type='hidden' name='customerID' value='" + customerID + "'>");
                        out.println("<input type='hidden' name='seatType' value='" + seatType + "'>");
                        out.println("<input type='submit' value='Purchase'>");
                        out.println("</form>");
                    } else if (!terminate){
                        out.println("<form action='oneWaySearch.jsp' method='POST'>");
                        out.println("<input type='hidden' name='flightId' value='" + joinList(path.getFlightIds()) + "'>");
                        out.println("<input type='hidden' name='airlineIds' value='" + joinList(path.getAirlineIds()) + "'>");
                        out.println("<input type='hidden' name='aircraftIds' value='" + joinList(path.getAircraftIds()) + "'>");
                        out.println("<input type='hidden' name='customerID' value='" + customerID + "'>");
                        out.println("<input type='hidden' name='flightDate' value='" + return_date + "'>");
                        out.println("<input type='hidden' name='tripType' value='" + flexOption + "' >");
                        out.println("<input type='hidden' name='departure' value='" + arrival + "' >");
                        out.println("<input type='hidden' name='destination' value='" + departure + "' >");
                        out.println("<input type='hidden' name='roundTripTerminate' value='" + "true" + "' >");
                        out.println("<input type='hidden' name='seatType' value='" + seatType + "'>");
                        out.println("<input type='submit' value='Purchase'>");
                        out.println("</form>");
                    } else {
                        out.println("<form action='purchaseTicket.jsp' method='POST'>");
                        out.println("<input type='hidden' name='flightId' value='" + roundTripFlightID.concat(",").concat(joinList(path.getFlightIds())) + "'>");
                        out.println("<input type='hidden' name='airlineIds' value='" + roundTripAirlineID.concat(",").concat(joinList(path.getAirlineIds())) + "'>");
                        out.println("<input type='hidden' name='aircraftIds' value='" + roundTripAircraftID.concat(",").concat(joinList(path.getAircraftIds())) + "'>");
                        out.println("<input type='hidden' name='customerID' value='" + customerID + "'>");
                        out.println("<input type='hidden' name='seatType' value='" + seatType + "'>");
                        out.println("<input type='submit' value='Purchase'>");
                        out.println("</form>");
                    }
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
