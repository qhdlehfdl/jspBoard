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
<%@ page import="java.util.ArrayList" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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

            <%
                if (userID != null) {
            %>
            <li ><a href="myInfo.jsp">내 정보</a></li>
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
    <div class="jumbotron">
        <div class="container">
            <h1>헬스헬스헬스</h1>
            <p>이곳은 헬스에 대해 이야기하는 곳입니다. 자유롭게 이야기를 나누어 보세요. </p>
            <p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
        </div>
    </div>

    <hr class="col-sm-12">

    <div class="row g-5">
        <div class="col-lg-6">
            <h2 class="text-center-emphasis">실시간 댓글이 많은 글</h2>
            <ul class="list-unstyled">

                <%
                    ArrayList<Bbs> list = new BbsDAO().getPopularBbs();
                    for (int i = 0; i < list.size(); i++) {
                %>
                <li > <a class="glyphicon glyphicon-menu-right" href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></a></li>
                <%
                    }
                %>
                <li></li>
            </ul>
        </div>

        <div class="col-lg-6">
            <h2 class="text-center-emphasis">실시간 조회수가 많은 글</h2>
            <ul class="list-unstyled">

                <%
                    ArrayList<Bbs> list2=new BbsDAO().getMostHitsBbs();
                    for (int i = 0; i < list2.size(); i++) {
                %>
                <li > <a class="glyphicon glyphicon-menu-right" href="view.jsp?bbsID=<%=list2.get(i).getBbsID()%>"><%=list2.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></a></li>
                <%
                    }
                %>
                <li></li>
            </ul>
        </div>
    </div>
</div>


<div class="container">
    <div id="myCarousel" class="carousel slide" date-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="myCarousel" data-slide-to="1" ></li>
            <li data-target="myCarousel" data-slide-to="2" ></li>
            <li data-target="myCarousel" data-slide-to="3" ></li>
        </ol>
        <div class="carousel-inner">
            <div class="item active">
                <img src="images/5.jpg">
            </div>
            <div class="item">
                <img src="images/1.jpg">
            </div>
            <div class="item">
                <img src="images/2.jpg">
            </div>
            <div class="item">
                <img src="images/3.jpg">
            </div>
        </div>
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

</body>
</html>

