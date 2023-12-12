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
    <title>Welcome</title>
  </head>
  <body>
    <div class="center">
      <%
        if ((session.getAttribute("user") == null)) {
      %>
      You are not logged in<br/>
      <a href="login.jsp">Please Login</a>
      <%} else {
      %>
    </div>
    <div class="center header">
      <h2>
      Welcome <%=session.getAttribute("user")%>!
      </h2>
    </div>

    <div class="center">
      <h3>
        Search For Flights
      </h3>
    </div>
    <div class="center">
      <form action="oneWaySearch.jsp" method="POST">
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
    <div class="center2">
      <div>
        <h3>
          Customer Info Center
        </h3>
      </div>
      <div>
        Upcoming Flight Table
      </div>
      <div>
        Past Flight Table
      </div>
      <div>
        Cancel a flight? (Business/First Class only)
        <form>
          <label for="fCode">Flight Code: </label>
          <input type="text" id="fCode" name="F_CODE"/> <br/>
          <div class="center">
            <input type="submit" value="Submit"/>
          </div>
        </form>
      </div>
    </div>
    <div class="center2">
      <h3>
        FAQ
      </h3>
      <div>
        <form action="searchFAQ.jsp" method="POST">
          <label for="searchQ">Search Questions: </label>
          <input type="search" id="searchQ" name="SEARCH_Q"/> <br/>
          <div class="center">
            <input type="submit" value="Search"/>
          </div>
        </form>
      </div>
      <div>
        FAQ Table
      </div>
      <div class="center">
        <form action="postFAQ.jsp" method="POST">
          <div class="center">
            <label for="question_to_post">Post a question: </label>
          </div>
          <textarea id="question_to_post" name="QUESTION" rows="4" cols="50"></textarea>
          <div class="center">
            <input type="submit" value="Post"/>
          </div>
        </form>
      </div>
    </div>

    <%-- displays username in the session --%>
    <div class="center">
      <a href='logout.jsp'>Log out</a>
    </div>
    <%
      }
    %>
  </body>
</html>