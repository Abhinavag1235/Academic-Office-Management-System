import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class CourseRegDetails extends HttpServlet {
    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/aoms";

    //  Database credentials
    static final String USER = "isd";
    static final String PASS = "qwerty";


    private static final long serialVersionUID = 1;
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.sendRedirect("CourseRegistration.jsp");
        // Get user input
        String co_course = request.getParameter("co_course");
        String stu_roll = request.getParameter("stu_roll");
        String co_course_id = request.getParameter("co_course_id");
        
        HttpSession session = request.getSession(true);

        try {
            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Open a connection
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // Execute SQL query
            Statement stmt = conn.createStatement();
            Statement stmt1 = conn.createStatement();

            String sql, sql1, sql2;
            ResultSet rs, rs1, rs2;

            System.out.println(stu_roll);
            System.out.println(co_course_id);
            System.out.println(co_course);

            sql = "SELECT cursem from student WHERE sid='"+stu_roll+"'";
            rs = stmt.executeQuery(sql);
            rs.next();

            int nextsem = rs.getInt("cursem") + 1;

            sql1 = "INSERT into registration VALUES('"+stu_roll+"','"+co_course_id+"',"+nextsem+")";
            stmt1.executeUpdate(sql1);

            
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        }
    }

}