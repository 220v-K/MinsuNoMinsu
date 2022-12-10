<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/11
  Time: 1:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>

<html>
<head>
    <title>SignUp</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    // fetch input data from popup.html
    String id = request.getParameter("id");
    String pw = request.getParameter("passwd");


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
        // check id exists
        String sql = "SELECT * FROM user WHERE id = '" + id + "'";
        resultSet = statement.executeQuery(sql);
        // if id exists, check password
        if (resultSet.next()) {
            // if password is correct, make session
            if (resultSet.getString("password").equals(pw)) {
                HttpSession loginSession = request.getSession(true);
                // 세션이 새로 생성되었다면, atrribute 추가
                if (loginSession.isNew()) {
                    out.println("새로운 세션 생성");
                    loginSession.setAttribute("id", id);
                    loginSession.setAttribute("pw", pw);
                }
                // 세션이 새로 생성되지 않았다면, attribute 변경
                else {
                    out.println("기존 세션 사용");
                    loginSession.setAttribute("id", id);
                    loginSession.setAttribute("pw", pw);
                }
                // 로그인 성공 시 alert
                out.println("<script>alert('로그인 성공!');</script>");
                // 이후 부모 페이지를 새로고침
                out.println("<script>opener.location.reload();</script>");
                // 팝업창 닫기
                out.println("<script>self.close();</script>");

            } else {
                // if password is incorrect, alert
                out.println("<script>alert('비밀번호가 틀렸습니다.'); history.back();</script>");
            }
        } else {
            // if id doesn't exist, alert
            out.println("<script>alert('아이디가 존재하지 않습니다.'); history.back();</script>");
        }
    } catch (Exception exception) {
        out.println("DB 연동 오류: " + exception.getMessage());
    }
%>

<script>
</script>

</body>
</html>

