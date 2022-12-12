<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/12
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
  request.setCharacterEncoding("UTF-8");

  int recipeNo = Integer.parseInt(request.getParameter("recipeNo"));
  //session에서 email 가져오기
  String email = (String) session.getAttribute("email");

  System.out.println("myEmail : " + email);


  Connection connection = null;
  Statement statement = null;
  ResultSet resultSet = null;

  try {
    if (email == null) {
      // if email is null, redirect to login page
      throw new Exception();
    }

    Class.forName("com.mysql.jdbc.Driver");
    String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
    connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
    statement = connection.createStatement();
    // fetch if user is already scrap the recipe
    String sql = "SELECT * FROM User_Scrap WHERE userEmail = '" + email + "' AND recipeNo = " + recipeNo;
    resultSet = statement.executeQuery(sql);
    if (resultSet.next()) {
      // if user is already scrap the recipe, delete the scrap
      sql = "DELETE FROM User_Scrap WHERE userEmail = '" + email + "' AND recipeNo = " + recipeNo;
      statement.executeUpdate(sql);
      out.println("<script>alert('스크랩 해제 하였습니다.'); history.back();</script>");
    } else {
      // if user is not scrap the recipe, insert the scrap
      sql = "INSERT INTO User_Scrap (userEmail, recipeNo) VALUES ('" + email + "', " + recipeNo + ")";
      statement.executeUpdate(sql);
      out.println("<script>alert('스크랩 하였습니다.'); history.back();</script>");
    }


  } catch (Exception exception) {
    out.println("DB 연동 오류: " + exception.getMessage());
    // alert error message and popup popup.html and back
    session.removeAttribute("email");
    out.println("<script>alert('로그인이 필요한 기능입니다.');</script>");
    out.println("<script> window.open(\"../html/popup.html\", \"팝업\", \"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0\");\n</script>");
    out.println("<script>history.back();</script>");
  }
%>