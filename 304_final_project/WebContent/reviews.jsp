<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<%@ include file="header.jsp" %>
<%
String productId = request.getParameter("id");
int rat = Integer.parseInt(request.getParameter("rating"));
String comment = request.getParameter("comment");
  try 
  {
    getConnection();
    Statement stmt = con.createStatement();             
    stmt.execute("USE orders");

	
    
   String query = "insert into review(reviewRating, reviewComment) values(rat, comment) where productId = ?";
   PreparedStatement pstmt2 = con.prepareStatement(query);
   pstmt2.setInt(1, Integer.parseInt(productId));
   try(ResultSet rst2 = pstmt2.executeQuery()){
    if (rst2.next()){
      out.println("<table class=\"table\" border=\"1\">");
        out.println("<tr><th>Comment</th><th>Rating</th></tr>");
        do{
          out.println("<tr><td>" + comment + "</td><td>" + rat + "</td></tr>");
        } while(rst2.next());{
        out.println("</table>");
      }} else{
        out.println("<h2>Empty</h2>");
      }
    }
    
  
} catch (SQLException ex) {
  out.println(ex);
} finally{
  closeConnection();
}

   
   

   


    
    
    
    

  } catch (SQLException ex) {
    out.println(ex);
  } finally{
    closeConnection();
  }
  %>
