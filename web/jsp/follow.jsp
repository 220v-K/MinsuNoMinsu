<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/12
  Time: 3:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>팔로우</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String targetEmail = request.getParameter("targetEmail");
    //session에서 email 가져오기
    String email = (String) session.getAttribute("email");

    System.out.println("myEmail : " + email);


    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        if (email == null) {
            // if email is null, redirect to login page
            throw new Exception();
        }

        if(email.equals(targetEmail)){
            out.println("<script>alert('자신을 팔로우할 수 없습니다.'); history.back();</script>");
            return;
        }

        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
        connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
        statement = connection.createStatement();
        // insert into follow table
        String sql = "INSERT INTO User_Follow (follower, followee) VALUES ('" + email + "', '" + targetEmail + "')";

        statement.executeUpdate(sql);

        // fetch followee nickname
        sql = "SELECT * FROM user WHERE email = '" + targetEmail + "'";
        resultSet = statement.executeQuery(sql);
        String followeeNickname = "";
        if (resultSet.next()) {
            followeeNickname = resultSet.getString("nickname");
        }


        out.println("success");
        out.println("<script>alert('" + followeeNickname + "을 팔로우 하였습니다.'); history.back();</script>");
    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
        // alert error message and popup popup.html and back
        session.removeAttribute("email");
        out.println("<script>alert('로그인이 필요한 기능입니다.');</script>");
        out.println("<script> window.open(\"../html/popup.html\", \"팝업\", \"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0\");\n</script>");
        out.println("<script>history.back();</script>");
    }
%>

</body>
</html>
