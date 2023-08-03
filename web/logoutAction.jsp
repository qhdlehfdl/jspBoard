<%--
  Created by IntelliJ IDEA.
  User: brian
  Date: 2023-07-13
  Time: 오후 4:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
    <title>jsp 게시판 웹사이트</title>
</head>
<body>
<%
    session.invalidate();
%>
<script>
    location.href = 'main.jsp';
</script>
</body>
</html>

