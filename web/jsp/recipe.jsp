<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/12
  Time: 12:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR@700&display=swap" rel="stylesheet">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <link rel="stylesheet" href="../css/top.css">
    <link rel="stylesheet" href="../css/recipe.css">
    <title>레시피 소개</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    // fetch input data from signup.html
    String recipeName = request.getParameter("recipeName");

    String recipeExplain = "";
    int recipeCategory = 0;
    int forNperson = 0;
    int withInTime = 0;
    int difficulty = 0;
    Date recipeUploadTime = null;
    String userEmail = "";
    int recipeNo = 0;
    String fileName = "";
    String userNickname = "";
    String userIntroduce = "";

    List<String> progresses = new ArrayList<>();
    List<String> ingredients = new ArrayList<>();
    List<String> comments = new ArrayList<>();
    List<Date> commentTime = new ArrayList<>();
    List<String> commentUser = new ArrayList<>();
    List<String> commentUserNick = new ArrayList<>();

    String difficultyStr = "";
    String forNpersonStr = "";
    String withInTimeStr = "";

    String placeholderEmail = "  로그인이 필요합니다.";
    // fetch email from session
    String email = (String) session.getAttribute("email");
    if (email != null) {
        placeholderEmail = "  댓글 작성하기";
    }


    System.out.println("email: " + email);


    System.out.println("recipeName: " + recipeName);

    // connect to database

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
        connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
        statement = connection.createStatement();


        // fetch recipe data from recipe table
        String sql = "SELECT * FROM recipe WHERE recipeName = '" + recipeName + "'";
        resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            recipeExplain = resultSet.getString("recipeExplain");
            recipeCategory = resultSet.getInt("recipeCategory");
            forNperson = resultSet.getInt("forNperson");
            withInTime = resultSet.getInt("withInTime");
            difficulty = resultSet.getInt("difficulty");
            recipeUploadTime = resultSet.getDate("recipeUploadTime");
            userEmail = resultSet.getString("userEmail");
            recipeNo = resultSet.getInt("recipeNo");
            fileName = resultSet.getString("fileName");
        }

        if (fileName == null) {
            fileName = "noImage.png";
        } else {
            fileName = "../fileStorage/" + fileName;
        }

        // fetch user nickname from user table
        sql = "SELECT * FROM user WHERE email = '" + userEmail + "'";
        resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            userNickname = resultSet.getString("nickname");
            userIntroduce = resultSet.getString("introduce");
            if (userIntroduce == null) {
                userIntroduce = "";
            }
        }

        // fetch progress data from progress table
        sql = "SELECT * FROM progress WHERE recipeNo = " + recipeNo + " order by progressOrder";
        resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            progresses.add(resultSet.getString("progressText"));
        }

        // fetch ingredient data from ingredient table
        sql = "SELECT * FROM ingredient WHERE recipeNo = " + recipeNo;
        resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            ingredients.add(resultSet.getString("ingredientName"));
        }

        // fetch comment data from comment table
        sql = "SELECT * FROM comment WHERE recipeNo = " + recipeNo;
        resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            comments.add(resultSet.getString("commentText"));
            commentTime.add(resultSet.getDate("commentTime"));
            commentUser.add(resultSet.getString("userEmail"));
            System.out.println("commentUser: " + commentUser);
            System.out.println("commentText: " + resultSet.getString("commentText"));
        }

        // fetch userNick from user table
        for (int i = 0; i < commentUser.size(); i++) {
            sql = "SELECT * FROM user WHERE email = '" + commentUser.get(i) + "'";
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                commentUserNick.add(resultSet.getString("nickname"));
            }
        }

        // change fetched data to string
        switch (forNperson) {
            case 1:
                forNpersonStr = "1인분";
                break;
            case 2:
                forNpersonStr = "2인분";
                break;
            case 3:
                forNpersonStr = "3인분";
                break;
            case 4:
                forNpersonStr = "4인분 이상";
                break;
        }


        switch (withInTime) {
            case 1:
                withInTimeStr = "30분 이내";
                break;
            case 2:
                withInTimeStr = "1시간 이내";
                break;
            case 3:
                withInTimeStr = "2시간 이내";
                break;
            case 4:
                withInTimeStr = "2시간 이상";
                break;
        }


        switch (difficulty) {
            case 1:
                difficultyStr = "아무나";
                break;
            case 2:
                difficultyStr = "중급자";
                break;
            case 3:
                difficultyStr = "상급자";
                break;
        }

    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
    }
%>
<div class="titleBox">
    <div class="title" onclick="location.href='./main.jsp';">MNM</div>
    <div class="icon1" onclick="location.href='./mypagechange.jsp';"><span class="material-symbols-outlined"
                                                                           style="color : green;">account_circle</span>
    </div>
    <div class="icon2" onclick="location.href='../html/recipesave.html';"><span class="material-symbols-outlined"
                                                                                style="color : red;">edit</span></div>
</div>
<div class="cookimage"><img class="cook-item" src="<%=fileName%>" alt="사진 없음"></div>
<div class="recipebox">
    <div class="rtitle"><%=recipeName%>
    </div>
    <div class="rexplain"><%=recipeExplain%>
    </div>
</div>
<div class="content">
    <div class="content-item"><%=forNpersonStr%>></div>
    <div class="content-item"><%=withInTimeStr%>></div>
    <div class="content-item"><%=difficultyStr%>></div>
</div>
<div class="ingredient">
    <div class="context-name">준비물</div>
    <% for (String ingredient : ingredients) { %>
    <div class="ingredient-item"><%=ingredient%>
    </div>
    <% } %>
</div>
<div class="order">
    <div class="context-name">조리순서</div>
    <% for (int i = 0; i < progresses.size(); i++) { %>
    <div class="order-item"><%=i + 1%>. <%=progresses.get(i)%>
    </div>
    <% } %>
    <div class="order-item"></div>
</div>
<div class="comment">
    <div class="context-name">댓 글</div>
    <div class="comment-item"></div>
        <% for (int i = 0; i < comments.size(); i++) { %>
    <div class="comment-item"><%=commentUserNick.get(i)%> : <%=comments.get(i)%> (<%=commentTime.get(i)%>)
        <% if (commentUser.get(i).equals(email)) { %>
        <button class="comment-delete"
                onclick="location.href='./commentdelete.jsp?recipeNo=<%=recipeNo%>&commentNo=<%=i%>';">삭제
        </button>
        <% } %>
        <% } %>
    </div>

    <div class="write-comment">
        <div class="context-name">댓글 작성하기</div>
        <center>
            <form method="post" action="addComment.jsp">
                <input type="text" placeholder="<%=placeholderEmail%>" name="comment" size="100">
                <input type="hidden" value="<%=recipeNo%>" name="recipeNo">
                <input type="submit" value="저 장" class="submit">
            </form>
        </center>
    </div>
    <div class="profile">
        <div class="box1">
            <div class="name"><%=userNickname%></div>
            <div class="self-intro"><%=userIntroduce%></div>
            <!-- 작성자 자기소개 넣기 -->
        </div>
        <div class="box2">
            <div class="follow"><a href="../jsp/follow.jsp?targetEmail=<%=userEmail%>"><img class="follow-img" src="../check.png"></a></div>
            <div class="scrap"><a href="../jsp/scrap.jsp?recipeNo=<%=recipeNo%>"><img class="scrap-img" src="../external-link.png"></a></div>
            <!-- 팔로우와 스크랩 기능 -->
        </div>
    </div>
</body>
</html>
