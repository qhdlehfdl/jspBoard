<%--
  Created by IntelliJ IDEA.
  User: brian
  Date: 2023-07-13
  Time: 오후 4:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="comment.CommentDAO" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comment" class="comment.Comment" scope="page"/>
<jsp:setProperty name="comment" property="commentContent"/>
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
  int bbsID=0;
  if (request.getParameter("bbsID") != null) {
    bbsID = Integer.parseInt(request.getParameter("bbsID"));
  }
  if (bbsID == 0) {
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('유효하지 않은 글입니다.')");
    script.println("history.back()");
    script.println("</script>");
  }
  if (userID == null) {
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('로그인을 하세요.')");
    script.println("location.href='login.jsp'");
    script.println("</script>");
  }else{
    if(comment.getCommentContent()==null){
      PrintWriter script=response.getWriter();
      script.println("<script>");
      script.println("alert('입력이 안 된 사항이 있습니다.')");
      script.println("history.back()");
      script.println("</script>");
    }else {
      CommentDAO commentDAO = new CommentDAO();
      int result = commentDAO.write(bbsID,userID,comment.getCommentContent());
      if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('댓글 작성에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
      } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("history.back()");
        script.println("</script>");
      }
    }
  }


%>
</body>
</html>

