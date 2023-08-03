<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="likey.LikeDAO" %>
<jsp:useBean id="like" class="likey.Like" scope="page"/>
<jsp:setProperty name="like" property="likeyType"/>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
    <title>jsp 게시판 웹사이트</title>
</head>
<body>
<%
    String userID = null;

    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href='login.jsp'");
        script.println("</script>");
    }
    int bbsID=0;
    if (request.getParameter("bbsID") != null) {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0) {
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다.')");
        script.println("location.href='bbs.jsp'");
        script.println("</script>");
    }

    LikeDAO likeDAO = new LikeDAO();
    String likeyType = null;
    if (request.getParameter("likey") != null) { //name=likey value=like or unlike
        likeyType = request.getParameter("likey");
    } else if (request.getParameter("likey") != null) {
        likeyType = request.getParameter("likey");
    }

    int result = likeDAO.click(userID, bbsID, likeyType);
    if (result == -2) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 추천했습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('추천에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href='bbs.jsp'");
        script.println("</script>");
    }
%>
</body>
</html>

