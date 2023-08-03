<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String userID=null;

    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
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
<div class="container">
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
        <div class="jumbotron" style="padding-top:20px">
            <form method="post" action="myInfoUpdateAction.jsp?">
                <h3 style="text-align:center;">회원정보 수정 화면</h3>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
                </div>
                <div class="form-group" style="text-align: center;">
                    <div class="btn-group" data-toggle="buttons">
                        <label class="btn btn-primary active">
                            <input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
                        </label>
                        <label class="btn btn-primary ">
                            <input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
                </div>
                <input type="submit" class="btn btn-primary form-control" value="회원가입">
            </form>
        </div>
    </div>
    <div class="col-lg-4"></div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>