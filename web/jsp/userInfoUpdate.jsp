<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/12
  Time: 2:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>

<html>
<head>
  <title>SignUp</title>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");
  // fetch input data from signup.html
  String inputId = request.getParameter("id");
  String inputPassword = request.getParameter("fixpassword");
  String inputName = request.getParameter("nickname");
  String introduce = request.getParameter("introme");

  // connect to database

  Connection connection = null;
  Statement statement = null;
  ResultSet resultSet = null;
  boolean connect = false;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
    connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
    statement = connection.createStatement();
    // Update user information to user table
    String sql = "update user set password = '" + inputPassword + "', nickname = '" + inputName + "', introduce = '" + introduce + "' where id = '" + inputId + "'";
    // execute query
    statement.executeUpdate(sql);

    out.println("success");
    out.println("<script>alert('회원정보 수정이 완료되었습니다.'); history.back();</script>");
  } catch (Exception exception) {
    out.println("DB 연동 오류: " + exception.getMessage());
  }
%>

<script>
</script>

</body>
</html>