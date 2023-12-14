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
    <title>Admin Page</title>
</head>
<body>
  <div class="center header">
    <h2>
      Welcome Admin <%=session.getAttribute("user")%>!
    </h2>
  </div>
  <div class="center">
    <h2>
      <a href="adminCustomerFunctions.jsp">Customer Functions</a>
    </h2>
  </div>
  <div class="center">
    <form action="salesReport.jsp" method="POST">
      <label for="monthYearSelected">Get sales for month/year selected.</label>
      <input type="month" id="monthYearSelected" name="monthYearSelected" value="<%= LocalDate.now().toString() %>"/>
      <input type="submit" id="searchSalesMonth" value="Generate"/>
    </form>
  </div>
  <div class="center padTop">
    <h3>Produce reservation list for flight number or customer name</h3>
  </div>
  <div class="center">
    <div class="center">
      <form action="reservationList.jsp" method="POST">
        <input type="radio" id="flightNumReservation" name="reservationListType" value="flightNumReservation"/>
        <label for="flightNumReservation">Flight Number</label>
        <input type="radio" id="customerNameReservation" name="reservationListType" value="customerNameReservation"/>
        <label for="customerNameReservation">Customer Name</label>
        <div>
          <label for="reservationID">Search by: </label>
          <input type="text" id="reservationID" name="reservationID"/>
          <input type="submit" id="generateReservationList" value="Submit"/>
        </div>
      </form>
    </div>
  </div>
  <div class="center padTop">
    <h3>Produce summery of revenue for particular flight number, airline ID, or customer name</h3>
  </div>
  <div class="center">
    <div class="center">
      <form action="revenueGenerated.jsp" method="POST">
        <input type="radio" id="flightNumRevenue" name="revenueListType" value="flightNumRevenue"/>
        <label for="flightNumRevenue">Flight Number</label>
        <input type="radio" id="airlineID" name="revenueListType" value="airlineID"/>
        <label for="airlineID">Airline ID</label>
        <input type="radio" id="customerNameRevenue" name="revenueListType" value="customerNameRevenue"/>
        <label for="customerNameRevenue">Customer Name</label>
        <div>
          <label for="revenueID">Search by: </label>
          <input type="text" id="revenueID" name="revenueID"/>
          <input type="submit" id="generateRevenueList" value="Submit"/>
        </div>
      </form>
    </div>
  </div>
  <div class="center padTop">
    STUB FOR CUSTOMER GENERATING MOST TOTAL REVENUE
  </div>
  <div class="center padTop">
    <h2>
      <a href="mostActiveFlightList.jsp">List of most active flights.</a>
    </h2>
  </div>
</body>
</html>
