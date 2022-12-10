<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/10
  Time: 9:49 오후
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
    String inputPassword = request.getParameter("passwd");
    String inputEmail = request.getParameter("email");
    String inputName = request.getParameter("nickname");

    out.println(inputId);
    out.println(inputPassword);
    out.println(inputEmail);
    out.println(inputName);
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
        // sql query with null value(introduce)
        String sql = "INSERT INTO User VALUES ('" + inputId + "', '" + inputPassword + "', '" + inputEmail + "', '" + inputName + "', null)";
        statement.executeUpdate(sql);

        out.println("success");
    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
    }
%>

<script>
</script>

</body>
</html>
