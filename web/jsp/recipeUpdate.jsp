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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <style> @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap'); </style>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <link rel="stylesheet" href="../css/recipechange.css">
    <title>레시피 수정</title>
    <script>
        function openPopup(){
            window.open("../html/popup.html", "팝업", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0");
        }
    </script>
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

<body>
<div class="titlebox">
    <div class="title" onclick="location.href='../html/main.html';">MNM</div>
    <div class="icon1" onclick="openPopup()"><span class="material-symbols-outlined" style="color : green;">account_circle</span>
    </div>
    <div class="icon2" onclick="location.href='../html/recipesave.html';"><span class="material-symbols-outlined"
                                                                          style="color : red;">edit</span></div>
</div>
<div class="subtitle"><h1>레시피 수정</h1></div>
<div>
    <div id="box">
        <form method="POST" action="./recipeUpdateUpdate.jsp">
            <table border="0">
                <thead>
                <tr>
                    <td>레시피 제목</td>
                    <td><input type="text" name="recipetitle" size="20" class="recipetitle"></td>
                </tr>
                <tr>
                    <td>요리 소개</td>
                    <td><input type="text" name="recipeintro" size="100" class="recipeintro"></td>
                </tr>
                <tr name="put-in">
                    <td>준비물</td>
                    <td><input type="text" name="ingredient" size="10" class="ingredient"></td>
                    <td>
                        <button class="put-step" onclick="addIngredient()" name="put-in" type="button">재료 추가</button>
                    </td>
                    <select name='category'>
                        <option value="1">한식</option>
                        <option value="2">중식</option>
                        <option value="3">일식</option>
                        <option value="4">양식</option>
                        <option value="5">기타</option>
                    </select>
                </tr>
                <tr>
                    <td>요리 정보</td>
                    <td>인원
                        <select name='personnel'>
                            <option value="1">1인분</option>
                            <option value="2">2인분</option>
                            <option value="3">3인분</option>
                            <option value="4">4인분이상</option>
                        </select>
                        시간
                        <select name='timetaken'>
                            <option value="1">30분이내</option>
                            <option value="2">1시간이내</option>
                            <option value="3">2시간이내</option>
                            <option value="4">2시간이상</option>
                        </select>
                        난이도
                        <select name='difficulty'>
                            <option value="1">아무나</option>
                            <option value="2">중급자</option>
                            <option value="3">상급자</option>
                            <!-- 카테고리의 도전!요리사는 2시간이상 + 상급자일 경우 -->
                        </select>

                    </td>
                </tr>
                </thead>
                <tbody>
                <tr name="put-step">
                    <td>단계 1</td>
                    <td><input type="text" name="phase" size="40" class="phase"></td>
                    <td>
                        <button type="button" class="put-step" onclick="divResize()" name="put-step">단계 추가</button>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="twobutton">
                <input type="submit" value="수정하기" class="button-save">
                <input type="button" value="수정 취소하기" class="button-save">
            </div>
        </form>
    </div>
</div>


<script>
    var n = 1;
    $(document).on("click", "button[name=put-step]", function () {
        n += 1;
        var addsteptest =
            '<tr name="put-step">' +
            '<td>단계 ' + n + '</td>' +
            '<td><input type="text" name="phase" size="40" class="phase"></td>' +
            '</tr>';
        var trHtml = $("tr[name=put-step]:last");//last로 사용하여 trstep라는 명을 가진 마지막 태그 호출
        trHtml.after(addsteptest);//그 태그 뒤에 붙이기
    });
    $(document).on("click", "button[name=put-in]", function () {
        var addIngredient =
            '<td><input type="text" name="ingredient" size="10" class="ingredient"></td>';
        var trHtml2 = $("tr[name=put-in]:last");
        trHtml2.after(addIngredient);
    });

</script>

</body>

</body>
</html>
