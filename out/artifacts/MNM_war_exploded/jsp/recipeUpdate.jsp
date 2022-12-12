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
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <style> @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap'); </style>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <link rel="stylesheet" href="../css/recipesave.css"/>
    <link rel="stylesheet" href="../css/top.css"/>
    <title>레시피 수정</title>
    <script>
        function openPopup() {
            window.open("../html/popup.html", "팝업", "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0");
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

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

    List<String> progresses = new ArrayList<>();
    List<String> ingredients = new ArrayList<>();


    // connect to database
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    boolean connect = false;

    int i = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
        connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
        statement = connection.createStatement();

        // get recipe information from recipe table
        String sql = "SELECT * FROM recipe WHERE recipeName = '" + recipeName + "'";
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
            recipeNo = resultSet.getInt("recipeNo");
            fileName = resultSet.getString("fileName");
            if (fileName == null) {
                fileName = "사진 없음";
            }
        }

        System.out.println(recipeName);
        System.out.println(recipeExplain);
        System.out.println(recipeCategory);
        System.out.println(forNperson);
        System.out.println(withInTime);
        System.out.println(difficulty);
        System.out.println(recipeUploadTime);
        System.out.println(userEmail);
        System.out.println(recipeNo);
        System.out.println(fileName);

        // get progress information from progress table
        sql = "SELECT * FROM progress where recipeNo = " + recipeNo;
        resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            progresses.add(resultSet.getString("progressText"));
        }

        // get ingredient information from ingredient table
        sql = "SELECT * FROM ingredient where recipeNo = " + recipeNo;
        resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            ingredients.add(resultSet.getString("ingredientName"));
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
    <div class="title" onclick="location.href='../jsp/main.jsp';">MNM</div>
    <div class="icon1" onclick="openPopup()"><span class="material-symbols-outlined" style="color : green;">account_circle</span>
    </div>
    <div class="icon2" onclick="location.href='../html/recipesave.html';"><span class="material-symbols-outlined"
                                                                                style="color : red;">edit</span></div>
</div>
<div class="subtitle"><h1>레시피 수정</h1></div>
<div>
    <div id="box">
        <form method="post" action="../jsp/recipeUpdateUpdate.jsp" onsubmit="" enctype="multipart/form-data">
            <table border="0">
                <tr>
                    <td>레시피 제목</td>
                    <td><input type="text" name="recipetitle" size="20" class="recipetitle" value="<%=recipeName%>">
                    </td>
                </tr>
                <tr>
                    <td>요리 소개</td>
                    <td><input type="text" name="recipeintro" size="100" class="recipeintro" value="<%=recipeExplain%>">
                    </td>
                </tr>
                <tr>
                    <td>요리 사진</td>
                    <td><input type="file" name="recipeImg" size="100" class="recipeImg" ></td>
                    <td>기존 사진 : <%=fileName%></td>
                </tr>
                <tr name="put-in">
                    <td>재료</td>
                    <td name="put-in"><input type="text" name="ingredient" size="10" class="ingredient"></td>
                    <td>
                        <button type="button" name="put-in" class="put-in">재료 추가</button>
                    </td>
                </tr>
                <tr>
                    <td>요리 정보</td>
                    <td>종류
                        <select name='category'>
                            <option value="1">한식</option>
                            <option value="2">중식</option>
                            <option value="3">일식</option>
                            <option value="4">양식</option>
                            <option value="5">기타</option>
                        </select>
                        &nbsp;&nbsp;인원
                        <select name='personnel'>
                            <option value="1">1인분</option>
                            <option value="2">2인분</option>
                            <option value="3">3인분</option>
                            <option value="4">4인분이상</option>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>시간
                        <select name='timetaken'>
                            <option value="1">30분이내</option>
                            <option value="2">1시간이내</option>
                            <option value="3">2시간이내</option>
                            <option value="4">2시간이상</option>
                        </select>
                        &nbsp;&nbsp;난이도
                        <select name='difficulty'>
                            <option value="1">아무나</option>
                            <option value="2">중급자</option>
                            <option value="3">상급자</option>
                            <!-- 카테고리의 도전!요리사는 2시간이상 + 상급자일 경우 -->
                        </select>

                    </td>
                </tr>

                <tr name="put-step">
                    <td>단계 1</td>
                    <td><input type="text" name="phase" size="40" class="phase"></td>
                    <td>
                        <button type="button" name="put-step" class="put-in" onclick="">단계 추가</button>
                    </td>
                </tr>
            </table>
            <center><input type="submit" value="등록하기" class="button-save"></center>
            <br><br>
        </form>
    </div>
</div>

<!-- 기본값 수정 -->
<script>
    // set default value of select tag
    var category = document.getElementsByName("category")[0];
    category.value = <%=recipeCategory%>;

    var personnel = document.getElementsByName("personnel")[0];
    personnel.value = <%=forNperson%>;

    var timetaken = document.getElementsByName("timetaken")[0];
    timetaken.value = <%=withInTime%>;

    var difficulty = document.getElementsByName("difficulty")[0];
    difficulty.value = <%=difficulty%>;

    // set default value of ingredient
    var ingredient = document.getElementsByName("ingredient");
    var i = 0;

    ingredient[i].value = "<%=ingredients.get(0)%>";

    for (i = 1; i < <%=ingredients.size()%>; i++) {
        var addIngredient =
            '<input type="text" name="ingredient" size="10" class="ingredient">';
        var tdHtml = $("input[name=ingredient]:last");
        tdHtml.after(addIngredient);
    }
    <%
        for (int k = 1; k < ingredients.size(); k++) {
    %>
    ingredient[<%=k%>].value = "<%=ingredients.get(k)%>";
    <%
        }
    %>

    // set default value of phase
    var phase = document.getElementsByName("phase");
    var j = 0;
    var n = 1;

    phase[j].value = "<%=progresses.get(0)%>";

    console.log("<%=progresses.size()%>" + " 개수 " + "<%=ingredients.size()%>");
    for (j = 1; j < <%=progresses.size()%>; j++) {

        n += 1;
        var addsteptest =
            '<tr name="put-step">' +
            '<td>단계 ' + n + '</td>' +
            '<td><input type="text" name="phase" size="40" class="phase"></td>' +
            '</tr>';
        var trHtml = $("tr[name=put-step]:last");//last로 사용하여 put-step라는 명을 가진 마지막 태그 호출
        trHtml.after(addsteptest);//그 태그 뒤에 붙이기
    }
    <%
        for (int k = 1; k < progresses.size(); k++) {
    %>
    phase[<%=k%>].value = "<%=progresses.get(k)%>";
    <%
        }
    %>

</script>

<script>
    $(document).on("click", "button[name=put-step]", function () {
        n += 1;
        var addsteptest =
            '<tr name="put-step">' +
            '<td>단계 ' + n + '</td>' +
            '<td><input type="text" name="phase" size="40" class="phase"></td>' +
            '</tr>';
        var trHtml = $("tr[name=put-step]:last");//last로 사용하여 put-step라는 명을 가진 마지막 태그 호출
        trHtml.after(addsteptest);//그 태그 뒤에 붙이기
    });
    $(document).on("click", "button[name=put-in]", function () {
        var addIngredient =
            '<input type="text" name="ingredient" size="10" class="ingredient">';
        var tdHtml = $("input[name=ingredient]:last");
        tdHtml.after(addIngredient);
    });

</script>
</body>

</body>
</html>
