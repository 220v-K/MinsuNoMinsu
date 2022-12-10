<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/11
  Time: 3:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.String" %>
<%@ page import="static java.sql.JDBCType.NULL" %>
<html>
<head>
    <title>레시피 등록</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    // fetch input data from recipesave.html
    String recipetitle = request.getParameter("recipetitle");
    String recipeintro = request.getParameter("recipeintro");
    String categoryString = request.getParameter("category");
    String personnelString = request.getParameter("personnel");
    String timetakenString = request.getParameter("timetaken");
    String difficultyString = request.getParameter("difficulty");
    String phase1 = request.getParameter("phase1");
    String phase2 = request.getParameter("phase2");

    System.out.println("데이터 가져오기 성공");

    // combine phases to String array
    String[] phases = {phase1, phase2};

    // cast String to int
    int recipecategory = Integer.parseInt(categoryString);
    int personnel = Integer.parseInt(personnelString);
    int timetaken = Integer.parseInt(timetakenString);
    int difficulty = Integer.parseInt(difficultyString);


    // print out input data
    System.out.println(recipetitle);
    System.out.println(recipeintro);
    System.out.println(recipecategory);
    System.out.println(personnel);
    System.out.println(timetaken);
    System.out.println(difficulty);
    System.out.println(phase1);
    System.out.println(phase2);


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


        Date uploadTime = new java.sql.Date(System.currentTimeMillis());
        String userEmail = (String) session.getAttribute("email");

        // check user email is null or not
        if (userEmail == null) {
            System.out.println("email is null");
            out.println("<script>alert('로그인 후 진행하세요.'); history.back();</script>");
            throw new Exception();
        }

        // check if recipe title is already in database
        String sql = "SELECT * FROM recipe WHERE recipeName = '" + recipetitle + "'";
        resultSet = statement.executeQuery(sql);

        // if recipe title is already in database, print out error message and go back to recipesave.html
        if (resultSet.next()) {
            out.println("<script>alert('이미 존재하는 이름의 레시피입니다.'); history.back();</script>");
            throw new Exception();
        }


        // insert data into recipe table
        sql = "INSERT INTO recipe ( recipeName, recipeExplain, recipeCategory, forNperson, withInTime, difficulty, recipeUploadTime, userEmail) " +
                "VALUES ('" + recipetitle + "', '" + recipeintro + "', '" + recipecategory + "', '" + personnel + "', '" + timetaken + "', '" + difficulty + "', '" + uploadTime + "', '" + userEmail + "')";
        statement.executeUpdate(sql);

        // get recipeNo
        sql = "SELECT recipeNo FROM recipe WHERE recipeName = '" + recipetitle + "'";
        resultSet = statement.executeQuery(sql);

        // insert phases data into Progress table
        if (resultSet.next()) {
            int recipeNo = resultSet.getInt("recipeNo");
            for (int i = 0; i < phases.length; i++) {
                int progressNo = i + 1;
                sql = "INSERT INTO progress(progressOrder, progressText, recipeNo) " +
                        " VALUES ('" + progressNo + "', '" + phases[i] + "', '" + recipeNo + "')";
                statement.executeUpdate(sql);
            }
        }

        // alert message
        System.out.println("레시피 등록 성공");
        out.println("<script>alert('레시피가 등록되었습니다.'); history.back();</script>");

    } catch (Exception exception) {
        //error message
        out.println(exception.getMessage());
    }
%>

<script>
</script>

</body>
</html>
