<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*"%>
<%@ page import="com.itextpdf.text.*"%>
<%@ page import="com.itextpdf.text.pdf.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.itextpdf.text.pdf.draw.LineSeparator"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@page import="net.io.mail.Mailer" %>
<%!Connection con1,con;
	Statement st1, st2,st;
	ResultSet rs1, rs2;
	int row;
	String patname, docname, bid, date, c, ph, spec, loc, dname,email;%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Generate PDF</title>
</head>
<body>
	<%
		patname = request.getParameter("patname");
		docname = request.getParameter("docname");
		dname = request.getParameter("dname");
		bid = request.getParameter("bid");
		email=request.getParameter("email");
		String[] a = request.getParameter("d").split("\n");
		String[] b = request.getParameter("p").split("\n");
		c = request.getParameter("ac");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy");

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con1 = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

			st1 = con1.createStatement();
			rs1 = st1.executeQuery("SELECT date from booking WHERE bookingid='" + bid + "' Limit 1");

			while (rs1.next()) {
				date = rs1.getString(1);
			}

			st2 = con1.createStatement();
			rs2 = st2.executeQuery(
					"SELECT `phone`,`specification`,`location` FROM `doctordetails` WHERE `username`='" + dname
							+ "' Limit 1");
			while (rs2.next()) {
				ph = rs2.getString(1);
				spec = rs2.getString(2);
				loc = rs2.getString(3);
			}

		} catch (Exception e) {
			System.out.println(e);
		}

		Font headline = FontFactory.getFont(FontFactory.HELVETICA, 14, Font.BOLD);
		Font italic = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.ITALIC);
		Font bold = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLD);
		Font regular = FontFactory.getFont(FontFactory.HELVETICA, 12);
		Font boldItalic = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.BOLDITALIC);
		Document document = new Document();
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		Date current=null;
		try {
			PdfWriter writer = PdfWriter.getInstance(document, baos);
			document.open();

			current = sdf.parse(date);

			Paragraph paragraph1 = new Paragraph(formatter.format(current), italic);
			paragraph1.add(new Chunk("\n" + bid, boldItalic));
			paragraph1.setAlignment(Element.ALIGN_RIGHT);
			document.add(paragraph1);

			Paragraph paragraph2 = new Paragraph(docname, headline);
			paragraph2.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph2);

			Paragraph paragraph3 = new Paragraph(spec, italic);
			paragraph3.add(new Chunk("\nPhone No.: ", boldItalic));
			paragraph3.add(new Chunk(ph, italic));
			paragraph3.add(new Chunk("\nLocation: ", boldItalic));
			paragraph3.add(new Chunk(loc, italic));
			paragraph3.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph3);

			document.add(new Paragraph(" "));
			document.add(new LineSeparator());

			Paragraph paragraph4 = new Paragraph("Patient Name: ", bold);
			paragraph4.add(new Chunk(patname, regular));
			document.add(paragraph4);
			document.add(new Paragraph(" "));

			Paragraph paragraph5 = new Paragraph("Diagnosis: ", bold);
			document.add(paragraph5);

			List unorderedList = new List(List.UNORDERED);
			for (String d : a) {
				unorderedList.add(new ListItem(d));
			}
			document.add(unorderedList);

			document.add(new Paragraph(" "));

			Paragraph paragraph6 = new Paragraph("Prescription:", bold);
			document.add(paragraph6);

			List unorderedList1 = new List(List.UNORDERED);
			for (String d : b) {
				unorderedList1.add(new ListItem(d));
			}
			document.add(unorderedList1);

			document.add(new Paragraph(" "));

			Paragraph paragraph7 = new Paragraph("Additional Comments:", bold);
			document.add(paragraph7);

			Paragraph paragraph8 = new Paragraph(c, regular);
			document.add(paragraph8);

			document.close();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		int row = 0;
        try {
            Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");
            
			PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO `report`(`bookingid`, `reportpdf`, `date`) VALUES (?,?,?)");

            preparedStatement.setString(1, bid);
            preparedStatement.setString(3, date);
            if (document != null) {
            	ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
        		preparedStatement.setBlob(2, bais);
            }

            row = preparedStatement.executeUpdate();            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/dchealth?serverTimezone=UTC", "root", "");

			st = con.createStatement();

			row = st.executeUpdate("UPDATE `booking` SET `diagnosed`=true WHERE `bookingid`='"+bid+"'");

		} catch (Exception e) {
			out.println(e);
		}

        String subject="Medical Report Generated";
    	String msg="Dear "+patname+",\n"+docname+" has generated the report on "+formatter.format(current)+".";
    	msg+="\nYou can view it on your account.";
    	Mailer.send(email, subject, msg);	
    	session.setAttribute("user",dname);
    	session.setAttribute("msg", subject);
    	response.sendRedirect("HomePageDoctor.jsp");
    	
	%>
</body>
</html>