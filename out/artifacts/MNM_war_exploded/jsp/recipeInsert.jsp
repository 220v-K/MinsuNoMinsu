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
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="static java.sql.JDBCType.NULL" %>
<%@ page import="java.util.Enumeration" %>

<html>
<head>
    <title>레시피 등록</title>
</head>
<body>
<%
    String saveFolder = application.getRealPath("/fileStorage");
    int fileSize = 5 * 1024 * 1024; // 5MB
    String encType = "UTF-8";

    MultipartRequest multi = null;
    try {
        multi = new MultipartRequest(request, saveFolder, fileSize, encType, new DefaultFileRenamePolicy());
    } catch (Exception e) {
        System.out.println("파일 업로드 실패 " + e.getMessage());
        e.printStackTrace();
    }

    Enumeration<?> files = multi.getFileNames();
    String fileName = "";
    String originalFileName = "";
    String contentType = "";
    String length = "";
    if (files.hasMoreElements()) {
        String element = (String) files.nextElement();

        fileName = multi.getFilesystemName(element);
        originalFileName = multi.getOriginalFileName(element);
        contentType = multi.getContentType(element);
        length = String.valueOf(multi.getFile(element).length());

        System.out.println("파일 이름 : " + fileName + "<br>");
        System.out.println("원본 파일 이름 : " + originalFileName + "<br>");
        System.out.println("파일 타입 : " + contentType + "<br>");
        System.out.println("파일 크기 : " + length + "<br>");
    }

    // fetch input data from recipesave.html
    String recipetitle = multi.getParameter("recipetitle");
    String recipeintro = multi.getParameter("recipeintro");
    String categoryString = multi.getParameter("category");
    String personnelString = multi.getParameter("personnel");
    String timetakenString = multi.getParameter("timetaken");
    String difficultyString = multi.getParameter("difficulty");
    String[] progresses = multi.getParameterValues("phase");
    String[] ingredients = multi.getParameterValues("ingredient");

    System.out.println("데이터 가져오기 성공");

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
        sql = "INSERT INTO recipe ( recipeName, recipeExplain, recipeCategory, forNperson, withInTime, difficulty, recipeUploadTime, userEmail, filename) " +
                "VALUES ('" + recipetitle + "', '" + recipeintro + "', '" + recipecategory + "', '" + personnel + "', '" + timetaken + "', '" + difficulty + "', '" + uploadTime + "', '" + userEmail + "', '" + fileName +"')";
        statement.executeUpdate(sql);

        // get recipeNo
        sql = "SELECT recipeNo FROM recipe WHERE recipeName = '" + recipetitle + "'";
        resultSet = statement.executeQuery(sql);

        // insert progresses data into Progress table
        if (resultSet.next()) {
            int recipeNo = resultSet.getInt("recipeNo");
            for (int i = 0; i < progresses.length; i++) {
                int progressNo = i + 1;
                sql = "INSERT INTO progress(progressOrder, progressText, recipeNo) " +
                        " VALUES ('" + progressNo + "', '" + progresses[i] + "', '" + recipeNo + "')";
                statement.executeUpdate(sql);
            }
        }

        // get recipeNo
        sql = "SELECT recipeNo FROM recipe WHERE recipeName = '" + recipetitle + "'";
        resultSet = statement.executeQuery(sql);

        // insert ingredients data into Ingredient table
        if (resultSet.next()) {
            int recipeNo = resultSet.getInt("recipeNo");
            for (int i = 0; i < ingredients.length; i++) {
                sql = "INSERT INTO ingredient(ingredientName, ingredientAmount, recipeNo) " +
                        " VALUES ('" + ingredients[i] + "', '" + "0" + "', '" + recipeNo + "')";
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
