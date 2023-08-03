<%--
  Created by IntelliJ IDEA.
  User: brian
  Date: 2023-07-13
  Time: 오후 4:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
  <title>jsp 게시판 웹사이트</title>
</head>
<body>
<%
  String userID=null;
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
  if(user.getUserID()==null || user.getUserPassword()==null || user.getUserName()==null || user.getUserGender()==null || user.getUserEmail()==null){
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('입력이 안 된 사항이 있습니다.')");
    script.println("history.back()");
    script.println("</script>");
  }else{
    UserDAO userDAO = new UserDAO();
    int result = userDAO.update(user.getUserID(), user.getUserPassword(), user.getUserName(), user.getUserGender(), user.getUserEmail(),userID);
    if (result == -1) {
      PrintWriter script=response.getWriter();
      script.println("<script>");
      script.println("alert('이미 존재하는 아이디입니다.')");
      script.println("history.back()");
      script.println("</script>");
    }
    else {
      PrintWriter script=response.getWriter();
      script.println("<script>");
      script.println("window.opener.location.href='logoutAction.jsp'");
      script.println("window.close()");
      script.println("alert('다시 로그인하세요.')");
      script.println("</script>");
    }
  }

%>
</body>
</html>
