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
      <form action="customerFlightSearch.jsp" method="POST">
        <div class="center">
          Search a flight (specific date):
          <div class="center">
            <input type="radio" id="one_way_specific" name="trip_type_specific" value="ONE_WAY_SPECIFIC">
            <label for="one_way_specific">One Way</label>
            <input type="radio" id="round_trip_specific" name="trip_type_specific" value="ROUND_TRIP_SPECIFIC">
            <label for="round_trip_specific">Round Trip</label>
          </div>
        </div>
        <div class="center padTop">
          Departure Airport: <input type="text" name="departure"/>
          <div class="padLeft">
            Destination Airport: <input type="text" name="destination"/>
          </div>
        </div>
        <div class="center padTop header">
          <input type="submit" value="Search Flights"/>
        </div>
        <div class="center">
          Search a flight (flexible dates within 3 days):
          <div class="center">
            <input type="radio" id="one_way_flex" name="trip_type_flex" value="ONE_WAY_FLEX">
            <label for="one_way_flex">One Way</label>
            <input type="radio" id="round_trip_flex" name="trip_type_flex" value="ROUND_TRIP_FLEX">
            <label for="round_trip_flex">Round Trip</label>
          </div>
        </div>
        <div class="center padTop">
          Departure Airport: <input type="text" name="departure"/>
          <div class="padLeft">
            Destination Airport: <input type="text" name="destination"/>
          </div>
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
          Flight Code: <input type="text" name="code"/> <br/>
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
          Search Questions: <input type="search" name="search_q"/> <br/>
          <div class="center">
            <input type="submit" value="Search"/>
          </div>
        </form>
      </div>
      <div>
        FAQ Table
      </div>
      <div class="center">
        <form>
          <div class="center">
            Post a question.
          </div>
          <textarea id="question_to_post" name="question" rows="4" cols="50"></textarea>
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