 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="com.example.travel_system.*"%>
<%@ page import="java.sql.*"%>

 <!DOCTYPE html>
<html>
<head>
    <title>Flight Path Results</title>
    <style>
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            padding: 5px;
            text-align: left;
        }
        .center {
            display: flex;
            justify-content: center;
            /*align-items: center;*/
        }
        .padLeft {
            margin-left: 12px;
        }
    </style>
</head>
<body>
<%

    String departure = request.getParameter("departure");
    String arrival = request.getParameter("destination");
	int numconnect = 4;
    String departure_date = request.getParameter("flightDate");
    String flexOption = request.getParameter("tripType");
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
        Statement st = con.createStatement();
        String orderBy = request.getParameter("criteria");
        String ascdesc = request.getParameter("howSort");

        if (orderBy == null || orderBy.isEmpty()) { orderBy = "depart_time"; }
        if (ascdesc == null || ascdesc.isEmpty()) { ascdesc = "ASC"; }

        String query = "Call getflightpathorderbytest('" + departure + "','" + arrival + "'," + numconnect + ",'" + departure_date + "','" + orderBy + "','" + ascdesc + "');";
        if (flexOption.equals("oneWayFlex") || flexOption.equals("roundTripFlex")) {
            query = "Call getflightpathsflexorderbytest('" + departure + "','" + arrival + "'," + numconnect + ",'" + departure_date + "','" + orderBy + "','" + ascdesc + "');";
        }


        ResultSet rs = st.executeQuery(query);

        out.println("<table>");
        out.println("<tr><th>Arrival City</th><th>Booking Fees</th><th>Sum of Fares</th><th>Flight IDs</th><th>Total Cost</th><th>Airline IDs</th><th>Aircraft IDs</th><th>Duration in min</th><th>departure time</th><th>Arrival time</th></tr>");

        // Process the ResultSet and add rows to the table
        while (rs.next()) {
            String arrival_city = rs.getString("arrival");
            Double booking_fees = rs.getDouble("sum_of_booking_fees");
            Double sum_fares = rs.getDouble("sum_of_fares");
            String flight_ids = rs.getString("flight_ids");
            Double total_cost = rs.getDouble("total_cost");
            String airline_ids = rs.getString("airline_ids");
            String aircraft_ids = rs.getString("aircraft_ids");
            Integer total_duration = rs.getInt("total_duration");
            String depart_time = rs.getString("depart_time");
            String arrival_time = rs.getString("arrival_time");

            out.println("<tr>");
            out.println("<td>" + arrival_city + "</td>");
            out.println("<td>" + booking_fees + "</td>");
            out.println("<td>" + sum_fares + "</td>");
            out.println("<td>" + flight_ids + "</td>");
            out.println("<td>" + total_cost + "</td>");
            out.println("<td>" + airline_ids + "</td>");
            out.println("<td>" + aircraft_ids + "</td>");
            out.println("<td>" + total_duration + "</td>");
            out.println("<td>" + depart_time + "</td>");
            out.println("<td>" + arrival_time + "</td>");
            out.println("<td>");
            out.println("<form action='purchaseTicket.jsp' method='POST'>");
            out.println("<input type='hidden' name='flightId' value='" + flight_ids + "'>");
            out.println("<input type='submit' value='Purchase'>");
            out.println("</form>");
            out.println("</td>");
            out.println("</tr>");

        }

        out.println("</table>");

        rs.close();
        st.close();
        con.close();
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
%>
</body>
</html>
