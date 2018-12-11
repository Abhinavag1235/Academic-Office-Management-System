<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html>
<html>

<head>
    <title>Course Registration</title>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="res/css/style.css">
</head>

<body>
    <%String rollNo = session.getAttribute("rollNo").toString(); %>
    <% String nam=(String)session.getAttribute("name"); %>
    <%String branch = session.getAttribute("branch").toString(); %>
    <%int cursem = Integer.parseInt(session.getAttribute("cursem").toString()); %>
    
    
    <div class="container">
        <h3><b><br>Course Registration</b></h4><br>
        <div class="panel panel-default">
            <div class="panel-heading"><b>Personal Details</b></div>
            <div class="panel-body">
                <div class="row col-md-12">
                    <div class="col-md-6">
                      <p>Student Name : <%=nam%></p>
                      <p>Branch : <%=branch%></p>
                    </div>
                    <div class="col-md-6">
                      <p>Roll No : <%=rollNo%></p>
                      <p>Semester : <%=cursem + 1%></p>
                    </div>
                    
                </div>
                
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading"><b>Core Courses</b></div>
            <div class="panel-body">
                <!-- <form class="form-horizontal" action="/action_page.php">
                  <div class="form-group">
                    <label class="control-label col-sm-2" for="email">Student Name:</label>
                    <div class="col-sm-10">
                      <%=rollNo%>
                    </div>

                  </div>
                </form> -->
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading"><b>Program Elective</b></div>
            <div class="panel-body">Panel Content</div>
        </div>

        <div class="row col-md-12">
              <div class="col-md-4">
                    
              </div>
              <div class="col-md-4" align="center">
                  <button type="submit" class="btn btn-danger" style="width: 100px">Submit</button>
                  <button type="submit" class="btn btn-danger" style="width: 100px">Lock</button>
              </div>
              <div class="col-md-4">
                  
              </div>
                    
        </div>
    </div>

    <div class="container col-md-6">

      <form class="form-horizontal" action="/action_page.php">
        

        <!-- <h4 style="padding-left: 110px">Core Courses</h4>
        <div class="form-group">
          <label class="control-label col-sm-2" for="email">C1</label>
          <div class="col-sm-10">
            <input type="email" class="form-control" id="email" placeholder="C1 Name" name="email" disabled="true">
          </div>
        </div>
        

        <h4 style="padding-left: 110px">Program Electives</h4>

        <div class="form-group">
          <label class="control-label col-sm-2" for="email">PE 1</label>
          <div class="col-sm-10">
            <select name="cars">
            <option value="volvo">Rank 1</option>
            <option value="saab">Rank 2</option>
        </select>
          </div>
        </div> -->

</div>


</body>
</html>