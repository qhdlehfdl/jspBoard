<%--
  Created by IntelliJ IDEA.
  User: brian
  Date: 2023-07-13
  Time: 오전 10:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.util.ArrayList" %>
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
    else{
        PrintWriter script=response.getWriter();
        script.println("<script>");
        script.println("alert('에러입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    User user = new UserDAO().getUser(userID);
    String userName=user.getUserName();
    String userGender =user.getUserGender();
    String userEmail =user.getUserEmail();
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
            <li class="active"><a href="main.jsp">메인</a></li>
            <li><a href="bbs.jsp">게시판</a></li>
        </ul>

        <ul class="nav navbar-nav">
            <li ><a href="myInfo.jsp">내 정보</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle"
                   data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">회원관리<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="myInfo.jsp">내 정보</a></li>
                    <li ><a href="logoutAction.jsp">로그아웃</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

    <div class="pinkbox">
        <div class="line"></div>
    </div>
    <img src="images/4.png" class="profile">


<div class="jumbotron">
    <div class="container">
        <h1 style="float: left;"><%=userName%></h1>
        <a onclick="OpenWindow()" class="btn" style="clear:left; margin-top: 50px">정보수정</a>
        <h2><%=userGender%></h2>
        <h2><%=userEmail%></h2>
        <h2>내가 쓴 글</h2>
        <div class="container">
            <%
                ArrayList<BbsDAO.Pair> list = new BbsDAO().getPost(userID);
                for (int i = 0; i < list.size(); i++) {
            %>
                    <ul>
                        <li><a href="view.jsp?bbsID=<%=list.get(i).getID()%>"><%=list.get(i).getS().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></a></li>
                    </ul>
            <%
                }
            %>

        </div>

    </div>
</div>

<script type="text/javascript">
    function OpenWindow() {
        //window.name = "Parent";
        var url = "myInfoUpdateWindow.jsp";
        window.open(url,"_blank","width=500, height=500");
    }
</script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>


