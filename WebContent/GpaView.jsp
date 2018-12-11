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
        <div class="container">
            <h3><b><br>SGPA / CGPA View</b></h4><br>
        </div>
        
        <%

                    
                    String RollNo="16ucs004",branch="cse";
                    int semster=5;
                    String course_id[]= new String[15];
                    int credits[]=new int[15];
                    int grade_point[]=new int[15];
                    float total_credits=0;
                    int i=0;
                    double Sgpa=0.0;

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
                        sql="Select gradePoint from grade where sid='"+RollNo+"' AND cid='"+course_id[j]+"'";
                        ResultSet rp= st.executeQuery(sql);
                        rp.next();
                            grade_point[j]=rp.getInt("gradePoint");
                            credit_score +=(grade_point[j]*credits[j]);
                            Sgpa=credit_score/total_credits;
                            
                            if(j==i-1){
                                String sq="Insert into marksheet(sid,sem,sgpa,semCredit) values ('"+RollNo+"',"+semster+","+Sgpa+","+total_credits+")";
                                st.executeUpdate(sq);


                                int k=0;
                                int semCredit[]=new int[15];
                                float sgpa[]=new float[15];
                                float total = 0;

                                String sq1="SELECT sgpa,semCredit FROM marksheet WHERE sid='"+RollNo+"'";
                                ResultSet rk= st.executeQuery(sq1);
                                while(rk.next()) {
                                      sgpa[k]= rk.getFloat("sgpa");

                                      
                                      semCredit[k]=rk.getInt("semCredit");
                                      total +=semCredit[k];	
                                      %>
                                      <%=sgpa[k]%>
                                      <%
                                      k++;
                                }
                                credit_score=0;
                                
                                for(int l=0;l<k;l++) {
                                    credit_score +=(sgpa[l]*semCredit[l]);
                                }
                                double Cgpa=credit_score/total;

                                %>
                                <%=Cgpa%>
                                <%

                                String sq2="UPDATE marksheet SET cgpa="+Cgpa+" WHERE sid='"+RollNo+"'";
                                st.executeUpdate(sq2);
                                
                            }
                        }

                    }
                    catch(Exception e) {
                            e.printStackTrace();
                        }
                       
        %>

        
</body>
</html>