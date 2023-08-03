<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="comment.CommentDAO" %>
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
    request.setCharacterEncoding("utf-8");//한글 깨짐 방지
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
    <dic class="row">
        <form method="post" action="searchBbs.jsp">
            <select style="width: 10%; float: left;" class="form-control" name="searchCol">
                <option value="bbsTitle">제목</option>
                <option value="userID">작성자</option>
            </select>
            <input class="form-control" style="width: 80%; float: left;" type="text" placeholder="검색어 입력" maxlength="100" name="searchContent">
            <button type="submit" class="btn btn-success">검색</button>
        </form>
    </dic>
</div>

<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
            <tr>
                <th style="background-color:#eeeeee; text-align: center;">번호</th>
                <th style="background-color:#eeeeee; text-align: center;">제목</th>
                <th style="background-color:#eeeeee; text-align: center;">작성자</th>
                <th style="background-color:#eeeeee; text-align: center;">작성일</th>
                <th style="background-color:#eeeeee; text-align: center;">조회수</th>
                <th style="background-color:#eeeeee; text-align: center;">댓글 수</th>
            </tr>
            </thead>
            <tbody>
            <%
                BbsDAO bbsDAO = new BbsDAO();
                ArrayList<Bbs> list = bbsDAO.getSearchList(request.getParameter("searchCol"), request.getParameter("searchContent"));

                if (list.size() == 0) {
            %>
                <tr>
                    <td>검색 결과가 없습니다.</td>
                </tr>
            <%
                }else{
                    CommentDAO commentDAO = new CommentDAO();
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <td><%=list.get(i).getBbsID()%></td>
                <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></a</td>
                <td><%=list.get(i).getUserID()%></td>
                <td><%=list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분"%></td>
                <td><%=list.get(i).getBbsHits()%></td>
                <td><%=commentDAO.countComment(list.get(i).getBbsID())%></td>
            </tr>
            <%
                }
            %>
            <%
            }
            %>
            </tbody>
        </table>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>

