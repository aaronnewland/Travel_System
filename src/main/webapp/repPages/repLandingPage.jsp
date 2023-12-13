<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<style>
    .header {
        margin-bottom: 50px;
    }
    .center {
        display: flex;
        justify-content: center;
        /*align-items: center;*/
    }
    .center2 {
        display: flex;
        justify-content: center;
        flex-direction: column;
        align-items: center;
    }
    .padLeft {
        margin-left: 12px;
    }
    .padTop {
        margin-top: 10px;
    }
</style>
<head>
    <title>Representative Page</title>
</head>
<body>
    <div class="center header">
        <h2>
            Welcome Customer Representative <%=session.getAttribute("user")%>!
        </h2>
    </div>
    <div class="center">
        <form action="../oneWaySearch.jsp" method="POST">
            <div class="center">
                <h3>Make flight reservation on behalf of user</h3>
            </div>
            <div class="center">
                <label for="customerIDReservation">Customer ID: </label>
                <input type="text" id="customerIDReservation" name="customerIDReservation"/>
            </div>
            <div class="center">
                Search a flight (specific date):
                <div class="center">
                    <input type="radio" id="one_way_specific" name="trip_type" value="ONE_WAY_SPECIFIC">
                    <label for="one_way_specific">One Way</label>
                    <input type="radio" id="round_trip_specific" name="trip_type" value="ROUND_TRIP_SPECIFIC">
                    <label for="round_trip_specific">Round Trip</label>
                </div>
            </div>
            <div class="center">
                <div class="center">
                    Search a flight (flexible dates within 3 days):
                    <div class="center">
                        <input type="radio" id="one_way_flex" name="trip_type" value="ONE_WAY_FLEX">
                        <label for="one_way_flex">One Way</label>
                        <input type="radio" id="round_trip_flex" name="trip_type" value="ROUND_TRIP_FLEX">
                        <label for="round_trip_flex">Round Trip</label>
                    </div>
                </div>
            </div>
            <div class="center">
                <div class="center">
                    Seat Type:
                    <div class="center">
                        <input type="radio" id="economy" name="seat_type" value="ECONOMY">
                        <label for="economy">Economy</label>
                        <input type="radio" id="business" name="seat_type" value="BUSINESS">
                        <label for="business">Business</label>
                        <input type="radio" id="first" name="seat_type" value="FIRST">
                        <label for="first">First Class</label>
                    </div>
                </div>
            </div>
            <div class="center padTop">
                <label for="departure">Departure Airport: </label>
                <input type="text" id="departure" name="DEPARTURE"/>
                <div class="padLeft">
                    <label for="destination">Destination Airport: </label>
                    <input type="text" id="destination" name="DESTINATION"/>
                </div>
            </div>
            <div class="center">
                <label for="flightDate">Desired date: </label>
                <input type="date" value="Flight Date" id="flightDate" name="FLIGHT_DATE" min="<%= LocalDate.now().toString() %>"/>
            </div>
            <div class="center padTop header">
                <input type="submit" value="Search Flights"/>
            </div>
        </form>
    </div>
    <div class="center">
        <h3>Edit Flight Reservations for User</h3>
    </div>
    <div class="center">
        <div class="center">
            <form action="editCustomerReservations.jsp" method="POST">
                <div class="center">
                    <label for="customerIDEdit">Customer ID: </label>
                    <input type="text" id="customerIDEdit" name="customerIDEdit"/>
                    <div class="padLeft">
                        <label for="flightIDEdit">Customer ID: </label>
                        <input type="text" id="flightIDEdit" name="flightIDEdit"/>
                    </div>
                </div>
                <div class="center padTop">
                    <input type="submit" value="Edit Flight"/>
                </div>
            </form>
        </div>
    </div>
    <div class="center">
        <h3><a href="repAirportFunctions.jsp">Airport, Aircraft, and Flight Functions</a> </h3>
    </div>
    <div class="center padTop">
        <h3>Retrieve waiting list for a flight</h3>
    </div>
    <div class="center">
        <form action="waitList.jsp" method="POST">
            <div>
                <label for="flightIDWait">Enter Flight ID:</label>
                <input type="text" id="flightIDWait" name="flightIDWait">
                <input type="submit" value="Generate Wait List">
            </div>
        </form>
    </div>
    <div class="center padTop">
        <h3>Lists of All Flights For Airport</h3>
    </div>
    <div class="center">
        <form action="airportFlightList.jsp" method="POST">
            <div>
                <label for="airportID">Enter Flight ID:</label>
                <input type="text" id="airportID" name="airportID">
                <input type="submit" value="Generate Flight List">
            </div>
        </form>
    </div>
    <div class="center padTop">
        <h3><a href="repFAQ.jsp">Reply to User Questions</a> </h3>
    </div>
</body>
</html>
