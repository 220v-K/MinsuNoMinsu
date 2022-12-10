<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/10
  Time: 9:49 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>SignUp</title>
</head>
<body>
    <%
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        boolean connect = false;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
            connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
            statement = connection.createStatement();
//            String sql = "";
//            resultSet = statement.executeQuery(sql);
            connect = true;
        } catch (Exception exception){
            out.println("DB 연동 오류: " + exception.getMessage());
        }

        if(connect) out.println("DB 연결 성공");
        else out.println("DB 연결 실패");
    %>

</body>
</html>
