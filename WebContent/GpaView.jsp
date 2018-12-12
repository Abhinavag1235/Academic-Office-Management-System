<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>

<head>
    <title>SGPA / CGPA View</title>
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
        <h3><b><br>SGPA / CGPA View</b></h4><br>
    </div>

    <%

                    
                    // String rollNo;
                    int semster=5;
                    String course_id[]= new String[15];
                    int credits[]=new int[15];
                    int grade_point[]=new int[15];
                    float total_credits=0;
                    int i=0;
                    double Sgpa=0.0,Cgpa=0.0;

                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/aoms","isd","qwerty" );

                        Statement st=(Statement) conn.createStatement();
                        String sql="Select * from course c,registration r Where c.sem="+semster+" AND c.branch='"+branch+"' AND c.cid=r.cid";

                        ResultSet rs= st.executeQuery(sql);

                        while(rs.next()) {
                          course_id[i]= rs.getString("cid");
                          credits[i]=rs.getInt("credits");
                          total_credits +=credits[i];
                          i++;
                        }

                        float credit_score=0;

                        for(int j=0;j<course_id.length;j++) {
                        sql="Select gradePoint from grade where sid='"+rollNo+"' AND cid='"+course_id[j]+"'";
                        ResultSet rp= st.executeQuery(sql);
                        rp.next();
                            grade_point[j]=rp.getInt("gradePoint");
                            credit_score +=(grade_point[j]*credits[j]);
                            Sgpa=credit_score/total_credits;
                            
                            if(j==i-1){
                                String sq="Insert into marksheet(sid,sem,sgpa,semCredit) values ('"+rollNo+"',"+semster+","+Sgpa+","+total_credits+")";
                                st.executeUpdate(sq);


                                int k=0;
                                int semCredit[]=new int[15];
                                float sgpa[]=new float[15];
                                float total = 0;

                                String sq1="SELECT sgpa,semCredit FROM marksheet WHERE sid='"+rollNo+"'";
                                ResultSet rk= st.executeQuery(sq1);
                                while(rk.next()) {
                                      sgpa[k]= rk.getFloat("sgpa");
                                      semCredit[k]=rk.getInt("semCredit");
                                      total +=semCredit[k]; 
                                      k++;
                                }
                                credit_score=0;
                                
                                for(int l=0;l<k;l++) {
                                    credit_score +=(sgpa[l]*semCredit[l]);
                                }
                                Cgpa=credit_score/total;
                                String sq2="UPDATE marksheet SET cgpa="+Cgpa+" WHERE sid='"+rollNo+"'";
                                st.executeUpdate(sq2);
                                
                            }
                        }

                    }
                    catch(Exception e) {
                            e.printStackTrace();
                        }
                       
        %>

        <div class="container">
            <div class="panel panel-default">
                    <div class="panel-heading"><b>Personal Details</b></div>
                    <div class="panel-body">
                        <div class="row col-md-12">
                            <div class="col-md-6">
                                <p>Student Name :
                                    <%=nam%>
                                </p>
                                <p>Branch :
                                    <%=branch%>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <p>Roll No :
                                    <%=rollNo%>
                                </p>
                                <p>Semester :
                                    <%=cursem %>
                                </p>
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
        ResultSet rs=st.executeQuery("select c.cid,c.cname,c.credits from registration r,course c where r.sid='"+rollNo+"' AND r.sem="+cursem+" AND r.cid=c.cid"); 

        

        int p=0;
        String course_grade[]= new String[15];
        int course_gradePoint[]= new int[15];
        String courseId[]=new String[15];


        int q=0;
        while(rs.next()){ 
                        courseId[q]=rs.getString(1);
                        Statement st1= con.createStatement(); 
                        ResultSet rs1=st1.executeQuery("select g.grades,g.gradePoint from grade g where g.sid='"+rollNo+"' AND g.cid='"+courseId[q]+"'"); 
                        rs1.next();

                        %>

                    <div class="row col-md-12">
                        <div class="col-md-2">
                            <form class="form-horizontal" action="/action_page.php">
                                <div class="form-group">
                                    <div for="disabledInput" class="col-sm-2 control-label">
                                        <%=rs.getString(1)%>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-md-4">
                            <%=rs.getString(2)%>
                        </div>
                        <div class="col-md-1">
                            <%=rs.getString(3)%>
                        </div>
                        <div class="col-md-2">
                            <%=rs1.getString(1)%>
                        </div>
                        <div class="col-md-3">
                            <%=rs1.getInt(2)%>
                        </div>
                    </div>
                    
                    <% q++;} %>

                </div>
            </div>

            <div class="panel panel-default">
                    <div class="panel-heading"><b>GPA</b></div>
                    <div class="panel-body">
                        <div class="row col-md-12">
                            <div class="col-md-6">
                                <p>SGPA :
                                    <%=Sgpa%>
                                </p>
                            </div>
                            <div class="col-md-6">
                                <p>CGPA :
                                    <%=Cgpa%>
                                </p>
                            </div>
                        </div>
                    </div>
            </div>

        </div>

</body>

</html>