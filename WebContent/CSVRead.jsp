<%@ page import="java.io.*"%>
<html>
<body>
	<%
		String fName = "/home/aashish/Downloads/battles.csv";
		String thisLine;
		int count = 0;
		FileInputStream fis = new FileInputStream(fName);
		DataInputStream myInput = new DataInputStream(fis);
		int i = 0;
	%>
	<table>
		<%
			while ((thisLine = myInput.readLine()) != null) {
				String strar[] = thisLine.split(",");
				for (int j = 0; j < strar.length; j++) {
					if (i != 0) {
						out.print(" " + strar[j] + " ");
					} else {
						out.print(" <b>" + strar[j] + "</b> ");
					}
				}
				out.println("<br>");
				i++;
			}
		%>
	</table>
</body>
</html>