<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%request.setCharacterEncoding("UTF-8"); %>
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
  int bbsID=0;
  if (request.getParameter("bbsID") != null) {
    System.out.println(request.getParameter("bbsID"));
    System.out.println(Integer.parseInt(request.getParameter("bbsID")));
    bbsID = Integer.parseInt(request.getParameter("bbsID"));
  }
  if (bbsID == 0) {
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('유효하지 않은 글입니다.')");
    script.println("location.href='bbs.jsp'");
    script.println("</script>");
  }
  int commentID=0;
  if (request.getParameter("commentID") != null) {
    commentID = Integer.parseInt(request.getParameter("commentID"));
  }
  if (commentID == 0) {
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('유효하지 않은 댓글입니다.')");
    script.println("history.back()");
    script.println("</script>");
  }
  Comment comment = new CommentDAO().getComment(commentID);
  if (!userID.equals(comment.getUserID())) {
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('권한이 없습니다.')");
    script.println("location.href='bbs.jsp'");
    script.println("</script>");
  } else{
      CommentDAO commentDAO = new CommentDAO();
      int result = commentDAO.delete(commentID);
      if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('댓글 삭제에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
      } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('삭제되었습니다')");
        script.println("history.back()");
        script.println("</script>");
      }
  }


%>
</body>
</html>

