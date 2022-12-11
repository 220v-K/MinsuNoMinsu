<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/11
  Time: 9:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="static java.sql.JDBCType.NULL" %>
<html>
<head>
    <title>레시피 등록</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String recipeName = "";
    String recipeExplain = "";
    int recipeCategory = 0;
    int forNperson = 0;
    int withInTime = 0;
    int difficulty = 0;
    Date recipeUploadTime = null;
    String userEmail = "";


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

        // get recipe information from recipe table
        String sql = "SELECT * FROM recipe";
        resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            recipeName = resultSet.getString("recipeName");
            recipeExplain = resultSet.getString("recipeExplain");
            recipeCategory = resultSet.getInt("recipeCategory");
            forNperson = resultSet.getInt("forNperson");
            withInTime = resultSet.getInt("withInTime");
            difficulty = resultSet.getInt("difficulty");
            recipeUploadTime = resultSet.getDate("recipeUploadTime");
            userEmail = resultSet.getString("userEmail");
        }

        // print success message
        System.out.println("레시피 불러오기 성공");


    } catch (Exception exception) {
        //error message
        out.println(exception.getMessage());
    }
%>

<script>
</script>

</body>
</html>
