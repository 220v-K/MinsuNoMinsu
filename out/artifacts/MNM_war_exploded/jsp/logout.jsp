<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/12
  Time: 4:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<html>
<head>
    <title>로그아웃</title>
</head>
<body>
<%
  session.removeAttribute("email");
  out.println("<script>alert('로그아웃 하였습니다.'); location.href='main.jsp'</script>");
%>

</body>
</html>
