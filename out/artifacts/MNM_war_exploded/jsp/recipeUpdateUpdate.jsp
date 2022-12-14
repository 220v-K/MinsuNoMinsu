<%--
  Created by IntelliJ IDEA.
  User: jaewonlee
  Date: 2022/12/11
  Time: 10:46 PM
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
    <title>레시피 수정</title>
</head>
<body>
<%
    String saveFolder = application.getRealPath("/fileStorage");
    int fileSize = 5 * 1024 * 1024; // 5MB
    String encType = "UTF-8";

    MultipartRequest multi = null;
    try {
        multi = new MultipartRequest(request, saveFolder, fileSize, encType);
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

        // fetch recipe data from database
        String sql = "SELECT * FROM recipe WHERE recipeName = '" + recipetitle + "'";
        resultSet = statement.executeQuery(sql);

        // check user email is same as recipe uploader
        if (resultSet.next()) {
            String recipeUploader = resultSet.getString("userEmail");
            // if user email is not same as recipe uploader, alert and go back to recipe page
            if (!recipeUploader.equals(userEmail)) {
                out.println("<script>alert('수정 권한이 없습니다.'); history.back();</script>");
            }
        }

        // get recipeNo
        sql = "SELECT recipeNo FROM recipe WHERE recipeName = '" + recipetitle + "'";
        resultSet = statement.executeQuery(sql);

        int recipeNo = 0;

        // if recipe title is not exist in database, print out error message and go back to recipesave.html
        if (!resultSet.next()) {
            System.out.println("recipe title is not exist");
            out.println("<script>alert('존재하는 레시피가 아닙니다.'); history.back();</script>");
            throw new Exception();
        }
        recipeNo = resultSet.getInt("recipeNo");


        // update recipe data
        sql = "UPDATE recipe SET recipeName = '" + recipetitle + "', recipeExplain = '" + recipeintro + "', recipeCategory = " + recipecategory + ", forNperson = " + personnel + ", withInTime = " + timetaken + ", difficulty = " + difficulty + ", filename = '" + fileName + "' WHERE recipeNo = '" + recipeNo + "'";
        statement.executeUpdate(sql);


        // update recipe progress
        // delete all progress data
        sql = "DELETE FROM progress WHERE recipeNo = '" + recipeNo + "'";
        statement.executeUpdate(sql);

        // insert new progress data
        for (int i = 0; i < progresses.length; i++) {
            int progressNo = i + 1;
            if (progresses[i].equals("") || progresses[i] == null) {
                continue;
            }
            sql = "INSERT INTO progress (progressOrder, progressText, recipeNo) VALUES ('" + progressNo + "', '" + progresses[i] + "', '" + recipeNo + "')";
            statement.executeUpdate(sql);
        }


        // update recipe ingredient
        // delete all ingredient data
        sql = "DELETE FROM ingredient WHERE recipeNo = '" + recipeNo + "'";
        statement.executeUpdate(sql);

        // insert new ingredient data
        for (int i = 0; i < ingredients.length; i++) {
            if (ingredients[i].equals("") || ingredients[i] == null) {
                continue;
            }
            sql = "INSERT INTO ingredient (ingredientName, ingredientAmount, recipeNo) VALUES ('" + ingredients[i] + "', '" + 0 + "', '" + recipeNo + "')";
            statement.executeUpdate(sql);
        }

        // alert message
        System.out.println("레시피 수정 성공");
        out.println("<script>alert('레시피가 수정되었습니다.'); history.back();</script>");

    } catch (Exception exception) {
        //error message
        out.println(exception.getMessage());
    }
%>

<script>
</script>

</body>
</html>
