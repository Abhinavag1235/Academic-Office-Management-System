import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {
    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/aoms";

    //  Database credentials
    static final String USER = "isd";
    static final String PASS = "qwerty";


    private static final long serialVersionUID = 1;
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get user input
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        HttpSession session = request.getSession(true);

        try {
            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Open a connection
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // Execute SQL query
            Statement stmt = conn.createStatement();
            Statement stmt1 = conn.createStatement();
            Statement stmt2 = conn.createStatement();

            String sql, sql1, sql2;
            ResultSet rs, rs1, rs2;

            sql = "SELECT * FROM users";
            rs = stmt.executeQuery(sql);

            sql1 = "SELECT * FROM student WHERE sid='" + user + "'";
            rs1 = stmt1.executeQuery(sql1);
            rs1.next();

            String id, name = null, username = null, password = null, branch = null, cursem = null;
            int level;



            // Extract data from result set
            while (rs.next()) {
                //Retrieve by column name
                id = rs.getString("id");
                username = rs.getString("username");
                password = rs.getString("password");
                level = rs.getInt("level");


                if (username.equals(user) && password.equals(pass) && level == 1) {

                    branch = rs1.getString("branch");
                    cursem = rs1.getString("cursem");
                    name = rs1.getString("sname");

                    sql2 = "SELECT * FROM course WHERE branch='" + branch + "'";
                    rs2 = stmt2.executeQuery(sql2);
                    rs2.next();


                    session.setAttribute("userName", user);
                    session.setAttribute("fullName", name);
                    session.setAttribute("branch", branch);
                    session.setAttribute("cursem", cursem);
                    response.sendRedirect("StudentHome.jsp");
                } else if (username.equals(user) && password.equals(pass) && level == 2) {
                    session.setAttribute("userName", user);
                    response.sendRedirect("FacultyHome.jsp");
                }
            }
            if (username != user && password != pass) {
                session.setAttribute("errorMessage", "Invalid credentials");
                response.sendRedirect("ErrorPage.jsp");
            }
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