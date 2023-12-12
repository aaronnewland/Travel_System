<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <form action="adminCustomerFunctions.jsp" method="POST">
      <input type="submit" value="Customer Functions"/>
    </form>

  </div>
</body>
</html>
