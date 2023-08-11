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
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet"href="css/bootstrap.css">
    <link rel="stylesheet"href="css/custom.css">
    <title>jsp 게시판 웹사이트</title>
    <style type="text/css">
        a, a:hover{
            color:#000000;
            text-decoration: none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script type="text/javascript">
        var searchRequest=new XMLHttpRequest();
        function searchFunction(){
            var searchSub = document.getElementsByName("searchCol")[0];
            //var index = searchSub.selectedIndex;
            searchRequest.open("Post", "./bbsSearchServlet?searchSub=" + encodeURIComponent(searchSub.options[searchSub.selectedIndex].value) +
                "&searchContent=" + encodeURIComponent(document.getElementById("searchContent").value), true);
            searchRequest.onreadystatechange=searchProcess;
            searchRequest.send(null);
        }
        function searchProcess(){
            var table=document.getElementById("searchResult");
            table.innerHTML="";
            if (searchRequest.readyState == 4 && searchRequest.status == 200) {
                var object = eval('(' + searchRequest.responseText + ')');
                var result = object.result;
                for (var i = 0; i < result.length; i++) {
                    var row = table.insertRow(0);
                    var bbsID = result[i][0].value;
                    for (var j = 0; j < result[i].length; j++) {
                        var cell = row.insertCell(j);
                        if(j==1){
                            var url = '<a href="view.jsp?bbsID=' + bbsID + '">'+result[i][j].value.replace(/\s/g,'&nbsp;').replace(/</g,'&lt;').replace(/>/,'&gt;').replace(/\n/,'<br>')+'</a>';
                            cell.innerHTML = url ;
                        }else if (j == 3) {
                            cell.innerHTML=result[i][j].value.substring(0,11)+result[i][j].value.substring(11,13)+"시"+result[i][j].value.substring(14,16)+"분";
                        } else
                            cell.innerHTML = result[i][j].value;
                    }
                }
            }
        }

        window.onload = function () {
            searchFunction();
        };
    </script>
</head>
<body>
<%
    String userID=null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    int pageNumber=1;
    if (request.getParameter("pageNumber") != null) {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
        <div>
            <select style="width: 10%; float: left;" class="form-control" name="searchCol">
                <option value="bbsTitle">제목</option>
                <option value="userID">작성자</option>
            </select>
            <input class="form-control" style="width: 80%; float: left;" type="text" placeholder="검색어 입력" maxlength="100" id="searchContent" onkeyup="searchFunction()">
            <button type="button" class="btn btn-success" onclick="searchFunction();">검색</button>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
            <thead>
                <tr>
                    <th style="background-color:#eeeeee; text-align: center;">번호</th>
                    <th style="background-color:#eeeeee; width: 30%; text-align: center;">제목</th>
                    <th style="background-color:#eeeeee; text-align: center;">작성자</th>
                    <th style="background-color:#eeeeee; text-align: center;">작성일</th>
                    <th style="background-color:#eeeeee; text-align: center;">조회수</th>
                    <th style="background-color:#eeeeee; text-align: center;">댓글 수</th>
                </tr>
            </thead>
            <%
                BbsDAO bbsDAO = new BbsDAO();
                ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                CommentDAO commentDAO=new CommentDAO();
            %>
            <tbody id="searchResult">
<%--                for (int i = 0; i < list.size(); i++) {--%>
<%--                <tr>--%>
<%--                <td><%=list.get(i).getBbsID()%></td>--%>
<%--                <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>")%></a</td>--%>
<%--                <td><%=list.get(i).getUserID()%></td>--%>
<%--                <td><%=list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분"%></td>--%>
<%--                <td><%=list.get(i).getBbsHits()%></td>--%>
<%--                <td><%=commentDAO.countComment(list.get(i).getBbsID())%></td>--%>
<%--                </tr>--%>
<%--            <%--%>
<%--                }--%>
<%--            %>--%>
            </tbody>
        </table>
        <%
            if (pageNumber != 1) {
        %>
            <a href="bbs.jsp?pageNumber=<%=pageNumber-1%>" class="btn btn-success btn-arrow-left">이전</a>
        <%
            }
            if (bbsDAO.nextPage(pageNumber+1)) {
        %>
            <a href="bbs.jsp?pageNumber=<%=pageNumber+1%>" class="btn btn-success btn-arrow-left">다음</a>
        <%
            }
        %>
        <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    </div>
</div>
</body>
</html>

