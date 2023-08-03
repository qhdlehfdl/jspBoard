<%--
  Created by IntelliJ IDEA.
  User: brian
  Date: 2023-07-13
  Time: 오후 4:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.io.File" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
  <title>jsp 게시판 웹사이트</title>
</head>
<body>
<%
  String userID=null;

  //사진
  String realFolder = "";
  String saveFolder="contents";//사진 저장 경로
  String encType = "utf-8";
  int maxSize=5*1024*1024; //5MB

  ServletContext context = this.getServletConfig().getServletContext();
  realFolder = context.getRealPath(saveFolder);
  MultipartRequest multi = null;
  //파일업로드를 직접적으로 담당
  multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

  String fileName = multi.getFilesystemName("fileName");
  String bbsTitle = multi.getParameter("bbsTitle");
  String bbsContent = multi.getParameter("bbsContent");

  //multipart/form-data 사용하면 직접 할당해줘야함 set property 효과 없음
  bbs.setBbsTitle(bbsTitle);
  bbs.setBbsContent(bbsContent);

  if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
  }
  if (userID == null) {
    PrintWriter script=response.getWriter();
    script.println("<script>");
    script.println("alert('로그인을 하세요.')");
    script.println("location.href='login.jsp'");
    script.println("</script>");
  }else{
    if(bbs.getBbsTitle()==null || bbs.getBbsContent()==null){
      PrintWriter script=response.getWriter();
      script.println("<script>");
      script.println("alert('입력이 안 된 사항이 있습니다.')");
      script.println("history.back()");
      script.println("</script>");
    }else {
      BbsDAO bbsDAO = new BbsDAO();
      int result = bbsDAO.write(bbs.getBbsTitle(),userID,bbs.getBbsContent(),fileName);
      if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글쓰기에 실패했습니다.')");
        script.println("history.back()");
        script.println("</script>");
      } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href='bbs.jsp'");
        script.println("</script>");
      }
    }
  }


%>
</body>
</html>

