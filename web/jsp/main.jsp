<%--
Created by IntelliJ IDEA.
User: jaewonlee
Date: 2022/12/11
Time: 7:36 PM
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <title>메인화면</title>
    <link href="style.css" rel="stylesheet" type="text/css"/>
    <script src="https://kit.fontawesome.com/8eb5905426.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR@700&display=swap" rel="stylesheet">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <link href="../css/main.css" rel="stylesheet" type="text/css"/>
    <script>
        function openPopup() {
            var email = '<%=(String)session.getAttribute("email")%>';
            console.log(email);
            if (email != null) {
                // change location to mypagechange.html
                window.location.href = "../jsp/mypagechange.jsp";
            } else {
                window.open("../html/popup.html", "팝업", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0");
            }
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // connect to database

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    boolean connect = false;

    String[] recipeName = new String[3];
    String[] recipeImage = new String[3];
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
        connection = DriverManager.getConnection(jdbcUrl, "root", "0000");
        statement = connection.createStatement();
        // query of fetch last 3 data from recipe table
        String sql = "SELECT * FROM recipe ORDER BY recipeNo DESC LIMIT 3";
        resultSet = statement.executeQuery(sql);

        int i = 0;
        // save data to request
        while (resultSet.next()) {
//            request.setAttribute("recipe" + i, resultSet.getString("recipeName"));
            recipeName[i] = resultSet.getString("recipeName");
//            String saveFolder = application.getRealPath("/fileStorage");
            String saveFolder = "";
            String fileName = resultSet.getString("filename");
            if(fileName == null) {
                recipeImage[i] = saveFolder + "../fileStorage/noimage.png";
            } else {
                recipeImage[i] = saveFolder + "../fileStorage/" + fileName;
            }

            System.out.println(recipeImage[i]);

            i++;
        }
    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
    }
%>

<div class="main-signin">
    <div class="icon1">
        <button onclick="openPopup()" style="border: none; background-color: white;">
            <span class="material-symbols-outlined" style="color : green;">account_circle</span></button>
    </div>
    <div class="icon2" onclick="location.href='../html/recipesave.html';"><span class="material-symbols-outlined"
                                                                                style="color : red;">edit</span></div>
</div>

<div class="main">
    <div class="main-title">
        M<span style="color:#9FE7C9">N</span>M
    </div>
    <div class="subtitle">
        <span style="color:#9FE7C9">요리초보</span>를 위한 <span style="color:#9FE7C9">레시피</span> 블로그
    </div>
</div>

<div class="nav">
    <div class="nav-item" onclick="location.href='./basicrecipe.jsp';">초급요리</div>
    <div class="nav-item" onclick="location.href='./middlerecipe.jsp';">중급요리</div>
    <div class="nav-item" onclick="location.href='./hardrecipe.jsp';">고급요리</div>
    <div class="nav-item" onclick="location.href='./chefrecipe.jsp';">도전! 요리사</div>
</div>
<br><br>

<form action="searchResult.jsp" method="post">
    <div class="search">
        <button type="submit" style="background-color:transparent;  border:0px transparent solid;" ><i class="fas fa-search"></i></button>
        <input type="text" placeholder="요리 이름 또는 재료를 검색하세요">
        <input type="submit" value="" style="background-color:transparent;  border:0px transparent solid;">
    </div>
</form>
<br><br><br>
<div class="foods">
    <div class="food-item">
        <br>
        <%=recipeName[0]%>
        <br>
        <img src="<%=recipeImage[0]%>" alt="사진 없음" width="250" height="250">
    </div>

    <div class="food-item">
        <br>
        <%=recipeName[1]%>
        <br>
        <img src="<%=recipeImage[1]%>" alt="사진 없음" width="250" height="250">
    </div>

    <div class="food-item">
        <br>
        <%=recipeName[2]%>
        <br>
        <img src="<%=recipeImage[2]%>" alt="사진 없음" width="250" height="250">
    </div>
</div>

<script>
</script>

</body>
</html>
