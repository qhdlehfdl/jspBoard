<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="likey.Like" %>
<%@ page import="likey.LikeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet"href="css/bootstrap.css">
    <link rel="stylesheet"href="css/custom.css">
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
        script.println("location.href='bbs.jsp'");
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID);
    ArrayList<Comment> list = new CommentDAO().getList(bbsID);

    //new BbsDAO().updateHits(bbsID); //조회수 증가

    ////쿠키 이용해서 조회수 무한 증가 방지
    Cookie viewCookie=null;
    Cookie[] cookies = request.getCookies();

    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].getName().equals(Integer.toString(bbsID))) {
                System.out.println("쿠키 이름 : "+cookies[i].getName());
                viewCookie=cookies[i];
                System.out.println("viewCookie : "+viewCookie);
            }
        }
    }

    if (viewCookie == null) {
        System.out.println("viewCookie 확인 로직 : 쿠키 없음");

        try {
            Cookie newCookie = new Cookie(Integer.toString(bbsID), "OK"); // 13.새로운 쿠기를 생성해서 (key,value) 값을 넣어줌
            response.addCookie(newCookie);                      // 14. 13번에서 쿠기 값을 넣어준거를 다시 클라이언트에다가 보내줌

            new BbsDAO().updateHits(bbsID); //조회수 증가
        } catch (Exception e) {
            System.out.println("쿠키 넣을때 오류");
            e.getStackTrace();
        }
    }
%>
<nav class="navbar nabvar-default">
    <div class="navbar-header">
        <button type="button" , class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li ><a href="main.jsp">메인</a></li>
            <li class="active"><a href="bbs.jsp">게시판</a></li>

            <%
                if (userID != null) {
            %>
            <li><a href="myInfo.jsp">내 정보</a></li>
            <%
                }
            %>
        </ul>
        <%
            if (userID == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li ><a href="login.jsp">로그인</a></li>
                    <li ><a href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
        <%
            }else{
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li ><a href="logoutAction.jsp">로그아웃</a></li>
                </ul>
            </li>
        </ul>
        <%
            }
        %>
    </div>
</nav>
<div class="container">
    <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color:#eeeeee; text-align: center;">게시판 글보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width:20%;">글 제목</td>
                        <td colspan="2"><%=bbs.getBbsTitle()%></td>
                    </tr>
                    <tr>
                        <td >작성자</td>
                        <td colspan="2"><%=bbs.getUserID()%></td>
                    </tr>
                    <tr>
                        <td >작성일자</td>
                        <td colspan="2"><%=bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분"%></td>
                    </tr>
                    <tr>
                        <td >내용</td>
                        <td colspan="2" style="min-height:200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></td>
                    </tr>
                    <%
                        if (bbs.getBbsImg()!=null) {
                    %>
                    <tr><td><img src="contents/<%=bbs.getBbsImg()%>" width="300px" height="300px"></td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

        <%
            ///좋아요 싫어요 개수 구함
            String col=null;
            LikeDAO likeDAO = new LikeDAO();
            int likeCnt= likeDAO.countLike(bbsID);
            int unlikeCnt=likeDAO.countUnlike(bbsID);

            if (likeCnt >= unlikeCnt)
                col="blue";
            else
                col = "red";
        %>

            <div style="text-align: center;">
                <form action="likeyAction.jsp?bbsID=<%=bbsID%>" method="post">
                    <button type="submit" name="likey" value="like" style="background: none; border: none;">
                        <img src="images/like.png" width="50px" height="50px">
                    </button>
                    <input type="button" value="<%=likeCnt-unlikeCnt%>" style="color: <%=col%>; font-weight: bold;">
                    <button type="submit" name="likey" value="unlike" style="background: none; border: none;">
                        <img src="images/unlike.png" width="50px" height="50px">
                    </button>
                </form>
            </div>

            <a href="bbs.jsp" class="btn btn-primary">목록</a>
            <%
                if (userID != null && userID.equals(bbs.getUserID())) {
            %>
                    <a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
                    <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
            <%
                }
            %>
            <input type="submit" class="btn btn-primary pull-right" value="글쓰기">
    </div>
</div>
<%

    if (userID!=null) {
        //로그인이 되어 있을때
%>
<div class="container" style="padding-top:60px;">
    <div class="row">
    <form method="post" enctype="utf-8" action="commentAction.jsp?bbsID=<%=bbsID%>">
        <table class="table table-striped" style="text-align: center;  border: 1px solid #dddddd">
            <tr>
                <td style="border-bottom:none;" valign="middle"><br><br><%=userID %></td>
                <td><textarea style="height:100px;" class="form-control" placeholder="상대방을 존중하는 댓글을 남깁시다." name = "commentContent"></textarea></td>
                <td><input style="height:100px; border-bottom: none;" type="submit" class="btn-primary pull" value="댓글 작성"></td>
            </tr>
        </table>
    </form>
    </div>
</div>
<%
    if(list.size()>0){
%>
<div class="container" style="padding-top:60px">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th colspan="3" style="background-color:#eeeeee; text-align: center; ">댓글</th>
            </tr>
            </thead>
            <tbody style="width: 100px;">
            <%
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td colspan="3" style="text-align: left; ">
                    <div>
                        <div style="float: left; padding-right: 20px;"><%=list.get(i).getUserID().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></div>
                        <div><%=list.get(i).getCommentDate().substring(0,11)+list.get(i).getCommentDate().substring(11,13)+"시"+list.get(i).getCommentDate().substring(14,16)+"분"%></div>
                        <%
                            if(userID.equals(list.get(i).getUserID())){
                                //자기가 쓴 글만 보임
                        %>
                        <div style="text-align: right; cursor:pointer;"><a  type="submit" onclick="commentUpdateWindow(<%=bbsID%>,<%=list.get(i).getCommentID()%>)">수정</a></div>
                        <div style="text-align: right; float: right;"><a onclick="return confirm('정말로 삭제하시겠습니까?')" type="submit" href="commentDeleteAction.jsp?bbsID=<%=bbsID%>&commentID=<%=list.get(i).getCommentID()%>">삭제</a></div>
                        <%
                        }
                        %>
                    </div>
                    <div><%=list.get(i).getCommentContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></div>
                </td>
            </tr>
            <%
                }
            %>

            </tbody>
        </table>
</div>
</div>
<%
    }
%>
<%
    }
%>
<script type="text/javascript">
    function commentUpdateWindow(bbsID, commentID) {
        window.name = "Parent";
        var url = "commentUpdateWindow.jsp?bbsID="+bbsID+"&commentID="+commentID;
        window.open(url,"_blank","width=500, height=500");
    }
</script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

</body>
</html>

