<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/12
  Time: 2:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    // fetch input data
    String comment = request.getParameter("comment");
    int recipeNo = Integer.parseInt(request.getParameter("recipeNo"));


    // fetch email from session
    String email = (String) session.getAttribute("email");

    System.out.println("email: " + email);

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

        Date uploadTime = new java.sql.Date(System.currentTimeMillis());

        Class.forName("com.mysql.jdbc.Driver");
        String jdbcUrl = "jdbc:mysql://localhost:3306/MNM?serverTimezone=UTC";
        connection = DriverManager.getConnection(jdbcUrl, "root", "02220222");
        statement = connection.createStatement();
        // insert comment into comment table
        String sql = "INSERT INTO comment (commentText, commentTime, userEmail, recipeNo) VALUES ('" + comment + "', '" + uploadTime + "', '" + email + "', '" + recipeNo + "')";
        // execute query
        statement.executeUpdate(sql);

        out.println("success");
        out.println("<script>alert('댓글 작성에 성공했습니다.'); history.back();</script>");
    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
        // alert error message and popup popup.html and back
        session.removeAttribute("email");
        out.println("<script> window.open(\"../html/popup.html\", \"팝업\", \"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=675, height=480, left=0, top=0\");\n</script>");
        out.println("<script>alert('로그인이 필요한 기능입니다.'); history.back();</script>");
    }
%>

</body>
</html>
