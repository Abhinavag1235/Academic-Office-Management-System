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
    <%int cursem = Integer.parseInt(session.getAttribute("cursem").toString());
      int nextsem = cursem +1; %> 
    
    
    <div class="container">
        <h3><b><br>Course Registration Module</b></h4><br>
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
                

        <%
        Class.forName("com.mysql.jdbc.Driver"); 
        java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aoms","isd","qwerty"); 
        Statement st= con.createStatement(); 
        ResultSet rs=st.executeQuery("select * from course where branch='"+branch+"' AND ctype='co' AND sem='"+nextsem+"'"); 

        while(rs.next()){ %>

                <div class="row col-md-12">
                    <div class="col-md-6">
                      <form class="form-horizontal" action="/action_page.php">
                          <div class="form-group">
                            <div for="disabledInput" class="col-sm-2 control-label"><%=rs.getString(1)%></div>
                            <div class="col-sm-10">
                              <input class="form-control" id="disabledInput" type="text" value=<%=rs.getString(2)%> disabled>
                            </div>
                          </div>
                        </form>
                    </div>
                    <div class="col-md-6" align="center">
                      <%=rs.getString(4)%>
                    </div>
                    
                </div>

                
        <!-- out.print(rs.getString(1)); -->
      <% } %>

            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading"><b>Program Elective</b></div>
            <div class="panel-body">
              <% ResultSet rs2=st.executeQuery("select * from course where branch='"+branch+"' AND ctype='pe' AND sem='"+nextsem+"'"); 
              int pe_count = 0;
              while(rs2.next()){ pe_count++;}

              %>
              <%
              ResultSet rs1=st.executeQuery("select * from course where branch='"+branch+"' AND ctype='pe' AND sem='"+nextsem+"'"); 

              while(rs1.next()){ 
                  
              %>



                  <div class="row col-md-12">
                    <div class="col-md-4">
                      <form class="form-horizontal" action="/action_page.php">
                          <div class="form-group">
                            <div for="disabledInput" class="col-sm-2 control-label"><%=rs1.getString(1)%></div>
                            <div class="col-sm-10">
                              <input class="form-control" id="disabledInput" type="text" value=<%=rs1.getString(2)%> disabled>
                            </div>
                          </div>
                        </form>
                    </div>
                    <div class="col-md-4" align="center">
                      <%=rs1.getString(4)%>
                    </div>
                    <div class="col-md-4" align="center">
                        <select name="cars">

                          <% for(int i=1;i<=pe_count;i++){ %>
     
                            <option value=<%=i%>><%=i%></option>

                            <% } %>
                            <!-- <option value="saab">Saab</option>
                            <option value="fiat">Fiat</option>
                            <option value="audi">Audi</option> -->
                        </select>
                    </div>
                    
                </div>


              <% } %>

            </div>
        </div>

        <div class="row col-md-12">
              <div class="col-md-4">
                    
              </div>
              <div class="col-md-1" align="center">
                  <button type="submit" class="btn btn-danger" style="width: 100px">Submit</button>
              </div>
              <div class="col-md-2">
                    
              </div>
              <div class="col-md-1" align="center">
                  <button type="submit" class="btn btn-danger" style="width: 100px">Lock</button>
              </div>
              <div class="col-md-4">
                  
              </div>
                    
        </div>
    </div>

    <br><br>

</body>
</html>