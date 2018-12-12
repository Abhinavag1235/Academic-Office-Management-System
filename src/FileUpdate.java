
// package com.chilyfacts.com;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.sql.*;

public class FileUpdate extends HttpServlet {
	private static final long serialVersionUID = 1;
	FileItem fileItem;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String file_name = null;
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
		if (!isMultipartContent) {
			return;
		}
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List<FileItem> fields = upload.parseRequest(request);
			Iterator<FileItem> it = fields.iterator();
			if (!it.hasNext()) {
				return;
			}
			while (it.hasNext()) {
				fileItem = it.next();
					if (fileItem.getSize() > 0) {
						fileItem.write(new File("/home/aashish/uploaded_files/" + fileItem.getName()));
					}
			}
            //database connection
			Class.forName("com.mysql.jdbc.Driver");
			Connection myConn=DriverManager.getConnection("jdbc:mysql://localhost:3306/aoms", "isd", "qwerty");
          /*  Statement mySmt=myConn.createStatement();
			ResultSet res=mySmt.executeQuery("select * from emp");
			while(res.next()) {
				System.out.println(res.getString("name")+' ' + res.getString("pass"));
			}*/
         // Read data from excel sheet
			String fName = "/home/aashish/uploaded_files/" + fileItem.getName();
			String thisLine;
			int count = 0;
			FileInputStream fis = new FileInputStream(fName);
			DataInputStream myInput = new DataInputStream(fis);
			int i = 0;
			
			while ((thisLine = myInput.readLine()) != null) {
				String strar[] = thisLine.split(",");

				if(i!=0){
					String querry="update grade1 set gradeas='" + strar[2] + "' where sid='"+strar[0]+"'";
    				//String data3=sheet1.getRow(i).getCell(3).getStringCellValue();
    				String querry1="update grade1 set gradepoint='" + strar[3] + "' where sid='"+strar[0]+"'";
    				PreparedStatement smt=myConn.prepareStatement(querry);
    				PreparedStatement smt1=myConn.prepareStatement(querry1);
    				
    				smt.executeUpdate(querry);
    				smt1.executeUpdate(querry1);
				}
				i++;
				
			}
			
    	//Enter data into database!
    		/*for(int i=0;i<rows;i++) {
    				String data0=sheet1.getRow(i).getCell(0).getStringCellValue();
    				String data1=sheet1.getRow(i).getCell(1).getStringCellValue();
    				String data2=sheet1.getRow(i).getCell(2).getStringCellValue();
    				String data3=sheet1.getRow(i).getCell(3).getStringCellValue();
    				String querry="insert into grade" +"(sid,cid,grades,gradePoint)"+ " values (?, ?,?,?)";
    				PreparedStatement mySmt1=myConn.prepareStatement(querry);
    				mySmt1.setString(1,data0);
    				mySmt1.setString(2,data1);
    				mySmt1.setString(3,data2);
    				mySmt1.setString(4,data3);
    				mySmt1.execute();
    				System.out.println("Done!!! ");		
    		}
    	wb.close();
    	*/
            
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			out.println("<script type='text/javascript'>");
			out.println("window.location.href='upload.jsp?filename=" + file_name + "'");
			out.println("</script>");
			out.close();
		}
	}
}