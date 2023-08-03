<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
  int bbsID=0;
  int commentID=0;
  String userID=null;

  if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
  }
  if (request.getParameter("bbsID")!=null) {
    bbsID = Integer.parseInt(request.getParameter("bbsID"));
  }
  if (request.getParameter("commentID")!=null) {
    commentID = Integer.parseInt(request.getParameter("commentID"));
  }
%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet"href="css/bootstrap.css">
  <link rel="stylesheet"href="css/custom.css">
  <meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
  <meta name="viewport" content="width=device-width" , initial-scale="1">
  <title>jsp 게시판 웹사이트</title>
</head>
<body>
<form
<div class="container" style="padding-top:60px;">
  <div class="row">
    <form method="post" enctype="utf-8" action="commentUpdateAction.jsp?bbsID=<%=bbsID%>&commentID=<%=commentID%>">
      <table class="table table-striped" style="text-align: center;  border: 1px solid #dddddd">
        <tr>
          <td style="border-bottom:none;" valign="middle"><br><br><%=userID %></td>
          <td><textarea style="height:100px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다." name = "commentContent"></textarea></td>
          <td><input style ="height:100px;" type="submit" class="btn-primary pull" value="댓글 수정"></td>
        </tr>
      </table>
    </form>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>