<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%request.setCharacterEncoding("UTF-8"); %>
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
  int commentID=0;
  if (request.getParameter("commentID") != null) {
    commentID = Integer.parseInt(request.getParameter("commentID"));
  }
  String commentContent=null;
  if (request.getParameter("commentContent")!=null) {
    commentContent = request.getParameter("commentContent");
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
    if(comment.getCommentContent().equals("")){
      PrintWriter script=response.getWriter();
      script.println("<script>");
      script.println("alert('입력이 안 된 사항이 있습니다.')");
      script.println("history.back()");
      script.println("</script>");
    }else {
      int result = new CommentDAO().update(commentContent,commentID);
      if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글수정에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
      } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("window.close()"); //팝업창 닫기
        script.println("</script>");
      }
    }
  }


%>
</body>
</html>

