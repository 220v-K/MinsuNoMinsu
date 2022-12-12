<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/12
  Time: 2:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>

<html>
<head>
    <meta charset="utf-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <style> @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap'); </style>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <link rel="stylesheet" href="../css/top.css"/>
    <link rel="stylesheet" href="../css/mypagechange.css"/>
    <title>마이페이지 수정</title>
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
    // fetch email from session
    String email = (String) session.getAttribute("email");

    System.out.println("email: " + email);

    String nickname = "";
    String password = "";
    String introduce = "";
    String id = "";

    // connect to database

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    boolean connect = false;

    try {
        if (email == null) {
            // if email is null, redirect to login page
            throw new Exception();
        }
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
        connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
        statement = connection.createStatement();
        // fetch user data from database
        String sql = "SELECT * FROM user WHERE email = '" + email + "'";
        resultSet = statement.executeQuery(sql);

        if (resultSet.next()) {
            nickname = resultSet.getString("nickname");
            password = resultSet.getString("password");
            introduce = resultSet.getString("introduce");
            id = resultSet.getString("id");

            if (introduce == null) {
                introduce = "";
            }
        }

        System.out.println("nickname : " + nickname);
        System.out.println("password : " + password);
        System.out.println("introduce : " + introduce);
        System.out.println("id : " + id);


    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
        // alert error message and popup popup.html and back
        session.removeAttribute("email");
        out.println("<script> window.open(\"../html/popup.html\", \"팝업\", \"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0\");\n</script>");
        out.println("<script>alert('재 로그인이 필요합니다.'); history.back();</script>");
    }
%>


<div class="titlebox">
    <div class="title" onclick="location.href='../jsp/main.jsp';">MNM</div>
    <div class="icon1" onclick="openPopup();"><span class="material-symbols-outlined" style="color : green;">account_circle</span></div>
    <div class="icon2" onclick="location.href='../html/recipesave.html';"><span class="material-symbols-outlined"
                                                                                style="color : red;">edit</span></div>
</div>
<div class="subtitle"><h1>마이페이지</h1></div>
<div class="bar">
    <div onclick="location.href='./mypagechange.jsp';" class="bar-item">마이페이지 수정</div>
    <div onclick="location.href='./mypagerecipe.html';" class="bar-item">내 레시피 / 구독계정</div>
</div>
<div>
    <div class="box">
        <form method="POST" action="./userInfoUpdate.jsp">
            <table>
                <tr>
                    <td>내 아이디</td>
                    <td><input type="id" name="id" size="10" class="id" value="<%=id%>" readonly="readonly"></td>
                </tr>
                <tr>
                    <td>닉네임 입력</td>
                    <td><input type="text" name="nickname" size="40" class="nickname" id="nickname"
                               value="<%=nickname%>"></td>
                </tr>
                <tr>
                    <td>비밀번호 수정</td>
                    <td><input type="password" name="fixpassword" size="20" class="fixpassword" value="<%=password%>">
                    </td>
                </tr>
                <tr>
                    <td>자기 소개</td>
                    <td><input type="text" name="introme" size="30" class="introme" value="<%=introduce%>">
                    </td>
                </tr>
                <!-- <tr>
                    <td>내가 작성한 레시피</td>
                    <td><input type="text" name="myrecipe" size="30" class="myrecipe">             </td>
                    <td><center>
                    <input type="button" value="수정"class="subbutton"></center></td>
                </tr>
                <tr>
                    <td>구독한 계정</td>
                </tr> -->
            </table>
            <br><br>
            <center><input type="submit" id='recipereg' value="등록하기" class="button-save"></center>
        </form>

    </div>
</div>

</body>
</html>