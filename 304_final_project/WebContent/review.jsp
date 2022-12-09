<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%
String productId = request.getParameter("id");
String rating = request.getParameter("rating");
String comment = request.getParameter("comment");
  try 
  {
    getConnection();
    Statement stmt = con.createStatement();             
    stmt.execute("USE orders");

	
    
   String query = "insert into review(reviewRating, reviewComment, productId) values(?, ?, ?)";
   PreparedStatement pstmt2 = con.prepareStatement(query);

   pstmt2.setInt(1, Integer.parseInt(rating));
   pstmt2.setString(2, comment);
   pstmt2.setString(3, productId);

   int x = pstmt2.executeUpdate();
   if(x>0){
    out.println("Rating stored");
   }else{
    out.println("Rating did not store");
   }

   
   


} catch (SQLException ex) {
    out.println(ex);
  } finally{
    closeConnection();
  }
  %>