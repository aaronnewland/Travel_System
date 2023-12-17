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
                        <input type="radio" id="economy" name="seatType" value="economy">
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
                <input type="date" id="flightDate" name="flightDate" min="<%= LocalDate.now().toString() %>" value="<%= LocalDate.now().toString() %>"/>
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
        <div class="center">
        <h3><a href="waitList.jsp">Generate Wait List Page</a> </h3>
    </div>
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
