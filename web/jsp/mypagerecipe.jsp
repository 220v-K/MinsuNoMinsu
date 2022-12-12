<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/12
  Time: 3:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="static java.sql.JDBCType.NULL" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <meta charset="utf-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <style> @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap'); </style>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <link rel="stylesheet" href="../css/mypagerecipe.css"/>
    <link rel="stylesheet" href="../css/top.css">
    <title>팔로우, 즐겨찾기</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    // fetch email from session
    String email = (String) session.getAttribute("email");

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    List<String> followUserEmailList = new ArrayList<>();
    List<String> followUserNicknameList = new ArrayList<>();
    List<Integer> favoriteRecipeNoList = new ArrayList<>();
    List<String> favoriteRecipeNameList = new ArrayList<>();
    List<String> myRecipeNoList = new ArrayList<>();
    List<String> myRecipeNameList = new ArrayList<>();

    try {
        if (email == null) {
            // if email is null, redirect to login page
            throw new Exception();
        }

        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
        connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
        statement = connection.createStatement();

        // fetch follow user email list
        String sql = "SELECT * FROM User_Follow WHERE follower = '" + email + "'";
        resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            followUserEmailList.add(resultSet.getString("followee"));
        }

        // fetch follow user nickname list
        for (String followUserEmail : followUserEmailList) {
            sql = "SELECT * FROM User WHERE email = '" + followUserEmail + "'";
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                followUserNicknameList.add(resultSet.getString("nickname"));
            }
        }

        // fetch favorite recipe no list
        sql = "SELECT * FROM User_Scrap WHERE userEmail = '" + email + "'";
        resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            favoriteRecipeNoList.add(resultSet.getInt("recipeNo"));
        }

        // fetch favorite recipe name list
        for (Integer favoriteRecipeNo : favoriteRecipeNoList) {
            sql = "SELECT * FROM Recipe WHERE recipeNo = " + favoriteRecipeNo;
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                favoriteRecipeNameList.add(resultSet.getString("recipeName"));
            }
        }

        // fetch my recipe no list
        sql = "SELECT * FROM Recipe WHERE userEmail = '" + email + "'";
        resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            myRecipeNoList.add(resultSet.getString("recipeNo"));
        }

        // fetch my recipe name list
        for (String myRecipeNo : myRecipeNoList) {
            sql = "SELECT * FROM Recipe WHERE recipeNo = " + myRecipeNo;
            resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                myRecipeNameList.add(resultSet.getString("recipeName"));
            }
        }


    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
        // alert error message and popup popup.html and back
        session.removeAttribute("email");
        out.println("<script> window.open(\"../html/popup.html\", \"팝업\", \"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0\");\n</script>");
        out.println("<script>alert('재 로그인이 필요합니다.'); history.back();</script>");
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
<div class="pageTitle"><h1>마이페이지</h1></div>
<div class="bar">
    <div onclick="location.href='./mypagechange.jsp';" class="bar-item">마이페이지 수정</div>
    <div onclick="location.href='./mypagerecipe.jsp';" class="bar-item">내 레시피 / 구독계정</div>
</div>
<div>
    <div class="box">
        <form method="POST" action="../jsp/recipeUpdate.jsp" onsubmit="">
            <table>
                <tr>
                    <td name="myfollower">구독한 계정
                        <% for (String followUserNickname : followUserNicknameList) { %>
                        <td class="follower"><%= followUserNickname %>
                        </td>
                        <% } %>
                    </td>
                    <!--구독한 계정 <td>로 추가하기-->
                </tr>
                <tr name="myrecipe">
                    <td>내가 작성한 레시피</td>
                    <% for (String myRecipeName : myRecipeNameList) { %>
                    <td class="myrecipe"><%= myRecipeName %>
                    </td>
                    <% } %>
                </tr>
                <tr name="myfavorite">
                    <td>즐겨찾기한 레시피
                        <% for (String favoriteRecipeName : favoriteRecipeNameList) { %>
                        <td class="favorite"><%= favoriteRecipeName %>
                        </td>
                        <% } %>
                    </td>
                    </tr>
            </table>
            <br><br>
        </form>
    </div>
</div>
<script>
    function myfollower() {
        var addfollower =
            '<td>' +
            '<input value="id" class=>' +
            '</td>';
        var tdHtml = $("input[name=myfollower]:last");
        tdHtml.after(addfollower);
    };

    function myrecipe() {
        var addrecipe =
            '<tr name="myrecipe" class >' +
            '<td></td>' +
            '<td></td>' +
            '<td><input type="submit" value="수정" class="put-in"></td>' +
            '</tr>';
        var trHtml = $("tr[name=myrecipe]:last");
        trHtml.after(addrecipe);//그 태그 뒤에 붙이기
    };
</script>
</body>
</body>
</html>
