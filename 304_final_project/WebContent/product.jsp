<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Bolu's Store - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
String productId = request.getParameter("id");
String sql = "SELECT productId, productName, productPrice, productImageURL, productImage, productDesc FROM Product P  WHERE productId = ?";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
int prodId=0;
try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst = pstmt.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<h2>"+rst.getString(2)+"</h2>");
		
		prodId = rst.getInt(1);
		String prodDesc = rst.getString(6);
		out.println("<table><tr>");
		out.println("<th>Year</th><td>" + prodDesc + "</td></tr>"				
				+ "<tr><th>Price</th><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		
		//  Retrieve any image with a URL
		String imageLoc = rst.getString(4);
		if (imageLoc != null)
			out.println("<img src=\""+imageLoc+"\">");
		
		// Retrieve any image stored directly in database
		String imageBinary = rst.getString(5);
		if (imageBinary != null)
			out.println("<img src=\"displayImage.jsp?id="+prodId+"\">");	
		out.println("</table>");
		
		out.println("<h3><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
								+ "&price=" + rst.getDouble(3)+"\">Add to Cart</a></h3>");		
		
		out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a>");
	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>
<%
  
  String sql2 = "SELECT reviewId, reviewRating, reviewDate, customerId, reviewComment FROM review WHERE productId = ?";

  try 
  {
    getConnection();
    Statement stmt = con.createStatement();             
    stmt.execute("USE orders");
    
    PreparedStatement pstmt1 = con.prepareStatement(sql2);
    pstmt1.setInt(1, prodId);

    
    
    ResultSet rst1 = pstmt1.executeQuery();
    if(rst1.next()){
      out.println("<table class=\"table\" border=\"1\">");
      out.println("<tr><th>Comment</th><th>Rating</th></tr>");
      do{
        out.println("<tr><td>" + rst1.getString(5) + "</td><td>" + rst1.getString(2) + "</td></tr>");
      } while(rst1.next());
      out.println("</table>");
    } else{
      out.println("<h2>NO REVIEWS FOUND</h2>");
    }

  } catch (SQLException ex) {
    out.println(ex);
  } finally{
    closeConnection();
  }
  %>
  <br>
<form name="MyForm" method=post action="review.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Rating:</font></div></td>
	<td><input type="number" name="rating"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Review Comment:</font></div></td>
	<td><input type="text" name="comment" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Input">
</form>




</body>
</html>


