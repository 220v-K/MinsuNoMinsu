<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="preconnect" href="https://fonts.googleapis.com"> 
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" href="../css/top.css">
    <link rel="stylesheet" href="../css/signup.css">
    <script src="../js/popup.js"></script>
<title>중급 요리</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // connect to database

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    boolean connect = false;

    List<String> recipeName = new ArrayList<String>();
    List<String> nickname = new ArrayList<String>();
    List<String> userEmail = new ArrayList<String>();
    List<Date> date = new ArrayList<Date>();

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
        connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
        statement = connection.createStatement();
        // fetch recipe data where difficulty is 2
        String sql = "SELECT * FROM recipe WHERE difficulty = 2";
        resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            recipeName.add(resultSet.getString("recipeName"));
            userEmail.add(resultSet.getString("userEmail"));
            date.add(resultSet.getDate("recipeUploadTime"));
        }

        // fetch user data
        for (int i = 0; i < userEmail.size(); i++) {
            sql = "SELECT * FROM user WHERE email = '" + userEmail.get(i) + "'";
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                nickname.add(resultSet.getString("nickname"));
            }
        }

    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
    }
%>
<div class="titleBox">
    <div class="title" onclick="location.href='./main.jsp';">MNM</div>
    <div class="icon1" onclick="location.href='./mypagechange.jsp';"><span class="material-symbols-outlined" style="color : green;">account_circle</span></div>
    <div class="icon2" onclick="location.href='./recipesave.html';"><span class="material-symbols-outlined" style="color : red;">edit</span></div>
</div>
<div class="pageTitle"><h1>중급 요리</h1></div>
<div>
<div class="tableBox">
    <form method="POST" action="">
        <table border="0" id="recipeList">
            <% for (int i = 0; i < recipeName.size(); i++) { %>
            <tr>
                <td><%= recipeName.get(i) %></td>
                <td><%= nickname.get(i) %></td>
                <td><%= date.get(i) %></td>
                <td><input type="button" value="상세보기" onclick="location.href='./recipe.jsp?recipeName=<%= recipeName.get(i) %>'"></td>
            </tr>
            <% } %>
        </table>
    </form>
</div>
</div>
</body>
</html>